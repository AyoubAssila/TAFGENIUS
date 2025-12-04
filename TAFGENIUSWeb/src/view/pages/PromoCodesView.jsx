import React, { useState } from "react";
import { Card, Button, Modal, Form, Row, Col } from "react-bootstrap";
import { usePromoCodesViewModel } from "../viewmodels/promocodes.viewmodel";

export default function PromoCodesView() {
  const { codes, addCode, updateCode, deleteCode, incrementUsage } = usePromoCodesViewModel();
  const [show, setShow] = useState(false);
  const [edit, setEdit] = useState(null);
  const [form, setForm] = useState({ code:"", discount:10, start:"", end:"" });

  function openModal(item=null) {
    if (item) { setEdit(item); setForm({...item}); }
    else { setEdit(null); setForm({ code:"", discount:10, start:"", end:"" }); }
    setShow(true);
  }

  function save() {
    if (!form.code) return;
    if (edit) updateCode(edit.id, form);
    else addCode(form);
    setShow(false);
  }

  return (
    <>
      <div className="d-flex justify-content-between align-items-center mb-3"><h4 className="fw-bold">Promo Codes</h4><Button onClick={()=>openModal()}>Add Code</Button></div>
      {codes.map(c=>(
        <Card key={c.id} className="mb-3 shadow-sm">
          <Card.Body>
            <Row>
              <Col md={2}><h5 className="text-primary fw-bold">{c.discount}%</h5></Col>
              <Col><h6>{c.code}</h6><small>{c.start} → {c.end}</small><br/><small>Usages: {c.usage}</small></Col>
              <Col md="auto">
                <Button size="sm" variant="outline-primary" onClick={()=>{ setEdit(c); setForm(c); setShow(true); }}>Edit</Button>{" "}
                <Button size="sm" variant="outline-secondary" onClick={()=>incrementUsage(c.id)}>Simulate Use</Button>{" "}
                <Button size="sm" variant="outline-danger" onClick={()=>deleteCode(c.id)}>Delete</Button>
              </Col>
            </Row>
          </Card.Body>
        </Card>
      ))}

      <Modal show={show} onHide={()=>setShow(false)}>
        <Modal.Header closeButton><Modal.Title>{edit ? "Edit Promo Code" : "Add Promo Code"}</Modal.Title></Modal.Header>
        <Modal.Body>
          <Form>
            <Form.Group className="mb-2"><Form.Label>Code</Form.Label><Form.Control value={form.code} onChange={(e)=>setForm({...form,code:e.target.value})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Discount %</Form.Label><Form.Control type="number" value={form.discount} onChange={(e)=>setForm({...form,discount:parseFloat(e.target.value)})} /></Form.Group>
            <Row>
              <Col><Form.Label>Start</Form.Label><Form.Control type="date" value={form.start} onChange={(e)=>setForm({...form,start:e.target.value})} /></Col>
              <Col><Form.Label>End</Form.Label><Form.Control type="date" value={form.end} onChange={(e)=>setForm({...form,end:e.target.value})} /></Col>
            </Row>
          </Form>
        </Modal.Body>
        <Modal.Footer><Button variant="secondary" onClick={()=>setShow(false)}>Cancel</Button><Button onClick={save}>{edit ? "Save" : "Create"}</Button></Modal.Footer>
      </Modal>
    </>
  );
}