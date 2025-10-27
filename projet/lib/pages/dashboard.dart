import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _showProgressTooltip = false;

  // Statistiques
  final List<Map<String, dynamic>> stats = [
    {"title": "Courses", "value": 12},
    {"title": "Quizzes", "value": 8},
    {"title": "Certificates", "value": 5},
  ];

  // Données du graphique
  final List<DayData> chartData = [
    DayData("Mon", 2),
    DayData("Tue", 3),
    DayData("Wed", 1),
    DayData("Thu", 4),
    DayData("Fri", 2),
    DayData("Sat", 3),
    DayData("Sun", 2),
  ];

  void _handleCardClick(String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Redirect to $type history')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const Text(
            " Dashboard",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Stat cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: stats.map((s) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => _handleCardClick(s["title"]),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Text(
                            '${s["value"]}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            s["title"],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Total progress
          GestureDetector(
            onTapDown: (_) => setState(() => _showProgressTooltip = true),
            onTapUp: (_) => setState(() => _showProgressTooltip = false),
            child: Stack(
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Progress",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: 0.65,
                          minHeight: 20,
                          backgroundColor: Colors.grey[300],
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_showProgressTooltip)
                  Positioned(
                    top: 10,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text(
                        "65%",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Graphique linéaire
          Card(
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SizedBox(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SfCartesianChart(
                  primaryYAxis: NumericAxis(
                    isVisible: false, // supprime les labels de nombre
                  ),
                  primaryXAxis: CategoryAxis(
                    // noms des jours
                  ),
                  series: <CartesianSeries<DayData, String>>[
                    LineSeries<DayData, String>(
                      dataSource: chartData,
                      xValueMapper: (DayData day, _) => day.day,
                      yValueMapper: (DayData day, _) => day.value,
                      color: Colors.blue,
                      markerSettings: const MarkerSettings(isVisible: true),
                      dataLabelSettings: const DataLabelSettings(isVisible: false),
                    ),
                  ],
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Classe pour le graphique
class DayData {
  final String day;
  final int value;

  DayData(this.day, this.value);
}
