import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../ViewModel/stats_commercial_viewmodel.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  int maxInt(int a, int b) => a > b ? a : b;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StatsViewModel(),
      child: Consumer<StatsViewModel>(
        builder: (context, vm, _) {
          final data = vm.stats;
          final totalAge = data.ageGroups.values.fold<int>(0, (a, b) => a + b);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Sales dashboard',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // ================= KPI ROWS ===================
              Row(
                children: [
                  _kpiCard('Users', data.totalUsers.toString(),
                      Icons.people, Colors.indigo),
                  const SizedBox(width: 8),
                  _kpiCard('≥80% progression', data.users80Progress.toString(),
                      Icons.show_chart, Colors.orange),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _kpiCard('Certificates', data.usersWithCertificates.toString(),
                      Icons.card_membership, Colors.green),
                  const SizedBox(width: 8),
                  _kpiCard('Subscriptions', '🎯',
                      Icons.subscriptions, Colors.purple),
                ],
              ),

              const SizedBox(height: 18),

              // ================= AGE GROUP PIE CHART ===================
              const Text('Distribution by age group',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),

              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    height: 220,
                    child: Row(
                      children: [
                        Expanded(
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 6,
                              centerSpaceRadius: 30,
                              sections: data.ageGroups.entries.map((e) {
                                final percent = (e.value / (totalAge == 0 ? 1 : totalAge)) * 100;
                                return PieChartSectionData(
                                  value: e.value.toDouble(),
                                  radius: 60,
                                  title: '${e.key}\n${percent.toStringAsFixed(0)}%',
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: data.ageGroups.entries.map((e) {
                              final colorIdx = data.ageGroups.keys.toList().indexOf(e.key);
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      color: Colors.primaries[colorIdx % Colors.primaries.length],
                                    ),
                                    const SizedBox(width: 8),
                                    Text('${e.key}: ${e.value}'),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ================= TOP COURSES BAR CHART ===================
              const Text('Top 10 courses sold',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),

              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    height: 260,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: data.topCourses.values.first.toDouble() + 50,
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (v, meta) {
                                final labels = data.topCourses.keys.toList();
                                final idx = v.toInt();
                                if (idx < 0 || idx >= labels.length) return const Text('');
                                final txt = labels[idx];
                                return Text(txt.length > 8 ? '${txt.substring(0, 7)}...' : txt,
                                    style: const TextStyle(fontSize: 10));
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                        ),
                        barGroups: List.generate(
                          data.topCourses.length,
                              (i) => BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: data.topCourses.values.elementAt(i).toDouble(),
                                color: Colors.indigo,
                                width: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ================= EXTRA METRICS ===================
              const Text('Other metrics',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),

              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.download_done),
                        title: Text('Conversion rate'),
                        trailing: Text('4.2%'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.timer),
                        title: Text('Average duration per course'),
                        trailing: Text('3h 20m'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.star),
                        title: Text('Average course rating'),
                        trailing: Text('4.5 / 5'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.trending_up),
                        title: Text('Monthly growth'),
                        trailing: Text('+12%'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }

  Widget _kpiCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
