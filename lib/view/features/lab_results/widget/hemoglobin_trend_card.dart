import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class HemoglobinTrendCard extends StatelessWidget {
  const HemoglobinTrendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hemoglobin Trend',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: ColorsManager.black,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                '14.2 g/dL',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.black,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: ColorsManager.lightGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '+2%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.iconGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: CustomPaint(
              painter: _LineChartPainter(),
              size: const Size(double.infinity, 90),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT']
                .map(
                  (m) => Text(
                    m,
                    style: const TextStyle(
                      fontSize: 11,
                      color: ColorsManager.lightGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final values = [0.45, 0.55, 0.40, 0.60, 0.50, 0.75];
    final points = List.generate(values.length, (i) {
      final x = i * (size.width / (values.length - 1));
      final y = size.height - (values[i] * size.height);
      return Offset(x, y);
    });

    // --- gradient fill ---
    final fillPath = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final cp1 =
          Offset((points[i].dx + points[i + 1].dx) / 2, points[i].dy);
      final cp2 =
          Offset((points[i].dx + points[i + 1].dx) / 2, points[i + 1].dy);
      fillPath.cubicTo(
          cp1.dx, cp1.dy, cp2.dx, cp2.dy, points[i + 1].dx, points[i + 1].dy);
    }
    fillPath
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        // ignore: deprecated_member_use
        ColorsManager.purble.withOpacity(0.25),
        // ignore: deprecated_member_use
        ColorsManager.purble.withOpacity(0.0),
      ],
    );
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader =
            gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // --- line ---
    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final cp1 =
          Offset((points[i].dx + points[i + 1].dx) / 2, points[i].dy);
      final cp2 =
          Offset((points[i].dx + points[i + 1].dx) / 2, points[i + 1].dy);
      linePath.cubicTo(
          cp1.dx, cp1.dy, cp2.dx, cp2.dy, points[i + 1].dx, points[i + 1].dy);
    }
    canvas.drawPath(
      linePath,
      Paint()
        ..color = ColorsManager.purble
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // --- dots ---
    for (final p in points) {
      canvas.drawCircle(p, 4, Paint()..color = ColorsManager.purble);
      canvas.drawCircle(
          p, 3, Paint()..color = Colors.white..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
