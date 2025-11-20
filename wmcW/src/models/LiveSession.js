export class LiveSession {
  constructor(id, title, schedule, participants = 0, isActive = false) {
    this.id = id;
    this.title = title;
    this.schedule = schedule;
    this.participants = participants;
    this.isActive = isActive;
  }
}