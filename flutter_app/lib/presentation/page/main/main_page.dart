import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'widget/balance_button_row.dart';
import 'widget/date_row.dart';
import 'widget/detail_row.dart';
import 'widget/graph_row.dart';
import 'widget/left_drawer.dart';
import 'widget/left_drawer_button.dart';
import 'widget/main_paginator.dart';
import 'widget/right_drawer.dart';

class MainPage extends StatefulWidget {
  static const String route = "MainPage";

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _pageController;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _pageController = PageController(initialPage: _currentMonth.month - 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int pageIndex) {
    print("######################3");
    print("changed page");
    print("######################3");
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, pageIndex + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldProvider = Provider.of<ScaffoldProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => LeftDrawerMenuState(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).app_title),
          leading: const LeftDrawerButton(),
        ),
        primary: true,
        endDrawer: const RightDrawer(),
        body: Builder(builder: (ctx) {
          scaffoldProvider.setScaffoldContext((ctx));
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: const [
                  Expanded(child: MainPaginator()),
                  BalanceButtonRow(),
                ],
              ),
              const LeftDrawer(),
            ],
          );
        }),
      ),
    );
  }
}
