export class SubscriptionModel {
  constructor({
    id = '',
    title = '',
    price = 0,
    courses = [],
    durationDays = 30,
    archived = false,
    createdAt = new Date(),
    updatedAt = new Date(),
  }) {
    this.id = id;
    this.title = title;
    this.price = Number(price) || 0;
    this.courses = Array.isArray(courses) ? courses : [];
    this.durationDays = Number(durationDays) || 30;
    this.archived = archived === true;
    this.createdAt = createdAt instanceof Date ? createdAt : SubscriptionModel.parseDate(createdAt);
    this.updatedAt = updatedAt instanceof Date ? updatedAt : SubscriptionModel.parseDate(updatedAt);
  }
  
  getDurationMs() {
    return this.durationDays * 24 * 60 * 60 * 1000;
  }
  
  getEndDate(startDate) {
    const start = startDate instanceof Date ? startDate : SubscriptionModel.parseDate(startDate);
    return new Date(start.getTime() + this.getDurationMs());
  }
  
  toFirestore() {
    return {
      title: this.title,
      price: this.price,
      courses: this.courses,
      durationDays: this.durationDays,
      archived: this.archived,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
    };
  }
  
  static fromFirestore(map = {}, id) {
    return new SubscriptionModel({
      id: id || '',
      title: map.title || '',
      price: map.price || 0,
      courses: Array.isArray(map.courses) ? map.courses : [],
      durationDays: map.durationDays || 30,
      archived: map.archived === true,
      createdAt: map.createdAt,
      updatedAt: map.updatedAt,
    });
  }
  
  static parseDate(value) {
    if (!value) return new Date();
    if (value instanceof Date) return value;
    if (typeof value === 'string' || typeof value === 'number') return new Date(value);
    if (value.seconds != null) return new Date(value.seconds * 1000);
    if (value._seconds != null) return new Date(value._seconds * 1000);
    return new Date();
  }
}
