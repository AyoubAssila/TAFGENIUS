import React, { useState } from "react";
import { Table, Button, Modal, Form, InputGroup } from "react-bootstrap";
import { usePaymentsViewModel } from "../viewmodels/payments.viewmodel";

export default function PaymentsView() {
  const { payments, addPayment, updatePayment, deletePayment, searchPayments } = usePaymentsViewModel();
  const [term, setTerm] = useState("");
  const [show, setShow] = useState(false);
  const [edit, setEdit] = useState(null);
  const [form, setForm] = useState({ user: "", amount: "", method: "Credit Card", status: "Pending", date: new Date().toISOString().slice(0,10) });

  const filtered = term ? searchPayments(term) : payments;

  function openModal(item=null) {
    if (item) { setEdit(item); setForm({...item}); }
    else { setEdit(null); setForm({ user:"", amount:"", method:"Credit Card", status:"Pending", date: new Date().toISOString().slice(0,10)}); }
    setShow(true);
  }

  function save() {
    if (!form.user || !form.amount) return;
    if (edit) updatePayment(edit.id, form);
    else addPayment(form);
    setShow(false);
  }

  return (
    <>
      <div className="d-flex justify-content-between align-items-center mb-3">
        <h4 className="fw-bold">Payments</h4>
        <Button onClick={() => openModal()}>Add Payment</Button>
      </div>

      <InputGroup className="mb-3">
        <InputGroup.Text><i className="bi bi-search"></i></InputGroup.Text>
        <Form.Control placeholder="Search by user or method" value={term} onChange={(e)=>setTerm(e.target.value)} />
      </InputGroup>

      {filtered.length === 0 ? <p className="text-muted">No payments found.</p> : (
        <Table hover responsive className="align-middle">
          <thead className="table-light"><tr><th>User</th><th>Date</th><th>Amount ($)</th><th>Method</th><th>Status</th><th>Actions</th></tr></thead>
          <tbody>
            {filtered.map(p => (
              <tr key={p.id}>
                <td>{p.user}</td>
                <td>{p.date}</td>
                <td>{parseFloat(p.amount).toFixed(2)}</td>
                <td>{p.method}</td>
                <td><span className={p.status === "Completed" ? "badge bg-success" : p.status === "Pending" ? "badge bg-warning text-dark" : "badge bg-secondary"}>{p.status}</span></td>
                <td>
                  <Button size="sm" variant="outline-primary" onClick={()=>openModal(p)}><i className="bi bi-pencil"></i></Button>{" "}
                  <Button size="sm" variant="outline-danger" onClick={()=>{ if(window.confirm("Delete this payment?")) deletePayment(p.id); }}><i className="bi bi-trash"></i></Button>
                </td>
              </tr>
            ))}
          </tbody>
        </Table>
      )}

      <Modal show={show} onHide={()=>setShow(false)}>
        <Modal.Header closeButton><Modal.Title>{edit ? "Edit Payment" : "Add Payment"}</Modal.Title></Modal.Header>
        <Modal.Body>
          <Form>
            <Form.Group className="mb-2"><Form.Label>User</Form.Label><Form.Control value={form.user} onChange={(e)=>setForm({...form,user:e.target.value})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Amount</Form.Label><Form.Control type="number" value={form.amount} onChange={(e)=>setForm({...form,amount:e.target.value})} /></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Method</Form.Label><Form.Select value={form.method} onChange={(e)=>setForm({...form,method:e.target.value})}><option>Credit Card</option><option>PayPal</option><option>Bank Transfer</option></Form.Select></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Status</Form.Label><Form.Select value={form.status} onChange={(e)=>setForm({...form,status:e.target.value})}><option>Pending</option><option>Completed</option><option>Failed</option></Form.Select></Form.Group>
            <Form.Group className="mb-2"><Form.Label>Date</Form.Label><Form.Control type="date" value={form.date} onChange={(e)=>setForm({...form,date:e.target.value})} /></Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer><Button variant="secondary" onClick={()=>setShow(false)}>Cancel</Button><Button onClick={save}>{edit ? "Save" : "Create"}</Button></Modal.Footer>
      </Modal>
    </>
  );
}