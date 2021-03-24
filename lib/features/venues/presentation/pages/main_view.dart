import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/venues_bloc.dart';
import '../widgets/initial_message.dart';
import '../widgets/loading_box.dart';
import '../widgets/rotated_fab.dart';
import '../widgets/search_textfield.dart';
import '../widgets/venues_listview.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:
              Text("fourSquare", style: Theme.of(context).textTheme.headline1),
          centerTitle: true,
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
                  } else if (state is EmptyVenuesState) {
                    //TODO IMPROVE EMPTY STATE
                    return const Center(
                        child: Text("We couldn't find anything."));
                  } else if (state is ErrorVenuesState) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return const Center(child: Text("ERROR"));
                },
              ),
            )
          ],
        ),
        floatingActionButton: const RoatedFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
}
