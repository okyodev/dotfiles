from dataclasses import dataclass, field
from datetime import datetime
from typing import Optional, AsyncGenerator
from enum import Enum
import asyncio
import json
import logging

logger = logging.getLogger(__name__)

# Enums
class Priority(Enum):
    LOW = 1
    MEDIUM = 2
    HIGH = 3
    CRITICAL = 4


@dataclass
class Task:
    id: int
    title: str
    priority: Priority = Priority.MEDIUM
    completed: bool = False
    tags: list[str] = field(default_factory=list)
    created_at: datetime = field(default_factory=datetime.now)
    assignee: Optional[str] = None

    def toggle(self) -> None:
        self.completed = not self.completed

    @property
    def is_urgent(self) -> bool:
        return self.priority.value >= Priority.HIGH.value

    def __str__(self) -> str:
        status = "done" if self.completed else "pending"
        urgent = " [URGENT]" if self.is_urgent else ""
        return f"[{status}] {self.title}{urgent}"


class TaskManager:
    MAX_TASKS = 1000

    def __init__(self, filepath: str = "tasks.json"):
        self.filepath = filepath
        self._tasks: dict[int, Task] = {}
        self._next_id = 1
        self._observers: list[callable] = []

    def subscribe(self, callback: callable) -> None:
        self._observers.append(callback)

    def _notify(self, event: str, task: Task) -> None:
        for observer in self._observers:
            try:
                observer(event, task)
            except Exception as e:
                logger.error(f"Observer error: {e}")

    def add(self, title: str, priority: Priority = Priority.MEDIUM,
            tags: Optional[list[str]] = None, assignee: Optional[str] = None) -> Task:
        if len(self._tasks) >= self.MAX_TASKS:
            raise ValueError(f"Maximum tasks ({self.MAX_TASKS}) reached")

        task = Task(
            id=self._next_id,
            title=title,
            priority=priority,
            tags=tags or [],
            assignee=assignee,
        )
        self._tasks[task.id] = task
        self._next_id += 1
        self._notify("added", task)
        return task

    def remove(self, task_id: int) -> bool:
        task = self._tasks.pop(task_id, None)
        if task:
            self._notify("removed", task)
            return True
        return False

    def find_by_tag(self, tag: str) -> list[Task]:
        return [t for t in self._tasks.values() if tag in t.tags]

    async def iter_tasks(self) -> AsyncGenerator[Task, None]:
        for task in self._tasks.values():
            yield task
            await asyncio.sleep(0)

    @property
    def stats(self) -> dict[str, int]:
        total = len(self._tasks)
        done = sum(1 for t in self._tasks.values() if t.completed)
        urgent = sum(1 for t in self._tasks.values() if t.is_urgent)
        return {"total": total, "done": done, "pending": total - done, "urgent": urgent}

    async def save(self) -> None:
        data = [
            {
                "id": t.id,
                "title": t.title,
                "priority": t.priority.name,
                "completed": t.completed,
                "tags": t.tags,
                "assignee": t.assignee,
            }
            for t in self._tasks.values()
        ]
        content = json.dumps(data, indent=2)
        loop = asyncio.get_event_loop()
        await loop.run_in_executor(None, lambda: open(self.filepath, "w").write(content))
        logger.info(f"Saved {len(data)} tasks to {self.filepath}")


# Decorator example
def retry(max_attempts: int = 3, delay: float = 1.0):
    def decorator(func):
        async def wrapper(*args, **kwargs):
            for attempt in range(1, max_attempts + 1):
                try:
                    return await func(*args, **kwargs)
                except Exception as e:
                    if attempt == max_attempts:
                        raise
                    logger.warning(f"Attempt {attempt}/{max_attempts} failed: {e}")
                    await asyncio.sleep(delay * attempt)
        return wrapper
    return decorator


@retry(max_attempts=3)
async def sync_tasks(manager: TaskManager, api_url: str) -> int:
    """Sync tasks from remote API."""
    import aiohttp
    async with aiohttp.ClientSession() as session:
        async with session.get(f"{api_url}/tasks") as resp:
            if resp.status != 200:
                raise ConnectionError(f"API returned {resp.status}")
            items = await resp.json()

    count = 0
    for item in items:
        manager.add(
            title=item["title"],
            priority=Priority[item.get("priority", "MEDIUM")],
            tags=item.get("tags", []),
        )
        count += 1
    return count


async def main():
    manager = TaskManager()

    manager.subscribe(lambda event, task: print(f"Event: {event} -> {task}"))

    t1 = manager.add("Setup project", Priority.HIGH, tags=["dev", "init"])
    t2 = manager.add("Write tests", tags=["dev", "testing"])
    t3 = manager.add("Deploy to prod", Priority.CRITICAL, assignee="ops-team")

    t1.toggle()

    async for task in manager.iter_tasks():
        print(task)

    print(f"\nStats: {manager.stats}")
    await manager.save()


if __name__ == "__main__":
    asyncio.run(main())
