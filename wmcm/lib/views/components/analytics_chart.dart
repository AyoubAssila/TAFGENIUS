import 'package:flutter/material.dart';

class AnalyticsChart extends StatelessWidget {
  final Map<String, dynamic> data;
  final String type;
  final String title;

  const AnalyticsChart({
    super.key,
    required this.data,
    this.type = "bar",
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              child: _buildChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    final labels = data['labels'] as List<String>? ?? [];
    final values = data['values'] as List<dynamic>? ?? [];

    if (type == "bar") {
      return _buildBarChart(labels, values);
    } else {
      return _buildLineChart(labels, values);
    }
  }

  Widget _buildBarChart(List<String> labels, List<dynamic> values) {
    final maxValue = values.isNotEmpty
        ? values.map((v) => v is int ? v : 0).reduce((a, b) => a > b ? a : b)
        : 100;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(labels.length, (index) {
        final value = values[index] is int ? values[index] as int : 0;
        final height = (value / maxValue) * 150;

        return Expanded(
          child: Column(
            children: [
              Text(
                value.toString(),
                style: const TextStyle(fontSize: 10),
              ),
              const SizedBox(height: 4),
              Container(
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                labels[index],
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLineChart(List<String> labels, List<dynamic> values) {
    return CustomPaint(
      size: const Size(double.infinity, 150),
      painter: _LineChartPainter(labels: labels, values: values),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<String> labels;
  final List<dynamic> values;

  _LineChartPainter({required this.labels, required this.values});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final maxValue = values.isNotEmpty
        ? values.map((v) => v is int ? v : 0).reduce((a, b) => a > b ? a : b)
        : 100;

    final points = <Offset>[];
    final spacing = size.width / (labels.length - 1);

    for (int i = 0; i < values.length; i++) {
      final value = values[i] is int ? values[i] as int : 0;
      final x = i * spacing;
      final y = size.height - (value / maxValue) * size.height;
      points.add(Offset(x, y));
    }

    // Draw line
    final path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(path, paint);
    }

    // Draw points
    for (final point in points) {
      canvas.drawCircle(point, 4, paint..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}