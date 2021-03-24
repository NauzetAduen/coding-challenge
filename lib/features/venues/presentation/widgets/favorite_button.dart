import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final Color color;
  final String venueID;

  const FavoriteButton({
    Key key,
    @required this.color,
    @required this.venueID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(Icons.favorite, color: color),
        onPressed: () {
          BlocProvider.of<FavoriteBloc>(context)
              .add(ToogleFavoriteStatusEvent(venueID: venueID));
        },
      );
}
