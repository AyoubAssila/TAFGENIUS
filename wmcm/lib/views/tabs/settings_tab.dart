import 'package:flutter/material.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import '../../models/settings.dart';

class SettingsTab extends StatefulWidget {
  final DashboardViewModel viewModel;

  const SettingsTab({super.key, required this.viewModel});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late Settings _currentSettings;

  @override
  void initState() {
    super.initState();
    _currentSettings = widget.viewModel.settings.copyWith();
  }

  void _saveSettings() {
    widget.viewModel.updateSettings(_currentSettings);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved successfully')),
    );
  }

  void _resetSettings() {
    setState(() {
      _currentSettings = Settings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Platform Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Current Settings Overview
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Settings',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem('Notifications', _currentSettings.notifications ? 'Enabled' : 'Disabled'),
                  _buildSettingItem('Email Alerts', _currentSettings.emailAlerts ? 'Enabled' : 'Disabled'),
                  _buildSettingItem('Dark Mode', _currentSettings.darkMode ? 'Enabled' : 'Disabled'),
                  _buildSettingItem('Auto Save', _currentSettings.autoSave ? 'Enabled' : 'Disabled'),
                  _buildSettingItem('Language', _currentSettings.language.toUpperCase()),
                  _buildSettingItem('Timezone', _currentSettings.timezone),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Settings Form
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Configuration',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Notifications
                  _buildSwitchSetting(
                    'Push Notifications',
                    'Receive push notifications for important updates',
                    _currentSettings.notifications,
                        (value) => setState(() => _currentSettings.notifications = value),
                  ),
                  const SizedBox(height: 16),

                  // Email Alerts
                  _buildSwitchSetting(
                    'Email Alerts',
                    'Get email notifications for system alerts',
                    _currentSettings.emailAlerts,
                        (value) => setState(() => _currentSettings.emailAlerts = value),
                  ),
                  const SizedBox(height: 16),

                  // Dark Mode
                  _buildSwitchSetting(
                    'Dark Mode',
                    'Enable dark theme across the platform',
                    _currentSettings.darkMode,
                        (value) => setState(() => _currentSettings.darkMode = value),
                  ),
                  const SizedBox(height: 16),

                  // Auto Save
                  _buildSwitchSetting(
                    'Auto Save',
                    'Automatically save changes while editing',
                    _currentSettings.autoSave,
                        (value) => setState(() => _currentSettings.autoSave = value),
                  ),
                  const SizedBox(height: 16),

                  // Language
                  _buildDropdownSetting(
                    'Language',
                    _currentSettings.language,
                    ['en', 'fr', 'es', 'de', 'it'],
                        (value) => setState(() => _currentSettings.language = value!),
                  ),
                  const SizedBox(height: 16),

                  // Timezone
                  _buildDropdownSetting(
                    'Timezone',
                    _currentSettings.timezone,
                    ['UTC', 'EST', 'PST', 'CET', 'GMT'],
                        (value) => setState(() => _currentSettings.timezone = value!),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetSettings,
                  child: const Text('Reset to Default'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveSettings,
                  child: const Text('Save Settings'),
                ),
              ),
            ],
          ),

          // Danger Zone
          const SizedBox(height: 32),
          Card(
            elevation: 2,
            color: Colors.red[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Danger Zone',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'These actions are irreversible. Please proceed with caution.',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _showConfirmationDialog(
                              'Clear All Data',
                              'This will remove all courses, sessions, and user data. This action cannot be undone.',
                                  () {
                                // Clear data logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('All data cleared')),
                                );
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: BorderSide(color: Colors.red[300]!),
                          ),
                          child: const Text('Clear All Data'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _showConfirmationDialog(
                              'Delete Account',
                              'This will permanently delete your account and all associated data.',
                                  () {
                                // Delete account logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Account deletion initiated')),
                                );
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: BorderSide(color: Colors.red[300]!),
                          ),
                          child: const Text('Delete Account'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(value, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchSetting(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDropdownSetting(String title, String value, List<String> options, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option.toUpperCase()),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}