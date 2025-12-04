import React, { useState } from "react";
import { Card, Button, Modal, Form } from "react-bootstrap";
import { useSubscriptionsViewModel } from "../viewmodels/subscriptions.viewmodel";

export default function SubscriptionsView() {
  const { subs, addSub, updateSub, deleteSub } = useSubscriptionsViewModel();
  const [show,setShow]=useState(false);
  const [edit,setEdit]=useState(null);
  const [form,setForm]=useState({ user:"", plan:"", price:0, start:"", end:"", remaining:0, status:"active" });

  function openModal(s=null) {
    if (s) { setEdit(s); setForm({...s}); } else { setEdit(null); setForm({ user:"", plan:"", price:0, start:new Date().toISOString().slice(0,10), end:"", remaining:0, status:"active" }); }
    setShow(true);
  }

  function save() {
    if (!form.user || !form.plan) return;
    if (edit) updateSub(edit.id, form);
    else addSub(form);
    setShow(false);
  }

  return (
    <>
      <div className="d-flex justify-content-between align-items-center mb-3"><h4 className="fw-bold">Subscriptions</h4><Button onClick={()=>openModal()}>Add Subscription</Button></div>
      {subs.map(s=>(
        <Card key={s.id} className="mb-3"><Card.Body>
          <h6>{s.user} — {s.plan}</h6>
          <small>{s.start} → {s.end}</small><br/><small>Remaining: {s.remaining}</small><br/><small>Status: <span className={s.status === 'active' ? 'text-success' : 'text-muted'}>{s.status}</span></small>
          <div className="mt-2"><Button size="sm" onClick={()=>openModal(s)}>Edit</Button>{" "}<Button size="sm" variant="danger" onClick={()=>deleteSub(s.id)}>Delete</Button></div>
        </Card.Body></Card>
      ))}

      <Modal show={show} onHide={()=>setShow(false)}>
        <Modal.Header closeButton><Modal.Title>{edit ? "Edit Subscription" : "Add Subscription"}</Modal.Title></Modal.Header>
        <Modal.Body>
          <Form>
            <Form.Group className="mb-2"><Form.Label>User</Form.Label><Form.Control value={form.user} onChange={(e)=>setForm({...form,user:e.target.value})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Plan</Form.Label><Form.Control value={form.plan} onChange={(e)=>setForm({...form,plan:e.target.value})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Price</Form.Label><Form.Control type="number" value={form.price} onChange={(e)=>setForm({...form,price:parseFloat(e.target.value)})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Start</Form.Label><Form.Control type="date" value={form.start} onChange={(e)=>setForm({...form,start:e.target.value})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>End</Form.Label><Form.Control type="date" value={form.end} onChange={(e)=>setForm({...form,end:e.target.value})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Status</Form.Label><Form.Select value={form.status} onChange={(e)=>setForm({...form,status:e.target.value})}><option value="active">Active</option><option value="paused">Paused</option><option value="canceled">Canceled</option></Form.Select></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Remaining</Form.Label><Form.Control type="number" value={form.remaining} onChange={(e)=>setForm({...form,remaining:parseInt(e.target.value||0)})} /></Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer><Button variant="secondary" onClick={()=>setShow(false)}>Cancel</Button><Button onClick={save}>{edit ? "Save" : "Create"}</Button></Modal.Footer>
      </Modal>
    </>
  );
}