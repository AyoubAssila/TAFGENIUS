import { useState } from "react";
import { samplePromoCodes } from "../data/sampleData";

export function usePromoCodesViewModel() {
  const [codes, setCodes] = useState(samplePromoCodes);

  function addCode(c) { setCodes(prev => [{ ...c, id: Date.now().toString(), usage: c.usage || 0 }, ...prev]); }
  function updateCode(id, data) { setCodes(prev => prev.map(x => x.id === id ? { ...x, ...data } : x)); }
  function deleteCode(id) { setCodes(prev => prev.filter(x => x.id !== id)); }
  function incrementUsage(id) { setCodes(prev => prev.map(x => x.id === id ? { ...x, usage: (x.usage || 0) + 1 } : x)); }

  return { codes, addCode, updateCode, deleteCode, incrementUsage, setCodes };
}