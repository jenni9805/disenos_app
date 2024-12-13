import 'package:disenos_app/commons/assets.dart';
import 'package:disenos_app/src/providers/slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderProvider(),
      child: const Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: _Slides(),
              ),
              _Dots(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides();

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final PageController pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      Provider.of<SliderProvider>(context, listen: false).currentPage =
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
        children: const [
          _Slide(svg: Assets.slide1),
          _Slide(svg: Assets.slide2),
          _Slide(svg: Assets.slide3),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  @override
  const _Slide({
    required this.svg,
  });

  final String svg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: SvgPicture.asset(svg),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(
            index: 0,
          ),
          _Dot(
            index: 1,
          ),
          _Dot(
            index: 2,
          ),
        ],
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
    final sliderProvider = Provider.of<SliderProvider>(context);
    final isSelected = sliderProvider.currentPage >= index - 0.5 &&
        sliderProvider.currentPage < index + 0.5;
    return AnimatedContainer(
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
      duration: const Duration(
        milliseconds: 200,
      ),
    );
  }
}
