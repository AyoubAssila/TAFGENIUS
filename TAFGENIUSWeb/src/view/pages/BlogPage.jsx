import React from "react";
import { useBlogViewModel } from "../../viewmodel/blog_viewmodel";
import NewPostModal from "../components/NewPostModal";
import PostCard from "../components/PostCard";

export default function BlogPage() {
  const { posts, addPost, deletePost, likePost, addComment } = useBlogViewModel();

  return (
    <div
      style={{
        minHeight: "100vh",
        padding: "80px 24px 40px",
        backgroundColor: "#f9fafb",
        display: "flex",
        justifyContent: "center",
        alignItems: "flex-start",
      }}
    >
      <div
        style={{
          maxWidth: "800px",
          width: "100%",
          backgroundColor: "white",
          borderRadius: "12px",
          padding: "32px",
          boxShadow: "0 4px 20px rgba(0,0,0,0.1)",
          display: "flex",
          flexDirection: "column",
          gap: "24px",
        }}
      >
        <h4 style={{ marginBottom: "16px", color: "#2563eb" }}>Blog Posts</h4>
        <NewPostModal onSave={addPost} />
        {posts.length === 0 ? (
          <p style={{ color: "#4b5563", textAlign: "center", fontSize: "16px" }}>
            No posts yet. Create your first post above.
          </p>
        ) : (
          posts.map((p) => (
            <PostCard
              key={p.id}
              post={p}
              onDelete={deletePost}
              onLike={likePost}
              onComment={addComment}
            />
          ))
        )}
      </div>
    </div>
  );
}
