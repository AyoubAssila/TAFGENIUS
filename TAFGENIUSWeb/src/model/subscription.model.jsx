export default class SubscriptionModel {
  constructor({ id, user, plan, price, start, end, remaining, status }) {
    this.id = id;
    this.user = user;
    this.plan = plan;
    this.price = price;
    this.start = start;
    this.end = end;
    this.remaining = remaining;
    this.status = status || "active";
  }
}