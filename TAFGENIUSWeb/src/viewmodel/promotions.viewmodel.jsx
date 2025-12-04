import { useState } from "react";
import { samplePromotions } from "../data/sampleData";

export function usePromotionsViewModel() {
  const [promos, setPromos] = useState(samplePromotions);

  function addPromo(p) { setPromos(prev => [{ ...p, id: Date.now().toString() }, ...prev]); }
  function updatePromo(id, data) { setPromos(prev => prev.map(x => x.id === id ? { ...x, ...data } : x)); }
  function deletePromo(id) { setPromos(prev => prev.filter(x => x.id !== id)); }

  return { promos, addPromo, updatePromo, deletePromo, setPromos };
}