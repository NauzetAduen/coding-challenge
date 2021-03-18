import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/venues_bloc.dart';

///Textfield for querying
///
///calls GetVenuesEvent
class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
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
              //https://flutterigniter.com/dismiss-keyboard-form-lose-focus/
              final FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

              BlocProvider.of<VenuesBloc>(context)
                  .add(const GetVenuesEvent(queryParams: {}));
            },
          ),
        ),
      );
}
//TODO TextEditControlled to add query to queryParams