import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double percentage;
  final Color colorPrimary;
  final Color colorSecondary;
  final double strokeWidthSecondary;
  final double strokeWidthPrimary;

  const RadialProgress({
    super.key,
    required this.percentage,
    this.colorPrimary = Colors.blue,
    this.colorSecondary = Colors.grey,
    this.strokeWidthSecondary = 4.0,
    this.strokeWidthPrimary = 10.0,
  });

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  double previousPercentage = 0.0;

  @override
  void initState() {
    previousPercentage = widget.percentage;

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);

    final difference = widget.percentage - previousPercentage;

    previousPercentage = widget.percentage;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _RadialProgressPainter(
              percentage: (widget.percentage - difference) +
                  (difference * controller.value),
              colorPrimary: widget.colorPrimary,
              colorSecondary: widget.colorSecondary,
              strokeWidthSecondary: widget.strokeWidthSecondary,
              strokeWidthPrimary: widget.strokeWidthPrimary,
            ),
          ),
        );
      },
    );
  }
}

class _RadialProgressPainter extends CustomPainter {
  final double percentage;
  final Color colorPrimary;
  final Color colorSecondary;
  final double strokeWidthSecondary;
  final double strokeWidthPrimary;

  _RadialProgressPainter({
    required this.percentage,
    required this.colorPrimary,
    required this.colorSecondary,
    required this.strokeWidthSecondary,
    required this.strokeWidthPrimary,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Gradient gradient = const LinearGradient(
      colors: [
        Colors.pink,
        Colors.purple,
        Colors.lightBlue,
      ],
    );

    final Rect rect = Rect.fromCircle(
      center: const Offset(0, 0),
      radius: 180,
    );

    //Circulo completado
    final paint = Paint()
      ..strokeWidth = strokeWidthSecondary
      ..color = colorSecondary
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);

    //Arco
    final paintArc = Paint()
      ..strokeWidth = strokeWidthPrimary
      ..strokeCap = StrokeCap.round
      //..color = colorPrimary
      ..shader = gradient.createShader(
        rect,
      )
      ..style = PaintingStyle.stroke;

    double arcAngle = 2 * pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -pi / 2,
      arcAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
