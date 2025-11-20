export class Course {
  constructor(id, title, category, status = 'draft', students = 0, lastUpdated = new Date().toISOString()) {
    this.id = id;
    this.title = title;
    this.category = category;
    this.status = status;
    this.students = students;
    this.lastUpdated = lastUpdated;
  }
}