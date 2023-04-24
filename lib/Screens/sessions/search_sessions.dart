// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/utils.dart';

class SearchSession extends StatelessWidget {
  const SearchSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Search Sessions",
        actions: [],
        leading: BackButtonNav(),
      ),
    );
  }
}
