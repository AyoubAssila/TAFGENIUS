// src/ViewModel/blog_viewmodel.jsx
import { useState, useEffect } from "react";

export function useBlogViewModel() {
  const [posts, setPosts] = useState([]);

  // Charger les posts depuis localStorage
  useEffect(() => {
    const stored = localStorage.getItem("blog_posts");
    if (stored) setPosts(JSON.parse(stored));
  }, []);

  // Sauvegarder à chaque modification
  useEffect(() => {
    localStorage.setItem("blog_posts", JSON.stringify(posts));
  }, [posts]);

  const addPost = (post) => setPosts([post, ...posts]);

  const deletePost = (id) => setPosts(posts.filter((p) => p.id !== id));

  const likePost = (id) =>
    setPosts(
      posts.map((p) => (p.id === id ? { ...p, likes: (p.likes || 0) + 1 } : p))
    );

  const addComment = (postId, text) => {
    setPosts(
      posts.map((p) =>
        p.id === postId
          ? {
              ...p,
              comments: [
                ...(p.comments || []),
                { authorName: "Anonymous", text, date: new Date().toLocaleString() },
              ],
            }
          : p
      )
    );
  };

  return {
    posts,
    addPost,
    deletePost,
    likePost,
    addComment,
  };
}
