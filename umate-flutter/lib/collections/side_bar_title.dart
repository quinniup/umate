import 'package:flutter/material.dart';
import 'package:umate/pages/home/home.dart';
import 'package:umate/pages/pulsar/pulsar.dart';
import 'package:umate/pages/totp/authenticator.dart';

class SideBarTiles {
  final IconData icon;
  final String title;
  final String id;
  final String name;

  SideBarTiles({
    required this.icon,
    required this.title,
    required this.id,
    required this.name,
  });
}

List<SideBarTiles> getSideBarTitleList() {
  return [
    SideBarTiles(
      icon: Icons.home,
      title: "Home",
      id: 'home',
      name: HomePage.name,
    ),
    SideBarTiles(
      icon: Icons.security,
      title: 'TOTP',
      id: 'totp',
      name: TOTPPage.name,
    ),
    SideBarTiles(
      icon: Icons.queue,
      title: 'Pulsar',
      id: 'pulsar',
      name: PulsarPage.name,
    ),
  ];
}
