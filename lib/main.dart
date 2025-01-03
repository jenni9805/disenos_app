//import 'package:disenos_app/src/challenges/square_animated_page.dart';
//import 'package:disenos_app/src/pages/animation_page.dart';
//import 'package:disenos_app/src/pages/headers_page.dart';
//import 'package:disenos_app/src/pages/graphics_circulars_page.dart';
import 'package:disenos_app/src/pages/slideshow_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SlideshowPage(),
    );
  }
}
