import '../../domain/usecases/get_venues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection.dart';
import '../bloc/venues_bloc.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("fourSquare"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 32),
              child: SizedBox(
                height: 40,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  //go vs search
                  //https://api.flutter.dev/flutter/services/TextInputAction-class.html#constants
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      isCollapsed: true,
                      hintText: "Search for a place",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ))),
                  onEditingComplete: () {
                    BlocProvider.of<VenuesBloc>(context)
                        .getVenues(const QueryParams(query: {}));
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<VenuesBloc, VenuesState>(
              builder: (context, state) {
                if (state is VenuesInitialState) {
                  return const Center(child: Text("What are you looking for?"));
                }
                return const Center(child: Text("ABC"));
              },
            ),
          )
        ],
      ),
    );
  }
}
