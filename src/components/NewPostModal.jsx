import React, { useState } from "react";

function NewPostModal({ onSave }) {
  const [text, setText] = useState("");
  const [category, setCategory] = useState("Opinions");
  const [attachments, setAttachments] = useState([]);

  const addAttachment = (type) => {
    const url = prompt(`Enter ${type} URL or file name:`);
    if (url) {
      setAttachments([...attachments, { type, url, name: url }]);
    }
  };

  const handleSubmit = () => {
    if (!text.trim() && attachments.length === 0) return;
    onSave({
      id: Date.now(),
      authorName: "Anonymous",
      text,
      createdAt: new Date(),
      category,
      attachments,
      comments: [],
      likes: 0,
    });
    setText("");
    setAttachments([]);
  };

  return (
    <div className="card mb-4">
      <div className="card-body">
        <textarea
          className="form-control mb-2"
          rows="3"
          placeholder="Write your post..."
          value={text}
          onChange={(e) => setText(e.target.value)}
        ></textarea>
        <div className="d-flex flex-wrap gap-2 mb-2">
          <button
            className="btn btn-outline-primary btn-sm"
            onClick={() => addAttachment("image")}
          >
            <i className="bi bi-image"></i> Image
          </button>
          <button
            className="btn btn-outline-success btn-sm"
            onClick={() => addAttachment("video")}
          >
            <i className="bi bi-camera-video"></i> Video
          </button>
          <button
            className="btn btn-outline-secondary btn-sm"
            onClick={() => addAttachment("file")}
          >
            <i className="bi bi-paperclip"></i> File
          </button>
          <button
            className="btn btn-outline-info btn-sm"
            onClick={() => addAttachment("link")}
          >
            <i className="bi bi-link-45deg"></i> Link
          </button>
        </div>
        <select
          className="form-select mb-2"
          value={category}
          onChange={(e) => setCategory(e.target.value)}
        >
          <option>Opinions</option>
          <option>Experiences</option>
          <option>Articles</option>
        </select>
        <button className="btn btn-primary w-100" onClick={handleSubmit}>
          Publish
        </button>
      </div>
    </div>
  );
}

export default NewPostModal;
