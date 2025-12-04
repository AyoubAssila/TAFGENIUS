import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/home_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, vm, _) {
          final displayedCourses = vm.getDisplayedCourses();

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // ===== HERO SECTION =====
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Texte
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                "Transform\nYour Future\nStarting Today",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF06112A),
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Access 5,000+ expert courses and boost your career. "
                                    "Become the premium version of yourself",
                                style: TextStyle(fontSize: 18, color: Colors.grey[600], height: 1.5),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Join 100,000+ learners who have already transformed their careers",
                                style: TextStyle(fontSize: 16, color: Colors.grey[500], fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        // Image
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Redirecting to all courses page...")));
                            },
                            child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15, spreadRadius: 2)],
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1471&q=80"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // ===== POPULAR COURSES =====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular Courses (${displayedCourses.length})",
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF06112A), ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.purple[700], size: 28),
                          onPressed: vm.handleSearchToggle,
                        ),
                      ],
                    ),
                  ),
                  if (vm.showSearch)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: vm.searchController,
                              onChanged: vm.handleSearchChange,
                              decoration: InputDecoration(
                                hintText: "What do you want to learn today?",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                              ),
                            ),
                          ),
                          if (vm.searchQuery.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: vm.handleClearSearch,
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  // Courses list
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: displayedCourses.map((course) {
                        return Container(
                          width: 320,
                          margin: const EdgeInsets.only(right: 25),
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(course.icon, style: const TextStyle(fontSize: 40)),
                              const SizedBox(height: 15),
                              Text(course.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                              const SizedBox(height: 12),
                              Text("${course.lessons} lessons", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                              const SizedBox(height: 15),
                              Text(
                                "${course.price.toStringAsFixed(2)} TND",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[700],
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple[700],
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: const Text("Enroll now",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 60),
                  // ===== CTA Section =====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                    child: Column(
                      children: [
                        Text(
                          "Unlock Your Full Potential",
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: const Color(0xFF06112A), ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Join millions of learners from around the world already learning on AFTGENIUS",
                          style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[700],
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Get Started",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
