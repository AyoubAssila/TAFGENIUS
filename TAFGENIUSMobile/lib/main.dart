import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:tafgeniusmobile/View/components/navbar_commercial.dart';
import 'ViewModel/dashboard_viewmodel.dart';
import 'ViewModel/dashboard_viewmodel.dart' as contenu;
import 'firebase_options.dart';
import 'package:tafgeniusmobile/Model/user_model.dart';
// Layouts
import 'package:tafgeniusmobile/View/components/navbar_widget.dart';
import 'package:tafgeniusmobile/View/components/navbar_accueil_widget.dart';
import 'package:tafgeniusmobile/View/components/sidebar_widget.dart';
import 'package:tafgeniusmobile/View/pages/dashboard_commercial.dart';
import 'package:tafgeniusmobile/View/pages/dashboard_webcontenu.dart' as contenu;
import 'package:tafgeniusmobile/View/pages/dashboard_webtechnique.dart' as technique_dashboard;
import 'package:tafgeniusmobile/View/components/header_webcontenu.dart';
import 'package:tafgeniusmobile/View/components/sidebar_webcontenu.dart';
import 'package:tafgeniusmobile/View/components/navbar_webtechnique.dart';



// Pages publiques
import 'package:tafgeniusmobile/View/pages/home.dart';
import 'package:tafgeniusmobile/View/pages/blogpublic.dart' as blogpublic;
import 'package:tafgeniusmobile/View/pages/aboutpublic.dart' as aboutpublic;

import 'package:tafgeniusmobile/View/pages/login.dart';
import 'package:tafgeniusmobile/View/pages/signup.dart';

// Pages étudiant
import 'package:tafgeniusmobile/View/pages/etudiant.dart';
import 'package:tafgeniusmobile/View/pages/dashboard.dart';
import 'package:tafgeniusmobile/View/pages/my_course.dart';
import 'package:tafgeniusmobile/View/pages/history.dart';
import 'package:tafgeniusmobile/View/pages/editprofile.dart';
import 'package:tafgeniusmobile/View/pages/blog_etudiant.dart';
import 'package:tafgeniusmobile/View/pages/about.dart';

// ViewModels
import 'ViewModel/login_viewmodel.dart';
import 'ViewModel/signup_viewmodel.dart';
export '../ViewModel/dashboard_viewmodel.dart';

// Pages Admin Technique - ALIAS
import 'package:tafgeniusmobile/View/pages/user.dart' as technique_users;
import 'package:tafgeniusmobile/View/pages/logs.dart' as technique_logs;
import 'View/pages/blog_content_webmaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // Crée un UserModel dynamique à partir de l'utilisateur connecté
    final userModel = UserModel(
      id: user.uid,
      name: user.displayName ?? 'Étudiant',
      email: user.email ?? '',
    );


    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => SignupViewModel()),
          ChangeNotifierProvider(create: (_) => DashboardViewModel()),
          Provider<UserModel>.value(value: userModel), // Fournit l'utilisateur connecté
        ],
        child: const MyApp(),
      ),
    );
  } else {
    // Si pas d'utilisateur connecté, on lance l'application normalement
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => SignupViewModel()),
          ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ],
        child: const MyApp(),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TAFGenius',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // Pages publiques
        '/': (context) => PublicLayout(child: HomePage()),
        '/login': (context) => PublicLayout(child: LoginView()),
        '/signup': (context) => PublicLayout(child: SignupPage()),
        '/blog-public': (context) => PublicLayout(child: blogpublic.BlogPublicPage()),
        '/aboutpublic': (context) => PublicLayout(child: aboutpublic.AboutPublicPage()),

        // Pages étudiant
        '/etudiant': (context) => EtudiantLayout(child: DashboardPage()),
        '/dashboard': (context) => EtudiantLayout(child: DashboardPage()),
        '/mycourses': (context) {
          final user = UserModel(
            id: 'user123',
            name: 'John Doe',
            email: 'john@example.com',
          );

          return EtudiantLayout(
            child: MyCoursesPage(
              user: user,
              courses: const [], // ici tu peux charger les cours depuis Firebase
            ),
          );
        },

        '/history': (context) {
          final user = UserModel(
            id: 'user123',
            name: 'John Doe',
            email: 'john@example.com',
          );

          return EtudiantLayout(
            child: HistoryView(userId: user.id),
          );
        },

        '/edit-profile': (context) {
          final user = UserModel(
            id: 'user123',
            name: 'John Doe',
            email: 'john@example.com',
          );

          return EtudiantLayout(
            child: EditProfilePage(user: user),
          );
        },

        '/blog-etudiant': (context) =>
            EtudiantLayout(child: BlogEtudiantPage()),

        '/about': (context) => EtudiantLayout(child: AboutPage()),

        // Admin Commercial
        '/admin-commercial': (context) =>
            AdminCommercialLayout(child: DashboardCommercialPage()),

        // Admin Contenu
        '/admin-contenu': (context) => const AdminContenuLayout(),

        // Pour afficher BlogContentWebmasterPage dans le layout contenu,
        // on utilise le petit wrapper AdminContenuLayoutWithChild (ajouté ci-dessous).
        '/blog-contenu': (context) => AdminContenuLayoutWithChild(
          child: BlogContentWebmasterPage(),
        ),

        // Admin Technique
        '/admin-technique': (context) =>
        const technique_dashboard.DashboardScreen(),

        '/admin-technique/dashboard': (context) =>
        const technique_dashboard.DashboardScreen(),

        '/admin-technique/users': (context) =>
        const technique_users.UsersScreen(),

        '/admin-technique/logs': (context) =>
        const technique_logs.LogsScreen(),

      },
    );
  }
}

// ----------------------------
// Petit wrapper : AdminContenuLayoutWithChild
// (NE CHANGE AUCUN NOM EXISTANT — ce wrapper permet simplement
//  d'afficher une page dans le layout web contenu sans modifier
//  ta classe AdminContenuLayout existante)
// ----------------------------
class AdminContenuLayoutWithChild extends StatelessWidget {
  final Widget child;

  const AdminContenuLayoutWithChild({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // On réutilise les mêmes composants (HeaderWebContenu, SidebarWebcontenu)
    // pour garder le même look que AdminContenuLayout.
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: HeaderWebContenu(
          activeTab: 'dashboard',
          onLogoTap: () {
            // ouvrir le drawer si besoin — on ne gère pas le drawer key ici
            ScaffoldMessenger.of(context);
          },
        ),
      ),
      drawer: SidebarWebcontenu(
        activeTab: 'dashboard',
        onTabChange: (_) {},
        onNavigateToHome: () {
          Navigator.pushNamed(context, '/');
        },
      ),
      body: child,
    );
  }
}

class PublicLayout extends StatelessWidget {
  final Widget child;
  const PublicLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: NavbarAccueilWidget(
          onNavigate: (route) => Navigator.pushNamed(context, route),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5), // léger espace à gauche et droite
        child: Align(
          alignment: Alignment.topLeft, // le contenu reste collé à gauche
          child: child, // le contenu principal
        ),
      ),
    );
  }
}


// Layout Étudiant
class EtudiantLayout extends StatefulWidget {
  final Widget child;
  const EtudiantLayout({super.key, required this.child});

  @override
  State<EtudiantLayout> createState() => _EtudiantLayoutState();
}

class _EtudiantLayoutState extends State<EtudiantLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  void _navigate(String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: NavbarWidget(onLogoTap: _openDrawer),
      ),
      drawer: Drawer(
        child: SidebarWidget(
          onSelectPage: _navigate,
          textColor: Colors.white,
          activeColor: Colors.blueAccent,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: widget.child,
      ),
    );
  }
}

// Layout Admin Commercial
class AdminCommercialLayout extends StatelessWidget {
  final Widget child;
  const AdminCommercialLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: NavbarCommercialWidget(onLogoTap: () {}),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}

// =================== LAYOUT ADMIN CONTENU ===================
class AdminContenuLayout extends StatefulWidget {
  const AdminContenuLayout({super.key});

  @override
  State<AdminContenuLayout> createState() => _AdminContenuLayoutState();
}

class _AdminContenuLayoutState extends State<AdminContenuLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _activeTab = 'dashboard';

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _handleTabChange(String tab) {
    setState(() {
      _activeTab = tab;
    });
  }

  void _handleNavigateToHome() {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: HeaderWebContenu(
          activeTab: _activeTab,
          onLogoTap: _openDrawer,
        ),
      ),
      drawer: SidebarWebcontenu(
        activeTab: _activeTab,
        onTabChange: _handleTabChange,
        onNavigateToHome: _handleNavigateToHome,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre de la page sous le header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Text(
              _getPageTitle(_activeTab),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF06112A),
              ),
            ),
          ),

          // Contenu principal
          Expanded(
            child: contenu.DashboardView(
              onNavigateToHome: _handleNavigateToHome,
              activeTab: _activeTab,
            ),
          ),
        ],
      ),
    );
  }

// Helper pour le nom de la page selon l'onglet actif
  String _getPageTitle(String tab) {
    switch (tab) {
      case 'dashboard':
        return 'Dashboard Overview';
      case 'courses':
        return 'Course Management';
      case 'messaging':
        return 'Messaging';
      case 'live':
        return 'Live Sessions';
      case 'analytics':
        return 'Analytics & Statistics';
      case 'settings':
        return 'Settings & Preferences';
      default:
        return 'Dashboard';
    }

  }
}
// =================== LAYOUT ADMIN TECHNIQUE ===================
class AdminTechniqueLayout extends StatefulWidget {
  final Widget child;
  const AdminTechniqueLayout({super.key, required this.child});

  @override
  State<AdminTechniqueLayout> createState() => _AdminTechniqueLayoutState();
}

class _AdminTechniqueLayoutState extends State<AdminTechniqueLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: NavbarWebTechnique(
          onLogoTap: _openDrawer,
        ),
      ),
      drawer: NavigationDrawer(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF06112A)),
            child: const Text(
              "Admin Technique",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const technique_dashboard.DashboardScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Users"),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const technique_users.UsersScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("Logs"),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const technique_logs.LogsScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: widget.child,
      ),
    );
  }
}
