export default class PromoCode {
  constructor({ id, code, discount, start, end, usage }) {
    this.id = id;
    this.code = code;
    this.discount = discount;
    this.start = start;
    this.end = end;
    this.usage = usage || 0;
  }
}