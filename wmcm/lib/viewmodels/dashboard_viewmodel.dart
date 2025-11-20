import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/live_session.dart';
import '../models/forum_thread.dart';
import '../models/settings.dart';
import '../services/data_service.dart';

class DashboardViewModel extends ChangeNotifier {
  String _activeTab = 'dashboard';
  final Settings _settings = Settings();
  final List<Course> _courses = [];
  final List<LiveSession> _liveSessions = [];
  final List<ForumThread> _forumThreads = [];
  ForumThread? _selectedThread;

  bool _showNewCourseModal = false;
  bool _showNewLiveModal = false;
  bool _showRepliesModal = false;
  bool _showSettingsModal = false;

  Map<String, dynamic> _newCourse = {
    'title': '',
    'category': '',
    'description': ''
  };

  Map<String, dynamic> _newLive = {
    'title': '',
    'datetime': '',
    'description': ''
  };

  String _newReply = '';
  String? _editingCourseId;

  final DataService _dataService = DataService();

  // Analytics data
  final Map<String, dynamic> _analyticsData = {
    'students': {
      'labels': ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
      'values': [65, 59, 80, 81, 56, 55]
    },
    'engagement': {
      'labels': ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
      'values': [30, 45, 60, 75, 55, 40, 65]
    },
    'courses': {
      'labels': ["Python", "ML", "Web Dev", "Data Sci", "UI/UX"],
      'values': [320, 215, 180, 150, 95]
    }
  };

  // Getters
  String get activeTab => _activeTab;
  Settings get settings => _settings;
  List<Course> get courses => _courses;
  List<LiveSession> get liveSessions => _liveSessions;
  List<ForumThread> get forumThreads => _forumThreads;
  ForumThread? get selectedThread => _selectedThread;
  bool get showNewCourseModal => _showNewCourseModal;
  bool get showNewLiveModal => _showNewLiveModal;
  bool get showRepliesModal => _showRepliesModal;
  bool get showSettingsModal => _showSettingsModal;
  Map<String, dynamic> get newCourse => _newCourse;
  Map<String, dynamic> get newLive => _newLive;
  String get newReply => _newReply;
  String? get editingCourseId => _editingCourseId;
  Map<String, dynamic> get analyticsData => _analyticsData;

  // Methods
  void setActiveTab(String tab) {
    _activeTab = tab;
    notifyListeners();
  }

  void setShowNewCourseModal(bool show) {
    _showNewCourseModal = show;
    if (!show) {
      _newCourse = {'title': '', 'category': '', 'description': ''};
      _editingCourseId = null;
    }
    notifyListeners();
  }

  void setShowNewLiveModal(bool show) {
    _showNewLiveModal = show;
    if (!show) {
      _newLive = {'title': '', 'datetime': '', 'description': ''};
    }
    notifyListeners();
  }

  void setShowRepliesModal(bool show, [ForumThread? thread]) {
    _showRepliesModal = show;
    _selectedThread = thread;
    if (!show) {
      _newReply = '';
    }
    notifyListeners();
  }

  void setShowSettingsModal(bool show) {
    _showSettingsModal = show;
    notifyListeners();
  }

  void updateNewCourse(String field, String value) {
    _newCourse[field] = value;
    notifyListeners();
  }

  void updateNewLive(String field, String value) {
    _newLive[field] = value;
    notifyListeners();
  }

  void updateNewReply(String content) {
    _newReply = content;
    notifyListeners();
  }

  void createCourse() {
    if (_newCourse['title'].toString().isNotEmpty &&
        _newCourse['category'].toString().isNotEmpty) {
      final newCourse = Course(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _newCourse['title'].toString(),
        category: _newCourse['category'].toString(),
        description: _newCourse['description'].toString(),
        lastUpdated: DateTime.now().toIso8601String().split('T')[0],
      );
      _courses.add(newCourse);
      _dataService.saveCourse(newCourse);
      setShowNewCourseModal(false);
    }
  }

  void createLiveSession() {
    if (_newLive['title'].toString().isNotEmpty &&
        _newLive['datetime'].toString().isNotEmpty) {
      final newSession = LiveSession(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _newLive['title'].toString(),
        schedule: _newLive['datetime'].toString(),
        description: _newLive['description'].toString(),
      );
      _liveSessions.add(newSession);
      _dataService.saveLiveSession(newSession);
      setShowNewLiveModal(false);
    }
  }

  void deleteCourse(String courseId) {
    _courses.removeWhere((course) => course.id == courseId);
    notifyListeners();
  }

  void startLiveSession(String sessionId) {
    final session = _liveSessions.firstWhere(
          (s) => s.id == sessionId,
      orElse: () => LiveSession(id: '', title: '', schedule: ''),
    );
    if (session.id.isNotEmpty) {
      session.isActive = true;
      session.participants += 10;
      notifyListeners();
    }
  }

  void updateSettings(Settings newSettings) {
    _settings.notifications = newSettings.notifications;
    _settings.emailAlerts = newSettings.emailAlerts;
    _settings.darkMode = newSettings.darkMode;
    _settings.autoSave = newSettings.autoSave;
    _settings.language = newSettings.language;
    _settings.timezone = newSettings.timezone;
    notifyListeners();
  }

  Map<String, dynamic> getStats() {
    final totalStudents = 1250 + _courses.fold(0, (sum, course) => sum + course.students);
    final totalCourses = _courses.length;
    final activeLiveSessions = _liveSessions.where((s) => s.isActive).length;
    final totalReplies = _forumThreads.fold(0, (sum, thread) => sum + thread.repliesCount);
    final totalThreads = _forumThreads.length;

    return {
      'totalStudents': totalStudents,
      'totalCourses': totalCourses,
      'activeLiveSessions': activeLiveSessions,
      'totalReplies': totalReplies,
      'totalThreads': totalThreads,
    };
  }

  // Initialize mock data
  void initializeMockData() {
    // Courses
    _courses.addAll([
      Course(
        id: '1',
        title: "Programming with Python",
        category: "Development",
        status: "published",
        students: 320,
        lastUpdated: "2024-01-10",
      ),
      Course(
        id: '2',
        title: "Machine Learning Basics",
        category: "Data Science",
        status: "published",
        students: 215,
        lastUpdated: "2024-01-12",
      ),
      Course(
        id: '3',
        title: "Advanced Web Development",
        category: "Development",
        status: "draft",
        students: 0,
        lastUpdated: "2024-01-14",
      ),
    ]);

    // Live Sessions
    _liveSessions.addAll([
      LiveSession(
        id: '1',
        title: "Live Q&A - Advanced Python",
        schedule: DateTime.now().add(const Duration(hours: 2)).toString(),
        participants: 45,
        isActive: false,
        meetLink: "https://meet.google.com/abc-xyz-123",
      ),
      LiveSession(
        id: '2',
        title: "Introduction to Deep Learning",
        schedule: DateTime.now().add(const Duration(days: 1)).toString(),
        participants: 78,
        isActive: false,
        meetLink: "https://meet.google.com/def-uvw-456",
      ),
    ]);

    // Forum Threads
    _forumThreads.addAll([
      ForumThread(
        id: '1',
        title: "Problem with Python exercise on functions",
        author: "John Smith",
        date: "2024-01-15",
        preview: "I can't understand how to solve the exercise on functions in chapter 3...",
        replies: [
          Reply(
            id: '1',
            author: "Content Manager",
            content: "Try breaking down the problem into smaller functions. Start with the base case and build up from there.",
            timestamp: "2024-01-15 14:30",
            likes: 3,
          ),
        ],
        views: 45,
        likes: 5,
      ),
      ForumThread(
        id: '2',
        title: "Question about machine learning algorithms",
        author: "Sarah Johnson",
        date: "2024-01-14",
        preview: "What's the difference between supervised and unsupervised learning?",
        replies: [
          Reply(
            id: '1',
            author: "Content Manager",
            content: "Supervised learning uses labeled data to train models, while unsupervised learning finds patterns in unlabeled data.",
            timestamp: "2024-01-14 16:20",
            likes: 8,
          ),
        ],
        views: 67,
        likes: 12,
      ),
    ]);

    notifyListeners();
  }
}