import 'package:flutter/material.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import '../../models/live_session.dart'; // AJOUTER CET IMPORT
import '../components/modals.dart';

class LiveSessionsTab extends StatelessWidget {
  final DashboardViewModel viewModel;

  const LiveSessionsTab({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final activeSessions = viewModel.liveSessions.where((s) => s.isActive).length;
    final upcomingSessions = viewModel.liveSessions.where((s) => !s.isActive).length;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Live Sessions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => viewModel.setShowNewLiveModal(true),
                    icon: const Icon(Icons.live_tv),
                    label: const Text('New Session'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '$activeSessions live • $upcomingSessions upcoming • ${viewModel.liveSessions.length} total',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),

              if (viewModel.liveSessions.isEmpty)
                _buildEmptyState()
              else
                ...viewModel.liveSessions.map(_buildSessionCard).toList(),
            ],
          ),
        ),

        // Modals
        if (viewModel.showNewLiveModal)
          NewLiveModal(viewModel: viewModel),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!), // CORRIGÉ: retirer BorderStyle.dashed
      ),
      child: Column(
        children: [
          const Icon(Icons.live_tv, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No Live Sessions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Schedule your first live session to engage with students',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => viewModel.setShowNewLiveModal(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Schedule First Session'),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard(LiveSession session) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: session.isActive ? Colors.red[50] : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (session.isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'LIVE NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const Spacer(),
                Text(
                  session.participants.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.people, size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              session.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              session.schedule,
              style: const TextStyle(color: Colors.grey),
            ),
            if (session.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                session.description,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (session.isActive) {
                        viewModel.startLiveSession(session.id);
                      } else {
                        // Modify session
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: session.isActive ? Colors.red : Colors.blue,
                    ),
                    child: Text(session.isActive ? 'Join Live' : 'Modify'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      if (session.meetLink != null) {
                        // Open meet link
                      }
                    },
                    child: const Text('Participer'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}