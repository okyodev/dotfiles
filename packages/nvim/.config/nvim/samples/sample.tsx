import React, { useState, useEffect, useMemo } from "react";
import { useRouter } from "next/navigation";
import type { User, ApiResponse } from "./types";
import clsx from "clsx";
import { cn } from "@/lib/utils";

interface CardProps {
  user: User;
  isActive?: boolean;
  onSelect: (id: string) => void;
}

const ITEMS_PER_PAGE = 20;

const Card: React.FC<CardProps> = ({ user, isActive = false, onSelect }) => {
  const [expanded, setExpanded] = useState(false);
  const router = useRouter();

  const displayName = useMemo(() => {
    return user.firstName ? `${user.firstName} ${user.lastName}` : user.email;
  }, [user]);

  useEffect(() => {
    if (isActive) {
      console.log("Card activated:", user.id);
    }
  }, [isActive, user.id]);

  const handleClick = async () => {
    try {
      const response = await fetch(`/api/users/${user.id}`);
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }
      const data: ApiResponse = await response.json();
      onSelect(data.id);
    } catch (error) {
      console.error("Failed:", error);
    }
  };

  return (
    <div
      className={cn(
        "relative flex items-center gap-4 p-4",
        isActive ? "bg-primary/10" : "bg-background",
        expanded && "ring-2 ring-primary",
      )}
      onClick={handleClick}
    >
      <img
        src={user.avatar ?? "/default.png"}
        alt={displayName}
        className="h-12 w-12 rounded-full"
      />
      <div className="flex-1 overflow-hidden">
        <h3 className={clsx("font-semibold", { "text-primary": isActive })}>
          {displayName}
        </h3>
        <p className="text-sm text-muted-foreground truncate">{user.email}</p>
        {user.role === "admin" && (
          <span className="text-xs bg-yellow-100 text-yellow-800 px-2 py-0.5 rounded">
            Admin
          </span>
        )}
      </div>
      <button
        onClick={(e) => {
          e.stopPropagation();
          setExpanded(!expanded);
        }}
        className="text-muted-foreground hover:text-foreground"
      >
        {expanded ? "Less" : "More"}
      </button>
      {expanded && (
        <div className="mt-2 text-sm">
          <p>ID: {user.id}</p>
          <p>Joined: {new Date(user.createdAt).toLocaleDateString()}</p>
          <p>Posts: {user.postsCount ?? 0}</p>
        </div>
      )}
    </div>
  );
};

export default Card;
