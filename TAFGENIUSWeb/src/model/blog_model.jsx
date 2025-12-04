// src/Model/blog_model.jsx

export const BlogPostModel = {
  id: "",           // string ou number
  title: "",
  content: "",
  authorName: "",
  date: "",
  likes: 0,
  comments: [],     // tableau de { authorName, text, date }
};
