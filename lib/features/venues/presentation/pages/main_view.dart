import 'package:coding_challenge/features/venues/presentation/bloc/venues_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("fourSquare"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: SizedBox(
              height: 60,
              child: TextField(
                //go vs search
                //https://api.flutter.dev/flutter/services/TextInputAction-class.html#constants
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search for a place",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18)))),
              ),
            ),
          ),
          BlocProvider(
              create: (context) => sl<VenuesBloc>(),
              child: Expanded(
                child: BlocBuilder<VenuesBloc, VenuesState>(
                  builder: (context, state) {
                    if (state is VenuesInitialState) {
                      return const Text("INITIAL");
                    }
                    return const Center(child: Text("ABC"));
                  },
                ),
              ))
        ],
      ),
    );
  }
}
