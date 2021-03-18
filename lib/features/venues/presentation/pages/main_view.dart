import 'package:coding_challenge/features/venues/presentation/widgets/venues_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/venues_bloc.dart';
import '../widgets/initial_message.dart';
import '../widgets/loading_box.dart';
import '../widgets/search_textfield.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("fourSquare"),
        ),
        body: Column(
          children: [
            const SearchTextField(),
            Expanded(
              child: BlocBuilder<VenuesBloc, VenuesState>(
                builder: (context, state) {
                  //TODO add each state
                  if (state is VenuesInitialState) {
                    return const InitialMessage();
                  } else if (state is LoadingVenuesState) {
                    return const LoadingBox();
                  } else if (state is LoadedVenuesState) {
                    return VenuesListView(list: state.venuesList);
                  }
                  return const Center(child: Text("ERROR"));
                },
              ),
            )
          ],
        ),
      );
}
