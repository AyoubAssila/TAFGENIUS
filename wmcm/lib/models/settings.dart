class Settings {
  bool notifications;
  bool emailAlerts;
  bool darkMode;
  bool autoSave;
  String language;
  String timezone;

  Settings({
    this.notifications = true,
    this.emailAlerts = true,
    this.darkMode = false,
    this.autoSave = true,
    this.language = 'en',
    this.timezone = 'UTC',
  });

  Settings copyWith({
    bool? notifications,
    bool? emailAlerts,
    bool? darkMode,
    bool? autoSave,
    String? language,
    String? timezone,
  }) {
    return Settings(
      notifications: notifications ?? this.notifications,
      emailAlerts: emailAlerts ?? this.emailAlerts,
      darkMode: darkMode ?? this.darkMode,
      autoSave: autoSave ?? this.autoSave,
      language: language ?? this.language,
      timezone: timezone ?? this.timezone,
    );
  }
}