import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/venues_bloc.dart';

///Textfield for querying
///
///calls GetVenuesEvent
class SearchTextField extends StatefulWidget {
  const SearchTextField({
    Key key,
  }) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 32),
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          //go vs search
          //https://api.flutter.dev/flutter/services/TextInputAction-class.html#constants
          textInputAction: TextInputAction.search,
          cursorColor: Theme.of(context).accentColor,
          cursorWidth: 4,

          decoration: InputDecoration(
              filled: true,
              prefixIcon: Icon(
                FontAwesomeIcons.searchLocation,
                color: Theme.of(context).dividerColor,
                size: 20,
              ),
              isCollapsed: true,
              hintText: "Search for a place",
              hintStyle: Theme.of(context).textTheme.subtitle1,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(18),
              ))),
          onChanged: (value) {
            //https://stackoverflow.com/questions/51791501/how-to-debounce-textfield-onchange-in-dart

            if (_debounce?.isActive ?? false) _debounce.cancel();
            _debounce = Timer(const Duration(milliseconds: 1500), () {
              BlocProvider.of<VenuesBloc>(context)
                  .add(GetVenuesEvent(queryParams: {'query': controller.text}));
            });
          },
          onEditingComplete: () {
            _debounce?.cancel();
            //https://flutterigniter.com/dismiss-keyboard-form-lose-focus/
            final FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

            BlocProvider.of<VenuesBloc>(context)
                .add(GetVenuesEvent(queryParams: {'query': controller.text}));
            controller.clear();
          },
        ),
      ),
    );
  }
}
