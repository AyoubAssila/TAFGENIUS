import React from "react";
import { useBlogViewModel } from "../../viewmodel/blog_viewmodel";
import PostCard from "../components/PostCard";

export default function BlogPublicPage() {
  const { posts } = useBlogViewModel();

  return (
    <div
      style={{
        minHeight: "100vh",
        padding: "80px 24px 40px",
        backgroundColor: "#f9fafb",
        display: "flex",
        flexDirection: "column",
        gap: "24px",
      }}
    >
      {posts.length === 0 ? (
        <p
          style={{
            color: "#6b7280",
            textAlign: "center",
            marginTop: "50px",
            fontSize: "18px",
          }}
        >
          No posts available.
        </p>
      ) : (
        posts.map((p) => (
          <PostCard
            key={p.id}
            post={p}
            onDelete={undefined}
            onLike={undefined}
            onComment={undefined}
          />
        ))
      )}
    </div>
  );
}
