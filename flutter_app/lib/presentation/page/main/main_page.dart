import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'widget/balance_button_row.dart';
import 'widget/left_drawer.dart';
import 'widget/left_drawer_button.dart';
import 'main_paginator.dart';
import 'widget/refresh_button.dart';
import 'widget/right_drawer.dart';

class MainPage extends StatefulWidget {
  static const String route = "MainPage";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainPaginatorBloc>(context).add(InitMainPaginatorEvent());
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldProvider = Provider.of<ScaffoldProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => LeftDrawerMenuState(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).app_title),
          leading: LeftDrawerButton(),
          actions: [RefreshButton()],
        ),
        primary: true,
        endDrawer: RightDrawer(),
        body: Builder(builder: (ctx) {
          scaffoldProvider.setScaffoldContext((ctx));
          return Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppDimensions.verticalPadding, horizontal: AppDimensions.horizontalPadding),
                child: Column(
                  children: [
                    Expanded(child: MainPaginator()),
                    BalanceButtonRow(),
                  ],
                ),
              ),
              LeftDrawer(),
            ],
          );
        }),
      ),
    );
  }
}
