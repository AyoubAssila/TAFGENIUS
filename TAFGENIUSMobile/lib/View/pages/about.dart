import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/about_viewmodel.dart';
import '../components/team_member_card.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AboutViewModel(),
      child: Consumer<AboutViewModel>(
        builder: (context, vm, child) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Center(
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sections
                  ...vm.sections.map((section) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(section.title,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Text(
                            section.content,
                            style: const TextStyle(
                                fontSize: 16, height: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )),

                  // Team
                  const Text('Our Team',
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...vm.teamMembers
                      .map((member) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TeamMemberCard(member: member),
                  ))
                      .toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
