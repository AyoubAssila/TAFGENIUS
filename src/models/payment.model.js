export default class Payment {
  constructor({ id, date, user, amount, method, status }) {
    this.id = id;
    this.date = date;
    this.user = user;
    this.amount = amount;
    this.method = method;
    this.status = status;
  }
}
