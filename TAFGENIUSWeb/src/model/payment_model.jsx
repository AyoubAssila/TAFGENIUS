export default class Payment {
  constructor({ id, date, user = null, amount = null, method = null, status = null }) {
    this.id = id;
    this.date = date;
    this.user = user;
    this.amount = amount;
    this.method = method;
    this.status = status;
  }
}

export const PaymentsData = [
  { id: "#12345", amount: "40 TND", date: "May 10, 2024" },
  { id: "#12346", amount: "50 TND", date: "June 2, 2024" },
  { id: "#12347", amount: "60 TND", date: "July 15, 2024" },
];
