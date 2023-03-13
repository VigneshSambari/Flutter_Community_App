// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sessions/components/navbar.dart';
import 'package:sessions/screens/home/home_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(),
      bottomNavigationBar: NavBarAnimated(),
    );
  }
}
