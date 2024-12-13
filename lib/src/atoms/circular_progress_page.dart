import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgressPage extends StatefulWidget {
  const CircularProgressPage({super.key});

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  double percentage = 0.0;
  double newPercentage = 0.0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    controller.addListener(() {
      //print('Valor controller ${controller.value}');

      setState(() {
        percentage = lerpDouble(percentage, newPercentage, controller.value)!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 300,
          width: 300,
          child: CustomPaint(
            painter: _CircularProgressPainter(
              percentage: percentage,
              color: Colors.blue,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          percentage = newPercentage;
          newPercentage += 0.1;
          if (percentage > 1) {
            percentage = 0;
          }
          controller.forward(from: 0.0);
          setState(() {});
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color color;

  _CircularProgressPainter({
    required this.percentage,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //Circulo completado
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);

    //Arco
    final paintArc = Paint()
      ..strokeWidth = 10
      ..color = color
      ..style = PaintingStyle.stroke;

    double arcAngle = 2 * pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
