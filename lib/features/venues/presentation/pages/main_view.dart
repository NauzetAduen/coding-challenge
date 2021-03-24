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
                  if (state is VenuesInitialState) {
                    return const InitialMessage();
                  } else if (state is LoadingVenuesState) {
                    return const LoadingBox();
                  } else if (state is LoadedVenuesState) {
                    return VenuesListView(list: state.venuesList);
                  } else if (state is EmptyVenuesState) {
                    return Center(
                        child: Text(
                      "We couldn't find anything.\nTry again.",
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ));
                  } else if (state is ErrorVenuesState) {
                    return Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
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
