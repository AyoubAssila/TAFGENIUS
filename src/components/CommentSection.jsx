import React, { useState } from "react";

function CommentSection({ comments, onAdd }) {
  const [text, setText] = useState("");

  const handleAdd = () => {
    if (text.trim()) {
      onAdd(text.trim());
      setText("");
    }
  };

  return (
    <div className="mt-3">
      {comments && comments.length > 0 ? (
        comments.map((c, i) => (
          <div key={i} className="border-bottom py-2">
            <strong>{c.authorName}</strong> <small className="text-muted">{c.date}</small>
            <p className="mb-1">{c.text}</p>
          </div>
        ))
      ) : (
        <p className="text-muted">No comments yet.</p>
      )}
      <div className="input-group mt-2">
        <input
          className="form-control"
          placeholder="Write a comment..."
          value={text}
          onChange={(e) => setText(e.target.value)}
        />
        <button className="btn btn-primary" onClick={handleAdd}>
          Send
        </button>
      </div>
    </div>
  );
}

export default CommentSection;
