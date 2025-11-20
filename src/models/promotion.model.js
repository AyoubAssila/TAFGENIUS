export default class PromotionModel {
  constructor({ id, title, start, end, percent, condition }) {
    this.id = id;
    this.title = title;
    this.start = start;
    this.end = end;
    this.percent = percent;
    this.condition = condition;
  }
}
