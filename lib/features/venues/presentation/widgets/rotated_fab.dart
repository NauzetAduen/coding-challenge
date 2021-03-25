import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/venues_bloc.dart';

class RoatedFab extends StatelessWidget {
  const RoatedFab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<VenuesBloc, VenuesState>(
        builder: (context, state) {
          if (state is LoadedVenuesState) {
            return Transform.rotate(
              //360 / 4 = 90º rotated
              angle: math.pi / 4,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/map",
                    arguments: state.venuesList,
                  );
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: const Icon(Icons.zoom_out_map_sharp),
              ),
            );
          }

          return Container();
        },
      );
}
