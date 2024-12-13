import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool dotsUp;
  final Color primaryColor;
  final Color secondaryColor;
  final double separation;
  final double bulletPrimary;
  final double bulletSecondary;

  const Slideshow({
    super.key,
    required this.slides,
    this.dotsUp = false,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.separation = 5,
    this.bulletPrimary = 12,
    this.bulletSecondary = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _SliderProvider(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              Provider.of<_SliderProvider>(context)._colorPrimary =
                  primaryColor;

              Provider.of<_SliderProvider>(context)._colorSecondary =
                  secondaryColor;
              Provider.of<_SliderProvider>(context).separation = separation;
              Provider.of<_SliderProvider>(context).bulletPrimary =
                  bulletPrimary;
              Provider.of<_SliderProvider>(context).bulletSecondary =
                  bulletSecondary;

              return Column(
                children: [
                  if (dotsUp)
                    _Dots(
                      totalSlides: slides.length,
                    ),
                  Expanded(
                    child: _Slides(
                      slides: slides,
                    ),
                  ),
                  if (!dotsUp)
                    _Dots(
                      totalSlides: slides.length,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides({
    required this.slides,
  });

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final PageController pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      Provider.of<_SliderProvider>(context, listen: false).currentPage =
          pageController.page ?? 0;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PageView(
        controller: pageController,
        children: widget.slides
            .map((slide) => _Slide(
                  slide: slide,
                ))
            .toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  @override
  const _Slide({
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;

  const _Dots({
    required this.totalSlides,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalSlides,
          (i) => _Dot(
            index: i,
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final sliderProvider = Provider.of<_SliderProvider>(context);
    final isSelected = sliderProvider.currentPage >= index - 0.5 &&
        sliderProvider.currentPage < index + 0.5;

    return AnimatedContainer(
      width: isSelected
          ? sliderProvider.bulletPrimary
          : sliderProvider.bulletSecondary,
      height: isSelected
          ? sliderProvider.bulletPrimary
          : sliderProvider.bulletSecondary,
      margin: EdgeInsets.symmetric(
        horizontal: sliderProvider.separation,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? sliderProvider.colorPrimary
            : sliderProvider.colorSecondary,
        shape: BoxShape.circle,
      ),
      duration: const Duration(
        milliseconds: 200,
      ),
    );
  }
}

class _SliderProvider with ChangeNotifier {
  double _currentPage = 0;
  Color _colorPrimary = Colors.blue;
  Color _colorSecondary = Colors.grey;
  double _separation = 5;
  double _bulletPrimary = 12;
  double _bulletSecondary = 12;

  double get currentPage => _currentPage;
  Color get colorPrimary => _colorPrimary;
  Color get colorSecondary => _colorSecondary;
  double get separation => _separation;
  double get bulletPrimary => _bulletPrimary;
  double get bulletSecondary => _bulletSecondary;

  set currentPage(double value) {
    _currentPage = value;
    notifyListeners();
  }

  set colorPrimary(Color value) {
    _colorPrimary = value;
  }

  set colorSecondary(Color value) {
    _colorSecondary = value;
  }

  set separation(double value) {
    _separation = value;
  }

  set bulletPrimary(double value) {
    _bulletPrimary = value;
  }

  set bulletSecondary(double value) {
    _bulletSecondary = value;
  }
}
