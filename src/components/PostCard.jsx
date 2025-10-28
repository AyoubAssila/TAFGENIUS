import React, { useState } from "react";
import CommentSection from "./CommentSection";
import ReactPlayer from "react-player";

function PostCard({ post, onDelete, onLike, onComment }) {
  const [showComments, setShowComments] = useState(false);

  const renderAttachment = (a) => {
    if (a.type === "image")
      return (
        <img
          src={a.url}
          alt={a.name}
          className="img-fluid rounded my-2"
          style={{ maxHeight: "300px" }}
        />
      );
    if (a.type === "video")
      return (
        <div className="my-2">
          <ReactPlayer url={a.url} controls width="100%" />
        </div>
      );
    if (a.type === "link")
      return (
        <a href={a.url} target="_blank" rel="noopener noreferrer" className="d-block my-2">
          <i className="bi bi-link-45deg"></i> {a.url}
        </a>
      );
    if (a.type === "file")
      return (
        <a href={a.url} target="_blank" rel="noopener noreferrer" className="d-block my-2">
          <i className="bi bi-paperclip"></i> {a.name}
        </a>
      );
  };

  return (
    <div className="card mb-3 shadow-sm">
      <div className="card-body">
        <div className="d-flex justify-content-between align-items-center mb-2">
          <h6 className="mb-0">{post.authorName}</h6>
          <small className="text-muted">
            {new Date(post.createdAt).toLocaleString()}
          </small>
        </div>
        <p>{post.text}</p>
        {post.attachments.map((a, i) => (
          <div key={i}>{renderAttachment(a)}</div>
        ))}
        <div className="d-flex align-items-center mt-3">
          <button
            className="btn btn-outline-primary btn-sm me-2"
            onClick={() => onLike(post.id)}
          >
            <i className="bi bi-hand-thumbs-up"></i> {post.likes || 0}
          </button>
          <button
            className="btn btn-outline-secondary btn-sm"
            onClick={() => setShowComments(!showComments)}
          >
            <i className="bi bi-chat"></i> Comments ({post.comments?.length || 0})
          </button>
          <button
            className="btn btn-outline-danger btn-sm ms-auto"
            onClick={() => onDelete(post.id)}
          >
            <i className="bi bi-trash"></i>
          </button>
        </div>
        {showComments && (
          <CommentSection
            comments={post.comments}
            onAdd={(text) => onComment(post.id, text)}
          />
        )}
      </div>
    </div>
  );
}

export default PostCard;
