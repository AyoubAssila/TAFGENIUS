import { useState } from "react";
import { sampleSubscriptions } from "../data/sampleData";

export function useSubscriptionsViewModel() {
  const [subs, setSubs] = useState(sampleSubscriptions);

  function addSub(s) { setSubs(prev => [{ ...s, id: Date.now().toString() }, ...prev]); }
  function updateSub(id, data) { setSubs(prev => prev.map(x => x.id === id ? { ...x, ...data } : x)); }
  function deleteSub(id) { setSubs(prev => prev.filter(x => x.id !== id)); }

  return { subs, addSub, updateSub, deleteSub, setSubs };
}