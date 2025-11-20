export const samplePayments = [
  { id: "P1", date: "2025-10-01", user: "Alice Johnson", amount: 29.99, method: "Credit Card", status: "Completed" },
  { id: "P2", date: "2025-10-03", user: "Bob Smith", amount: 14.99, method: "PayPal", status: "Pending" },
  { id: "P3", date: "2025-10-10", user: "Charlie Brown", amount: 49.99, method: "Credit Card", status: "Completed" },
];

export const samplePromoCodes = [
  { id: "C1", code: "WELCOME10", discount: 10, start: "2025-10-01", end: "2025-12-31", usage: 120 },
  { id: "C2", code: "SUMMER25", discount: 25, start: "2025-06-01", end: "2025-06-30", usage: 30 },
];

export const samplePromotions = [
  { id: "PR1", title: "Back to School Offer", start: "2025-09-01", end: "2025-09-15", percent: 30, condition: "All users" },
  { id: "PR2", title: "Winter Sale", start: "2025-12-01", end: "2025-12-31", percent: 50, condition: "Annual plan" },
];

export const sampleSubscriptions = [
  { id: "S1", user: "Ali", plan: "Monthly Pro", price: 19.99, start: "2025-09-01", end: "2025-10-01", remaining: 5, status: "active" },
  { id: "S2", user: "Sara", plan: "Annual", price: 199.99, start: "2025-01-15", end: "2026-01-15", remaining: 100, status: "active" },
];
