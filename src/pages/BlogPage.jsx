import React, { useState, useEffect } from "react";
import NewPostModal from "../components/NewPostModal";
import PostCard from "../components/PostCard";

function BlogPage() {
  const [posts, setPosts] = useState([]);

  useEffect(() => {
    const stored = localStorage.getItem("blog_posts");
    if (stored) setPosts(JSON.parse(stored));
  }, []);

  useEffect(() => {
    localStorage.setItem("blog_posts", JSON.stringify(posts));
  }, [posts]);

  const addPost = (post) => setPosts([post, ...posts]);

  const deletePost = (id) =>
    setPosts(posts.filter((p) => p.id !== id));

  const likePost = (id) =>
    setPosts(
      posts.map((p) => (p.id === id ? { ...p, likes: p.likes + 1 } : p))
    );

  const addComment = (postId, text) => {
    setPosts(
      posts.map((p) =>
        p.id === postId
          ? {
              ...p,
              comments: [
                ...p.comments,
                {
                  authorName: "Anonymous",
                  text,
                  date: new Date().toLocaleString(),
                },
              ],
            }
          : p
      )
    );
  };

  return (
    <div>
      <NewPostModal onSave={addPost} />
      {posts.length === 0 ? (
        <p className="text-muted text-center mt-5">
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
  );
}

export default BlogPage;
