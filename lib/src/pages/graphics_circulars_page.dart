import 'package:disenos_app/src/pages/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class GraphicsCircularsPage extends StatefulWidget {
  const GraphicsCircularsPage({super.key});

  @override
  State<GraphicsCircularsPage> createState() => _GraphicsCircularsPageState();
}

class _GraphicsCircularsPageState extends State<GraphicsCircularsPage> {
  double percentage = 0.4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            setState(() {
              percentage += 0.1;
              if (percentage > 1) {
                percentage = 0;
              }
            });
          },
          child: const Icon(Icons.refresh),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CustomRadialProgress(
                  percentage: 1,
                  colorPrimary: Colors.blue,
                ),
                CustomRadialProgress(
                  percentage: percentage,
                  colorPrimary: Colors.purple,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRadialProgress(
                  percentage: percentage,
                  colorPrimary: Colors.red,
                ),
                CustomRadialProgress(
                  percentage: percentage,
                  colorPrimary: Colors.green,
                ),
              ],
            )
          ],
        ));
  }
}

class CustomRadialProgress extends StatelessWidget {
  const CustomRadialProgress({
    super.key,
    required this.percentage,
    this.colorPrimary = Colors.blue,
    this.colorSecondary = Colors.grey,
    this.strokeWidthSecondary = 4.0,
    this.strokeWidthPrimary = 10.0,
  });

  final double percentage;
  final Color colorPrimary;
  final Color colorSecondary;
  final double strokeWidthSecondary;
  final double strokeWidthPrimary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Center(
        child: RadialProgress(
          percentage: percentage,
          colorPrimary: colorPrimary,
          colorSecondary: colorSecondary,
          strokeWidthSecondary: strokeWidthSecondary,
          strokeWidthPrimary: strokeWidthPrimary,
        ),
      ),
    );
  }
}
