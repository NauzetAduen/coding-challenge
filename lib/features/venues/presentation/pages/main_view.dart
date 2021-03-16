import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../bloc/venues_bloc.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("fourSquare"),
      ),
      body: Column(
        children: [
          Padding(
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
                  // BlocProvider.of<VenuesBloc>(context)
                  //     .getVenues(const QueryParams(query: {}));
                  BlocProvider.of<VenuesBloc>(context)
                      .add(const GetVenuesEvent(queryParams: {}));
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
              child: BlocBuilder<VenuesBloc, VenuesState>(
                builder: (context, state) {
                  if (state is VenuesInitialState) {
                    return const Center(
                        child: Text("What are you looking for?"));
                  } else if (state is LoadingVenuesState) {
                    return Center(
                        child: SizedBox(
                      width: 60,
                      height: 60,
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineScaleParty,
                        color: Colors.white,
                      ),
                    ));
                  }
                  return const Center(child: Text("ABC"));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
