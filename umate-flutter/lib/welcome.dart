import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title});

  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentIndex = 0;
  NavigationRailLabelType nrt = NavigationRailLabelType.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _currentIndex,
            //groupAlignment: groupAlignment,
            onDestinationSelected: (value) => setState(() {
              _currentIndex = value;
            }),
            labelType: nrt,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.account_tree_outlined),
                selectedIcon: Icon(Icons.account_tree_rounded),
                label: Text('Cert'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.rate_review_outlined),
                selectedIcon: Icon(Icons.rate_review_rounded),
                label: Text('Pulsar'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          const Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WelcomePage(title: 'Welcome to UMate'),
            ],
          )),
        ],
      )),
    );
  }
}
