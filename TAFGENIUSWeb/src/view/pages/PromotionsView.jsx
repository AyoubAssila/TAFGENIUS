import React, { useState } from "react";
import { Card, Button, Modal, Form } from "react-bootstrap";
import { usePromotionsViewModel } from "../viewmodels/promotions.viewmodel";

export default function PromotionsView() {
  const { promos, addPromo, updatePromo, deletePromo } = usePromotionsViewModel();
  const [show,setShow]=useState(false);
  const [edit,setEdit]=useState(null);
  const [form,setForm]=useState({ title:"", start:"", end:"", percent:10, condition:"" });

  function openModal(p=null) {
    if (p) { setEdit(p); setForm({...p}); } else { setEdit(null); setForm({ title:"", start:"", end:"", percent:10, condition:"" }); }
    setShow(true);
  }

  function save() {
    if (!form.title) return;
    if (edit) updatePromo(edit.id, form);
    else addPromo(form);
    setShow(false);
  }

  return (
    <>
      <div className="d-flex justify-content-between align-items-center mb-3"><h4 className="fw-bold">Promotions</h4><Button onClick={()=>openModal()}>Add Promotion</Button></div>
      {promos.map(p=>(
        <Card key={p.id} className="mb-3">
          <Card.Body>
            <h6>{p.title} — <span className="text-success">{p.percent}% off</span></h6>
            <small>{p.start} → {p.end}</small><br/><small>Condition: {p.condition}</small>
            <div className="mt-2"><Button size="sm" onClick={()=>openModal(p)}>Edit</Button>{" "}<Button size="sm" variant="danger" onClick={()=>deletePromo(p.id)}>Delete</Button></div>
          </Card.Body>
        </Card>
      ))}

      <Modal show={show} onHide={()=>setShow(false)}>
        <Modal.Header closeButton><Modal.Title>{edit ? "Edit Promotion" : "Add Promotion"}</Modal.Title></Modal.Header>
        <Modal.Body>
          <Form>
            <Form.Group className="mb-2"><Form.Label>Title</Form.Label><Form.Control value={form.title} onChange={(e)=>setForm({...form,title:e.target.value})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Discount %</Form.Label><Form.Control type="number" value={form.percent} onChange={(e)=>setForm({...form,percent:parseFloat(e.target.value)})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Start</Form.Label><Form.Control type="date" value={form.start} onChange={(e)=>setForm({...form,start:e.target.value})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>End</Form.Label><Form.Control type="date" value={form.end} onChange={(e)=>setForm({...form,end:e.target.value})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Condition</Form.Label><Form.Control value={form.condition} onChange={(e)=>setForm({...form,condition:e.target.value})} /></Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer><Button variant="secondary" onClick={()=>setShow(false)}>Cancel</Button><Button onClick={save}>{edit ? "Save" : "Create"}</Button></Modal.Footer>
      </Modal>
    </>
  );
}