import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

const double size = 60.0;

/// loading widget for loadingStates
class LoadingBox extends StatelessWidget {
  const LoadingBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
          child: SizedBox(
        width: size,
        height: size,
        child: LoadingIndicator(
          indicatorType: Indicator.lineScaleParty,
          //TODO color
          color: Colors.indigo,
        ),
      ));
}
