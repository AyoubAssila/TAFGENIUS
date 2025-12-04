import { useState } from "react";
import { samplePayments } from "../data/sampleData";

/**
 * usePaymentsViewModel
 * - exposes payments list and CRUD operations
 */
export function usePaymentsViewModel() {
  const [payments, setPayments] = useState(samplePayments);

  function addPayment(item) {
    setPayments(prev => [{ ...item, id: Date.now().toString() }, ...prev]);
  }

  function updatePayment(id, data) {
    setPayments(prev => prev.map(p => p.id === id ? { ...p, ...data } : p));
  }

  function deletePayment(id) {
    setPayments(prev => prev.filter(p => p.id !== id));
  }

  function searchPayments(term) {
    const t = (term || "").toLowerCase();
    if (!t) return payments;
    return payments.filter(p => p.user.toLowerCase().includes(t) || (p.method || "").toLowerCase().includes(t));
  }

  return { payments, addPayment, updatePayment, deletePayment, searchPayments, setPayments };
}