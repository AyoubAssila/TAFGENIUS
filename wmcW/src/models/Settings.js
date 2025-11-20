export class Settings {
  constructor(notifications = true, emailAlerts = true, darkMode = false, autoSave = true, language = 'en', timezone = 'UTC') {
    this.notifications = notifications;
    this.emailAlerts = emailAlerts;
    this.darkMode = darkMode;
    this.autoSave = autoSave;
    this.language = language;
    this.timezone = timezone;
  }
}