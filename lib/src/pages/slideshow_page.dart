import 'package:disenos_app/commons/assets.dart';
import 'package:disenos_app/src/pages/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listWidgets = [
      SvgPicture.asset(Assets.slide1),
      SvgPicture.asset(Assets.slide2),
      SvgPicture.asset(Assets.slide3),
      SvgPicture.asset(Assets.slide4),
      SvgPicture.asset(Assets.slide5),
    ];

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _MySlideShow(listWidgets: listWidgets),
          ],
        ),
      ),
    );
  }
}

class _MySlideShow extends StatelessWidget {
  const _MySlideShow({
    super.key,
    required this.listWidgets,
  });

  final List<SvgPicture> listWidgets;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Slideshow(
        slides: listWidgets,
        primaryColor: Colors.purple,
        secondaryColor: Colors.lightBlue,
        bulletPrimary: 15,
        separation: 10,
      ),
    );
  }
}
