package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"sync"
	"time"
)

// Priority represents task priority level
type Priority int

const (
	PriorityLow      Priority = iota + 1
	PriorityMedium
	PriorityHigh
	PriorityCritical
)

// Task represents a work item
type Task struct {
	ID        string    `json:"id"`
	Title     string    `json:"title"`
	Priority  Priority  `json:"priority"`
	Done      bool      `json:"done"`
	Tags      []string  `json:"tags,omitempty"`
	CreatedAt time.Time `json:"created_at"`
}

// TaskStore defines the storage interface
type TaskStore interface {
	Get(ctx context.Context, id string) (*Task, error)
	List(ctx context.Context, filter *TaskFilter) ([]*Task, error)
	Create(ctx context.Context, task *Task) error
	Update(ctx context.Context, task *Task) error
	Delete(ctx context.Context, id string) error
}

// TaskFilter holds query parameters
type TaskFilter struct {
	Priority *Priority
	Done     *bool
	Tag      string
	Limit    int
}

// InMemoryStore implements TaskStore
type InMemoryStore struct {
	mu    sync.RWMutex
	tasks map[string]*Task
}

func NewInMemoryStore() *InMemoryStore {
	return &InMemoryStore{
		tasks: make(map[string]*Task),
	}
}

func (s *InMemoryStore) Get(ctx context.Context, id string) (*Task, error) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	task, ok := s.tasks[id]
	if !ok {
		return nil, fmt.Errorf("task %s not found", id)
	}
	return task, nil
}

func (s *InMemoryStore) List(ctx context.Context, filter *TaskFilter) ([]*Task, error) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	result := make([]*Task, 0, len(s.tasks))
	for _, t := range s.tasks {
		if filter != nil {
			if filter.Priority != nil && t.Priority != *filter.Priority {
				continue
			}
			if filter.Done != nil && t.Done != *filter.Done {
				continue
			}
			if filter.Tag != "" {
				found := false
				for _, tag := range t.Tags {
					if tag == filter.Tag {
						found = true
						break
					}
				}
				if !found {
					continue
				}
			}
		}
		result = append(result, t)
		if filter != nil && filter.Limit > 0 && len(result) >= filter.Limit {
			break
		}
	}
	return result, nil
}

func (s *InMemoryStore) Create(ctx context.Context, task *Task) error {
	s.mu.Lock()
	defer s.mu.Unlock()

	if _, exists := s.tasks[task.ID]; exists {
		return fmt.Errorf("task %s already exists", task.ID)
	}

	task.CreatedAt = time.Now()
	s.tasks[task.ID] = task
	return nil
}

func (s *InMemoryStore) Update(ctx context.Context, task *Task) error {
	s.mu.Lock()
	defer s.mu.Unlock()

	if _, exists := s.tasks[task.ID]; !exists {
		return fmt.Errorf("task %s not found", task.ID)
	}
	s.tasks[task.ID] = task
	return nil
}

func (s *InMemoryStore) Delete(ctx context.Context, id string) error {
	s.mu.Lock()
	defer s.mu.Unlock()

	if _, exists := s.tasks[id]; !exists {
		return fmt.Errorf("task %s not found", id)
	}
	delete(s.tasks, id)
	return nil
}

// HTTP Server
type Server struct {
	store  TaskStore
	router *http.ServeMux
}

func NewServer(store TaskStore) *Server {
	s := &Server{store: store, router: http.NewServeMux()}
	s.routes()
	return s
}

func (s *Server) routes() {
	s.router.HandleFunc("GET /tasks", s.handleListTasks)
	s.router.HandleFunc("POST /tasks", s.handleCreateTask)
	s.router.HandleFunc("GET /tasks/{id}", s.handleGetTask)
	s.router.HandleFunc("DELETE /tasks/{id}", s.handleDeleteTask)
}

func (s *Server) handleListTasks(w http.ResponseWriter, r *http.Request) {
	ctx, cancel := context.WithTimeout(r.Context(), 5*time.Second)
	defer cancel()

	tasks, err := s.store.List(ctx, nil)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(tasks)
}

func (s *Server) handleCreateTask(w http.ResponseWriter, r *http.Request) {
	var task Task
	if err := json.NewDecoder(r.Body).Decode(&task); err != nil {
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	if task.Title == "" {
		http.Error(w, "title is required", http.StatusBadRequest)
		return
	}

	task.ID = fmt.Sprintf("task-%d", time.Now().UnixNano())
	if err := s.store.Create(r.Context(), &task); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(task)
}

func (s *Server) handleGetTask(w http.ResponseWriter, r *http.Request) {
	id := r.PathValue("id")
	task, err := s.store.Get(r.Context(), id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(task)
}

func (s *Server) handleDeleteTask(w http.ResponseWriter, r *http.Request) {
	id := r.PathValue("id")
	if err := s.store.Delete(r.Context(), id); err != nil {
		http.Error(w, err.Error(), http.StatusNotFound)
		return
	}
	w.WriteHeader(http.StatusNoContent)
}

// Middleware
func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		next.ServeHTTP(w, r)
		log.Printf("%s %s %v", r.Method, r.URL.Path, time.Since(start))
	})
}

func main() {
	store := NewInMemoryStore()

	// Seed data
	seeds := []Task{
		{ID: "task-1", Title: "Setup CI/CD", Priority: PriorityHigh, Tags: []string{"devops"}},
		{ID: "task-2", Title: "Write unit tests", Priority: PriorityMedium, Tags: []string{"dev", "testing"}},
		{ID: "task-3", Title: "Deploy v2.0", Priority: PriorityCritical, Tags: []string{"release"}},
	}

	for i := range seeds {
		if err := store.Create(context.Background(), &seeds[i]); err != nil {
			log.Fatal(err)
		}
	}

	srv := NewServer(store)
	handler := loggingMiddleware(srv.router)

	addr := ":8080"
	log.Printf("Starting server on %s", addr)
	if err := http.ListenAndServe(addr, handler); err != nil {
		log.Fatal(err)
	}
}
