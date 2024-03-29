import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshButton extends StatelessWidget {
  _refresh(BuildContext context) {
    BlocProvider.of<GraphViewBloc>(context).add(RefreshGraphViewEvent());
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: () {
        _refresh(context);
      },
    );
  }
}
