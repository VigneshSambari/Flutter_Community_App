import 'package:flutter/material.dart';
import 'package:sessions/bloc/profile/profile_bloc_imports.dart';

class MultiBlocBuilder extends StatelessWidget {
  final List<Bloc> blocs;
  final List<Widget Function(BuildContext, dynamic)> builders;

  const MultiBlocBuilder({
    super.key,
    required this.blocs,
    required this.builders,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: List.generate(blocs.length, (index) {
        return BlocListener(
          bloc: blocs[index],
          listener: (context, state) {
            // Do something in response to state changes
          },
        );
      }),
      child: ListView.builder(
        itemCount: blocs.length,
        itemBuilder: (context, index) {
          return BlocBuilder(
            bloc: blocs[index],
            builder: builders[index],
          );
        },
      ),
    );
  }
}
