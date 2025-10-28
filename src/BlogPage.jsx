// BlogPage.jsx
import React, { useState, useRef } from "react";

// Simple utility for IDs (like Date.now())
const uid = () => Date.now().toString();

const AttachmentType = {
  IMAGE: "image",
  FILE: "file",
  LINK: "link",
};

function formatDate(d) {
  const dt = new Date(d);
  // yyyy-mm-dd HH:MM
  const pad = (n) => (n < 10 ? "0" + n : n);
  return `${dt.getFullYear()}-${pad(dt.getMonth() + 1)}-${pad(dt.getDate())} ${pad(
    dt.getHours()
  )}:${pad(dt.getMinutes())}`;
}

export default function BlogPage() {
  // --- simulation of user info (no auth) ---
  const [name, setName] = useState("");
  const [role, setRole] = useState("Étudiant");

  // posts stored in memory
  const [posts, setPosts] = useState([]);

  // which post comments are open (map postId -> bool)
  const [commentsOpen, setCommentsOpen] = useState({});

  // New post modal state
  const [showNewPost, setShowNewPost] = useState(false);
  const newPostTextRef = useRef();
  const [newPostAttachments, setNewPostAttachments] = useState([]);

  // UI helper modals for replies / edits / confirmations
  const [replyState, setReplyState] = useState({ show: false, postId: null, parentId: null });
  const [editCommentState, setEditCommentState] = useState({ show: false, postId: null, commentId: null, content: "" });
  const [confirmState, setConfirmState] = useState({ show: false, action: null, payload: null });

  // ---------- Attachment helpers ----------
  // attachments: { id, type, name, dataUrl?, fileObject?, url? }

  const onPickImages = (files) => {
    const arr = Array.from(files).map((f) => {
      const idv = uid();
      return {
        id: idv,
        type: AttachmentType.IMAGE,
        name: f.name,
        file: f,
        dataUrl: URL.createObjectURL(f), // preview
      };
    });
    setNewPostAttachments((s) => [...s, ...arr]);
  };

  const onPickFiles = (files) => {
    const arr = Array.from(files).map((f) => {
      const idv = uid();
      return {
        id: idv,
        type: AttachmentType.FILE,
        name: f.name,
        file: f,
        dataUrl: URL.createObjectURL(f),
      };
    });
    setNewPostAttachments((s) => [...s, ...arr]);
  };

  const onAddLink = (link) => {
    if (!link) return;
    setNewPostAttachments((s) => [
      ...s,
      { id: uid(), type: AttachmentType.LINK, name: link, url: link },
    ]);
  };

  const removeNewAttachment = (id) => {
    setNewPostAttachments((s) => {
      // Revoke object URLs for memory hygiene
      const found = s.find((a) => a.id === id);
      if (found && found.dataUrl) URL.revokeObjectURL(found.dataUrl);
      return s.filter((a) => a.id !== id);
    });
  };

  // ---------- Create post ----------
  const publishNewPost = () => {
    const text = newPostTextRef.current?.value?.trim() || "";
    if (!text && newPostAttachments.length === 0) {
      alert("Le post est vide.");
      return;
    }
    const p = {
      id: uid(),
      authorName: name.trim() === "" ? "Anonyme" : name.trim(),
      authorRole: role,
      createdAt: new Date().toISOString(),
      text,
      attachments: newPostAttachments.map((a) => ({ ...a })), // shallow copy
      comments: [],
    };
    setPosts((s) => [p, ...s]);
    setNewPostAttachments([]);
    if (newPostTextRef.current) newPostTextRef.current.value = "";
    setShowNewPost(false);
    setCommentsOpen((c) => ({ ...c, [p.id]: false }));
  };

  // ---------- Comments logic ----------
  const addComment = (postId, content, parentId = null) => {
    const idx = posts.findIndex((p) => p.id === postId);
    if (idx === -1) return;
    const newComment = {
      id: uid(),
      authorName: name.trim() === "" ? "Anonyme" : name.trim(),
      authorRole: role,
      content,
      createdAt: new Date().toISOString(),
      parentId: parentId,
    };
    const newPosts = [...posts];
    newPosts[idx] = { ...newPosts[idx], comments: [...newPosts[idx].comments, newComment] };
    setPosts(newPosts);
  };

  const editComment = (postId, commentId, newContent) => {
    const newPosts = posts.map((p) => {
      if (p.id !== postId) return p;
      return {
        ...p,
        comments: p.comments.map((c) => (c.id === commentId ? { ...c, content: newContent } : c)),
      };
    });
    setPosts(newPosts);
  };

  const deleteComment = (postId, commentId) => {
    const newPosts = posts.map((p) => {
      if (p.id !== postId) return p;
      return { ...p, comments: p.comments.filter((c) => c.id !== commentId) };
    });
    setPosts(newPosts);
  };

  const canEditComment = (c) => {
    return name.trim() !== "" && name.trim() === c.authorName;
  };
  const canDeleteComment = (post, c) => {
    return (
      (name.trim() !== "" && name.trim() === c.authorName) ||
      (name.trim() !== "" && name.trim() === post.authorName)
    );
  };

  // ---------- Post delete ----------
  const deletePost = (postId) => {
    setPosts((s) => s.filter((p) => p.id !== postId));
    setCommentsOpen((s) => {
      const copy = { ...s };
      delete copy[postId];
      return copy;
    });
  };

  // ---------- Render helpers ----------
  function AttachmentView({ a }) {
    if (a.type === AttachmentType.IMAGE && a.dataUrl) {
      return (
        <div className="mb-2">
          <img
            src={a.dataUrl}
            alt={a.name}
            className="img-fluid"
            style={{ maxHeight: 200, objectFit: "cover", cursor: "pointer" }}
            onClick={() => window.open(a.dataUrl, "_blank")}
          />
          <div className="small text-muted">{a.name}</div>
        </div>
      );
    } else if (a.type === AttachmentType.LINK && a.url) {
      return (
        <div className="mb-2">
          <a href={a.url} target="_blank" rel="noopener noreferrer">
            {a.url}
          </a>
        </div>
      );
    } else {
      // file
      return (
        <div className="mb-2">
          <i className="bi bi-paperclip" />{" "}
          <a href={a.dataUrl || "#"} target="_blank" rel="noopener noreferrer" download={a.name}>
            {a.name}
          </a>
        </div>
      );
    }
  }

  function CommentsSection({ post }) {
    const [commentText, setCommentText] = useState("");

    return (
      <div className="mt-2">
        {post.comments.map((c) => {
          const isReply = Boolean(c.parentId);
          return (
            <div key={c.id} className={`p-2 mb-2 border rounded ${isReply ? "ms-4" : ""}`} style={{ background: "#fbfbfb" }}>
              <div className="d-flex align-items-start">
                <div className="me-2">
                  <div className="avatar rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center" style={{ width: 34, height: 34 }}>
                    {c.authorName ? c.authorName[0].toUpperCase() : "A"}
                  </div>
                </div>
                <div style={{ flex: 1 }}>
                  <div className="d-flex justify-content-between">
                    <div>
                      <strong>{c.authorName}</strong> <span className="text-muted">• {c.authorRole}</span>
                    </div>
                    <div className="text-muted small">{formatDate(c.createdAt)}</div>
                  </div>
                  <div className="mt-1">{c.content}</div>

                  <div className="mt-2">
                    <button
                      className="btn btn-sm btn-link p-0 me-2"
                      onClick={() => setReplyState({ show: true, postId: post.id, parentId: c.id })}
                    >
                      Répondre
                    </button>

                    {canEditComment(c) && (
                      <button
                        className="btn btn-sm btn-link p-0 me-2"
                        onClick={() =>
                          setEditCommentState({
                            show: true,
                            postId: post.id,
                            commentId: c.id,
                            content: c.content,
                          })
                        }
                      >
                        Modifier
                      </button>
                    )}

                    {canDeleteComment(post, c) && (
                      <button
                        className="btn btn-sm btn-link text-danger p-0"
                        onClick={() =>
                          setConfirmState({ show: true, action: "deleteComment", payload: { postId: post.id, commentId: c.id } })
                        }
                      >
                        Supprimer
                      </button>
                    )}
                  </div>
                </div>
              </div>
            </div>
          );
        })}

        <div className="d-flex align-items-start mt-3">
          <div className="me-2">
            <div className="avatar rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center" style={{ width: 38, height: 38 }}>
              {name ? name[0].toUpperCase() : "A"}
            </div>
          </div>
          <div style={{ flex: 1 }}>
            <textarea
              className="form-control mb-2"
              placeholder="Écris un commentaire..."
              value={commentText}
              onChange={(e) => setCommentText(e.target.value)}
            />
            <div className="d-flex justify-content-end">
              <button
                className="btn btn-primary btn-sm"
                onClick={() => {
                  const content = commentText.trim();
                  if (!content) return;
                  addComment(post.id, content);
                  setCommentText("");
                }}
              >
                Envoyer
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // ---------- JSX ----------
  return (
    <div className="container py-4">
      <div className="d-flex align-items-center mb-3">
        <h3 className="me-auto">Blog (Classroom-style)</h3>
        <button className="btn btn-success" onClick={() => setShowNewPost(true)}>
          <i className="bi bi-plus-lg me-1" /> Nouvelle publication
        </button>
      </div>

      {/* user input card */}
      <div className="card mb-3">
        <div className="card-body d-flex align-items-center">
          <div style={{ flex: 1 }}>
            <input
              className="form-control mb-2"
              placeholder="Ton nom (pour test)"
              value={name}
              onChange={(e) => setName(e.target.value)}
            />
          </div>
          <div className="ms-3">
            <select className="form-select" value={role} onChange={(e) => setRole(e.target.value)}>
              <option>Étudiant</option>
              <option>Webmaster de contenu</option>
            </select>
          </div>
        </div>
      </div>

      {/* posts list */}
      <div>
        {posts.length === 0 ? (
          <div className="text-center text-muted py-5">Aucune publication pour l’instant. Utilise le bouton "Nouvelle publication".</div>
        ) : (
          posts.map((post) => (
            <div className="card mb-3" key={post.id}>
              <div className="card-body">
                <div className="d-flex">
                  <div className="me-3">
                    <div className="avatar rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" style={{ width: 48, height: 48 }}>
                      {post.authorName ? post.authorName[0].toUpperCase() : "A"}
                    </div>
                  </div>
                  <div style={{ flex: 1 }}>
                    <div className="d-flex">
                      <div>
                        <strong>{post.authorName}</strong>
                        <div className="text-muted small">{post.authorRole} • {formatDate(post.createdAt)}</div>
                      </div>
                      <div className="ms-auto">
                        {name.trim() !== "" && name.trim() === post.authorName && (
                          <button
                            className="btn btn-sm btn-outline-danger"
                            onClick={() =>
                              setConfirmState({ show: true, action: "deletePost", payload: { postId: post.id } })
                            }
                          >
                            Supprimer
                          </button>
                        )}
                      </div>
                    </div>

                    <div className="mt-2">{post.text}</div>

                    <div className="mt-2">
                      {post.attachments.map((a) => (
                        <AttachmentView a={a} key={a.id} />
                      ))}
                    </div>

                    <div className="d-flex align-items-center mt-3">
                      <button
                        className="btn btn-sm btn-outline-secondary me-2"
                        onClick={() => alert("Like added (demo)")}
                      >
                        <i className="bi bi-heart" /> Like
                      </button>
                      <button
                        className="btn btn-sm btn-outline-secondary me-2"
                        onClick={() => setCommentsOpen((s) => ({ ...s, [post.id]: !s[post.id] }))}
                      >
                        <i className="bi bi-chat-left" /> Commenter
                      </button>
                      <div className="ms-auto text-muted small">{post.comments.length} commentaires</div>
                    </div>

                    {commentsOpen[post.id] && <CommentsSection post={post} />}
                  </div>
                </div>
              </div>
            </div>
          ))
        )}
      </div>

      {/* ------------------ New Post Modal (Bootstrap-style inline) ------------------ */}
      {showNewPost && (
        <div className="modal d-block" tabIndex="-1" role="dialog" style={{ background: "rgba(0,0,0,0.5)" }}>
          <div className="modal-dialog modal-lg" role="document">
            <div className="modal-content">
              <div className="modal-header">
                <h5 className="modal-title">Nouvelle publication</h5>
                <button type="button" className="btn-close" onClick={() => setShowNewPost(false)} />
              </div>
              <div className="modal-body">
                <textarea className="form-control mb-3" placeholder="Écris ton post ici..." ref={newPostTextRef} rows={4} />
                <div className="mb-3">
                  <label className="form-label me-2">Ajouter :</label>

                  <label className="btn btn-outline-primary btn-sm me-2">
                    Image
                    <input
                      type="file"
                      accept="image/*"
                      multiple
                      hidden
                      onChange={(e) => {
                        if (e.target.files) onPickImages(e.target.files);
                        e.target.value = null;
                      }}
                    />
                  </label>

                  <label className="btn btn-outline-primary btn-sm me-2">
                    Fichier
                    <input
                      type="file"
                      multiple
                      hidden
                      onChange={(e) => {
                        if (e.target.files) onPickFiles(e.target.files);
                        e.target.value = null;
                      }}
                    />
                  </label>

                  <button
                    className="btn btn-outline-primary btn-sm"
                    onClick={() => {
                      const l = prompt("Ajouter un lien (https://...)");
                      if (l) onAddLink(l.trim());
                    }}
                  >
                    Lien
                  </button>
                </div>

                {newPostAttachments.length > 0 && (
                  <div className="mb-2">
                    <div className="fw-semibold mb-2">Pièces jointes</div>
                    {newPostAttachments.map((a) => (
                      <div key={a.id} className="d-flex align-items-center mb-2">
                        {a.type === AttachmentType.IMAGE ? (
                          <img src={a.dataUrl} alt={a.name} style={{ width: 110, height: 70, objectFit: "cover" }} className="me-2" />
                        ) : (
                          <i className="bi bi-paperclip fs-3 me-3" />
                        )}
                        <div style={{ flex: 1 }}>
                          <div>{a.name}</div>
                          <div className="text-muted small">{a.type}</div>
                        </div>
                        <button className="btn btn-sm btn-outline-danger" onClick={() => removeNewAttachment(a.id)}>
                          Supprimer
                        </button>
                      </div>
                    ))}
                  </div>
                )}
              </div>
              <div className="modal-footer">
                <button className="btn btn-secondary" onClick={() => setShowNewPost(false)}>
                  Annuler
                </button>
                <button className="btn btn-primary" onClick={publishNewPost}>
                  Publier
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Reply modal */}
      {replyState.show && (
        <ModalInline onClose={() => setReplyState({ show: false, postId: null, parentId: null })} title={`Répondre`}>
          <ReplyForm
            initialValue=""
            onCancel={() => setReplyState({ show: false, postId: null, parentId: null })}
            onSubmit={(value) => {
              addComment(replyState.postId, value, replyState.parentId);
              setReplyState({ show: false, postId: null, parentId: null });
            }}
          />
        </ModalInline>
      )}

      {/* Edit comment modal */}
      {editCommentState.show && (
        <ModalInline
          onClose={() => setEditCommentState({ show: false, postId: null, commentId: null, content: "" })}
          title="Modifier le commentaire"
        >
          <EditCommentForm
            initialValue={editCommentState.content}
            onCancel={() => setEditCommentState({ show: false, postId: null, commentId: null, content: "" })}
            onSubmit={(value) => {
              editComment(editCommentState.postId, editCommentState.commentId, value);
              setEditCommentState({ show: false, postId: null, commentId: null, content: "" });
            }}
          />
        </ModalInline>
      )}

      {/* Confirm modal */}
      {confirmState.show && (
        <ModalInline
          onClose={() => setConfirmState({ show: false, action: null, payload: null })}
          title="Confirmation"
        >
          <div className="mb-3">Êtes-vous sûr ?</div>
          <div className="d-flex justify-content-end">
            <button className="btn btn-secondary me-2" onClick={() => setConfirmState({ show: false, action: null, payload: null })}>
              Annuler
            </button>
            <button
              className="btn btn-danger"
              onClick={() => {
                // handle actions
                if (confirmState.action === "deletePost") {
                  deletePost(confirmState.payload.postId);
                } else if (confirmState.action === "deleteComment") {
                  deleteComment(confirmState.payload.postId, confirmState.payload.commentId);
                }
                setConfirmState({ show: false, action: null, payload: null });
              }}
            >
              Supprimer
            </button>
          </div>
        </ModalInline>
      )}
    </div>
  );
}

// ----------------- small inline modal component -----------------
function ModalInline({ children, onClose, title }) {
  return (
    <div className="modal d-block" tabIndex="-1" style={{ background: "rgba(0,0,0,0.5)" }}>
      <div className="modal-dialog modal-md">
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title">{title}</h5>
            <button type="button" className="btn-close" onClick={onClose} />
          </div>
          <div className="modal-body">{children}</div>
        </div>
      </div>
    </div>
  );
}

// ----------------- reply form -----------------
function ReplyForm({ initialValue, onCancel, onSubmit }) {
  const [value, setValue] = useState(initialValue || "");
  return (
    <>
      <textarea className="form-control mb-3" rows={3} value={value} onChange={(e) => setValue(e.target.value)} />
      <div className="d-flex justify-content-end">
        <button className="btn btn-secondary me-2" onClick={onCancel}>
          Annuler
        </button>
        <button className="btn btn-primary" onClick={() => onSubmit(value)}>
          Répondre
        </button>
      </div>
    </>
  );
}

// ----------------- edit comment form -----------------
function EditCommentForm({ initialValue, onCancel, onSubmit }) {
  const [value, setValue] = useState(initialValue || "");
  return (
    <>
      <textarea className="form-control mb-3" rows={4} value={value} onChange={(e) => setValue(e.target.value)} />
      <div className="d-flex justify-content-end">
        <button className="btn btn-secondary me-2" onClick={onCancel}>
          Annuler
        </button>
        <button
          className="btn btn-primary"
          onClick={() => {
            onSubmit(value);
          }}
        >
          Enregistrer
        </button>
      </div>
    </>
  );
}
