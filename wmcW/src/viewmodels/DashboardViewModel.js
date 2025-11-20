import { Course, LiveSession, ForumThread, Settings } from '../models';

export class DashboardViewModel {
  constructor() {
    this.activeTab = 'dashboard';
    this.hoveredItem = null;
    this.settings = new Settings();
    this.courses = [];
    this.liveSessions = [];
    this.forumThreads = [];
    this.selectedThread = null;
    this.showNewCourseModal = false;
    this.showNewLiveModal = false;
    this.showRepliesModal = false;
    this.showSettingsModal = false;
    this.newCourse = { title: '', category: '', description: '' };
    this.newLive = { title: '', datetime: '', description: '' };
    this.newReply = '';
    this.editingCourseId = null;
    
    this.analyticsData = {
      students: { labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"], values: [65, 59, 80, 81, 56, 55] },
      engagement: { labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"], values: [30, 45, 60, 75, 55, 40, 65] },
      courses: { labels: ["Python", "ML", "Web Dev", "Data Sci", "UI/UX"], values: [320, 215, 180, 150, 95] }
    };

    // Bind de toutes les méthodes
    this.setActiveTab = this.setActiveTab.bind(this);
    this.setHoveredItem = this.setHoveredItem.bind(this);
    this.setShowNewCourseModal = this.setShowNewCourseModal.bind(this);
    this.setShowNewLiveModal = this.setShowNewLiveModal.bind(this);
    this.setShowRepliesModal = this.setShowRepliesModal.bind(this);
    this.setShowSettingsModal = this.setShowSettingsModal.bind(this);
    this.updateNewCourse = this.updateNewCourse.bind(this);
    this.updateNewLive = this.updateNewLive.bind(this);
    this.updateNewReply = this.updateNewReply.bind(this);
    this.createCourse = this.createCourse.bind(this);
    this.createLiveSession = this.createLiveSession.bind(this);
    this.addReply = this.addReply.bind(this);
    this.likeThread = this.likeThread.bind(this);
    this.likeReply = this.likeReply.bind(this);
    this.startLiveSession = this.startLiveSession.bind(this);
    this.deleteCourse = this.deleteCourse.bind(this);
    this.updateSettings = this.updateSettings.bind(this);
    this.resetSettings = this.resetSettings.bind(this);
    this.closeAllModals = this.closeAllModals.bind(this);
    this.initializeMockData = this.initializeMockData.bind(this);
    this.loadCourses = this.loadCourses.bind(this);
    this.loadLiveSessions = this.loadLiveSessions.bind(this);
    this.loadForumThreads = this.loadForumThreads.bind(this);
    this.getStats = this.getStats.bind(this);
    
    // Nouvelles méthodes pour l'édition des cours
    this.setEditingCourseId = this.setEditingCourseId.bind(this);
    this.updateCourse = this.updateCourse.bind(this);
    this.publishCourse = this.publishCourse.bind(this);
    this.unpublishCourse = this.unpublishCourse.bind(this);
  }

  // Gestion des onglets
  setActiveTab(tab) {
    this.activeTab = tab;
  }

  setHoveredItem(item) {
    this.hoveredItem = item;
  }

  // Gestion des modales
  setShowNewCourseModal(show) {
    this.showNewCourseModal = show;
    if (!show) {
      this.newCourse = { title: '', category: '', description: '' };
      this.editingCourseId = null;
    }
  }

  setShowNewLiveModal(show) {
    this.showNewLiveModal = show;
    if (!show) {
      this.newLive = { title: '', datetime: '', description: '' };
    }
  }

  setShowRepliesModal(show, thread = null) {
    this.showRepliesModal = show;
    this.selectedThread = thread;
    if (!show) {
      this.newReply = '';
    }
  }

  setShowSettingsModal(show) {
    this.showSettingsModal = show;
  }

  closeAllModals() {
    this.showNewCourseModal = false;
    this.showNewLiveModal = false;
    this.showRepliesModal = false;
    this.showSettingsModal = false;
    this.selectedThread = null;
    this.newCourse = { title: '', category: '', description: '' };
    this.newLive = { title: '', datetime: '', description: '' };
    this.newReply = '';
    this.editingCourseId = null;
  }

  // Gestion des cours
  loadCourses(coursesData) {
    this.courses = coursesData.map(course => new Course(
      course.id, 
      course.title, 
      course.category, 
      course.status, 
      course.students, 
      course.lastUpdated
    ));
  }

  updateNewCourse(field, value) {
    this.newCourse = { ...this.newCourse, [field]: value };
  }

  createCourse() {
    if (this.newCourse.title && this.newCourse.category) {
      const newCourse = new Course(
        this.courses.length + 1,
        this.newCourse.title,
        this.newCourse.category,
        'draft',
        0,
        new Date().toISOString().split('T')[0]
      );
      this.courses.push(newCourse);
      this.setShowNewCourseModal(false);
      return newCourse;
    }
    return null;
  }

  deleteCourse(courseId) {
    this.courses = this.courses.filter(course => course.id !== courseId);
  }

  // Nouvelles méthodes pour l'édition des cours
  setEditingCourseId(courseId) {
    this.editingCourseId = courseId;
  }

  updateCourse(courseId, updates) {
    const course = this.courses.find(c => c.id === courseId);
    if (course) {
      Object.keys(updates).forEach(key => {
        course[key] = updates[key];
      });
      course.lastUpdated = new Date().toISOString().split('T')[0];
      return true;
    }
    return false;
  }

  publishCourse(courseId) {
    return this.updateCourse(courseId, { status: 'published' });
  }

  unpublishCourse(courseId) {
    return this.updateCourse(courseId, { status: 'draft' });
  }

  // Gestion des sessions live
  loadLiveSessions(sessionsData) {
    this.liveSessions = sessionsData.map(session => new LiveSession(
      session.id, 
      session.title, 
      session.schedule, 
      session.participants, 
      session.isActive
    ));
  }

  updateNewLive(field, value) {
    this.newLive = { ...this.newLive, [field]: value };
  }

  createLiveSession() {
    if (this.newLive.title && this.newLive.datetime) {
      const newSession = new LiveSession(
        this.liveSessions.length + 1,
        this.newLive.title,
        new Date(this.newLive.datetime).toLocaleString(),
        0,
        false
      );
      this.liveSessions.push(newSession);
      this.setShowNewLiveModal(false);
      return newSession;
    }
    return null;
  }

  startLiveSession(sessionId) {
    const session = this.liveSessions.find(s => s.id === sessionId);
    if (session) {
      session.isActive = true;
      session.participants += 10;
    }
  }

  // Gestion du forum
  loadForumThreads(threadsData) {
    this.forumThreads = threadsData.map(thread => new ForumThread(
      thread.id, 
      thread.title, 
      thread.author, 
      thread.date, 
      thread.preview, 
      thread.replies || [], 
      thread.views, 
      thread.likes
    ));
  }

  likeThread(threadId) {
    const thread = this.forumThreads.find(t => t.id === threadId);
    if (thread) {
      thread.likes = (thread.likes || 0) + 1;
    }
  }

  updateNewReply(content) {
    this.newReply = content;
  }

  addReply() {
    if (this.newReply.trim() && this.selectedThread) {
      const thread = this.forumThreads.find(t => t.id === this.selectedThread.id);
      if (thread) {
        const newReply = {
          id: thread.replies.length + 1,
          author: "Content Manager",
          content: this.newReply,
          timestamp: new Date().toLocaleString(),
          likes: 0
        };
        thread.replies.push(newReply);
        thread.repliesCount = thread.replies.length;
        this.newReply = '';
        return true;
      }
    }
    return false;
  }

  likeReply(threadId, replyId) {
    const thread = this.forumThreads.find(t => t.id === threadId);
    if (thread) {
      const reply = thread.replies.find(r => r.id === replyId);
      if (reply) {
        reply.likes += 1;
      }
    }
  }

  // Gestion des paramètres
  updateSettings(newSettings) {
    this.settings = new Settings(
      newSettings.notifications,
      newSettings.emailAlerts,
      newSettings.darkMode,
      newSettings.autoSave,
      newSettings.language,
      newSettings.timezone
    );
    
    // Appliquer les changements en temps réel
    if (newSettings.darkMode !== undefined) {
      this.applyDarkMode(newSettings.darkMode);
    }
    
    this.setShowSettingsModal(false);
  }

  applyDarkMode(enabled) {
    if (enabled) {
      document.body.style.backgroundColor = "#1f2937";
      document.body.style.color = "white";
    } else {
      document.body.style.backgroundColor = "";
      document.body.style.color = "";
    }
  }

  resetSettings() {
    this.settings = new Settings();
  }

  // Données pour les statistiques
  getStats() {
    const totalStudents = 1250 + this.courses.reduce((acc, course) => acc + course.students, 0);
    const totalCourses = this.courses.length;
    const activeLiveSessions = this.liveSessions.filter(s => s.isActive).length;
    const totalReplies = this.forumThreads.reduce((acc, thread) => acc + thread.repliesCount, 0);
    const totalThreads = this.forumThreads.length;

    return {
      totalStudents,
      totalCourses,
      activeLiveSessions,
      totalReplies,
      totalThreads
    };
  }

  // Données mock initiales
  initializeMockData() {
    // Données de cours
    this.loadCourses([
      {
        id: 1,
        title: "Programming with Python",
        category: "Development",
        status: "published",
        students: 320,
        lastUpdated: "2024-01-10"
      },
      {
        id: 2,
        title: "Machine Learning Basics",
        category: "Data Science",
        status: "published",
        students: 215,
        lastUpdated: "2024-01-12"
      },
      {
        id: 3,
        title: "Advanced Web Development",
        category: "Development",
        status: "draft",
        students: 0,
        lastUpdated: "2024-01-14"
      },
      {
        id: 4,
        title: "Data Analysis with R",
        category: "Data Science",
        status: "published",
        students: 180,
        lastUpdated: "2024-01-08"
      },
      {
        id: 5,
        title: "UI/UX Design Fundamentals",
        category: "Design",
        status: "draft",
        students: 0,
        lastUpdated: "2024-01-15"
      }
    ]);

    // Données de sessions live
    this.loadLiveSessions([
      {
        id: 1,
        title: "Live Q&A - Advanced Python",
        schedule: new Date(Date.now() + 2 * 60 * 60 * 1000).toLocaleString(),
        participants: 45,
        isActive: false
      },
      {
        id: 2,
        title: "Introduction to Deep Learning",
        schedule: new Date(Date.now() + 24 * 60 * 60 * 1000).toLocaleString(),
        participants: 78,
        isActive: false
      },
      {
        id: 3,
        title: "Web Development Workshop",
        schedule: new Date(Date.now() + 48 * 60 * 60 * 1000).toLocaleString(),
        participants: 32,
        isActive: false
      },
      {
        id: 4,
        title: "Data Science Career Path",
        schedule: new Date(Date.now() + 72 * 60 * 60 * 1000).toLocaleString(),
        participants: 120,
        isActive: false
      }
    ]);

    // Données du forum
    this.loadForumThreads([
      {
        id: 1,
        title: "Problem with Python exercise on functions",
        author: "John Smith",
        date: "2024-01-15",
        preview: "I can't understand how to solve the exercise on functions in chapter 3. The recursive function keeps giving me errors...",
        replies: [
          {
            id: 1,
            author: "Content Manager",
            content: "Try breaking down the problem into smaller functions. Start with the base case and build up from there. Make sure your recursive call is properly structured.",
            timestamp: "2024-01-15 14:30",
            likes: 3
          },
          {
            id: 2,
            author: "Sarah Johnson",
            content: "I had the same issue. Check the documentation for function parameters and make sure you're returning the correct values in each case.",
            timestamp: "2024-01-15 15:45",
            likes: 1
          },
          {
            id: 3,
            author: "Mike Wilson",
            content: "The exercise is tricky! Try using print statements to debug each step of your recursive function.",
            timestamp: "2024-01-15 16:20",
            likes: 2
          }
        ],
        views: 45,
        likes: 5
      },
      {
        id: 2,
        title: "Question about machine learning algorithms",
        author: "Sarah Johnson",
        date: "2024-01-14",
        preview: "What's the difference between supervised and unsupervised learning? I'm confused about when to use each approach...",
        replies: [
          {
            id: 1,
            author: "Content Manager",
            content: "Supervised learning uses labeled data to train models, while unsupervised learning finds patterns in unlabeled data. Use supervised when you have labeled examples, unsupervised for exploration.",
            timestamp: "2024-01-14 16:20",
            likes: 8
          },
          {
            id: 2,
            author: "David Chen",
            content: "Great question! Supervised is like learning with a teacher (labeled data), unsupervised is like self-study (finding patterns on your own).",
            timestamp: "2024-01-14 17:30",
            likes: 4
          }
        ],
        views: 67,
        likes: 12
      },
      {
        id: 3,
        title: "Final project submission deadline extension",
        author: "Mike Wilson",
        date: "2024-01-13",
        preview: "Can the deadline for the final project be extended? I'm having some technical issues with the dataset...",
        replies: [
          {
            id: 1,
            author: "Content Manager",
            content: "We can consider a 48-hour extension for students with legitimate technical issues. Please submit a request through the support system.",
            timestamp: "2024-01-13 11:15",
            likes: 5
          }
        ],
        views: 89,
        likes: 2
      },
      {
        id: 4,
        title: "Best practices for code organization in large projects",
        author: "Emma Davis",
        date: "2024-01-12",
        preview: "I'm working on a large web application and struggling with code organization. Any recommendations for structuring the project?",
        replies: [
          {
            id: 1,
            author: "Content Manager",
            content: "Consider using a modular architecture with separate folders for components, services, utilities, and tests. Follow the single responsibility principle for each module.",
            timestamp: "2024-01-12 09:45",
            likes: 7
          },
          {
            id: 2,
            author: "Alex Thompson",
            content: "I recommend looking into design patterns like MVC or MVVM. They help keep code organized and maintainable as projects grow.",
            timestamp: "2024-01-12 14:20",
            likes: 3
          }
        ],
        views: 102,
        likes: 9
      },
      {
        id: 5,
        title: "Understanding neural networks backpropagation",
        author: "Robert Kim",
        date: "2024-01-11",
        preview: "I'm having trouble understanding how backpropagation works in neural networks. The math seems really complex...",
        replies: [
          {
            id: 1,
            author: "Content Manager",
            content: "Backpropagation is essentially the chain rule from calculus applied to neural networks. Start with understanding gradient descent first, then build up to backprop.",
            timestamp: "2024-01-11 13:10",
            likes: 6
          }
        ],
        views: 78,
        likes: 4
      }
    ]);
  }
}