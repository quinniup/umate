import 'dart:ffi';

import 'package:flutter/material.dart';

import 'welcome.dart';

void main() {
  runApp(const UMateAPP());
}

class UMateAPP extends StatelessWidget {
  const UMateAPP({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFA09A9A)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

const DYNAMIC_LIBRARY_FILE_NAME_MACOS = "libdartffi.dylib";

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  int _currentIndex = 0;
  // double groupAlignment = 0.0;
  NavigationRailLabelType nrt = NavigationRailLabelType.all;

  static DynamicLibrary _loadLibrary() {
    return DynamicLibrary.open(DYNAMIC_LIBRARY_FILE_NAME_MACOS);
  }

  @override
  Widget build(BuildContext context) {
    return WelcomePage(title: 'Welcome to UMate');
  }
}
