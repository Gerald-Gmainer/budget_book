import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key});

  _refresh(BuildContext context) {
    BlocProvider.of<MainPaginatorBloc>(context).add(RefreshMainPaginatorEvent());
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
