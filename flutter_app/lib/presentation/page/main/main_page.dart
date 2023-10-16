import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/page/main/widget/create_booking_button.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'graph_view.dart';
import 'widget/left_drawer.dart';
import 'widget/left_drawer_button.dart';
import 'widget/refresh_button.dart';
import 'widget/right_drawer.dart';
import 'widget/right_drawer_button.dart';
import 'widget/transfer_button.dart';

class MainPage extends StatefulWidget {
  static const String route = "MainPage";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GraphViewBloc>(context).add(InitGraphViewEvent());
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldProvider = Provider.of<ScaffoldProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => LeftDrawerMenuState(),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Budget Book", style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.kaushanScript().fontFamily)),
              Text("All Accounts", style: TextStyle(fontSize: 13, color: AppColors.thirdTextColor)),
            ],
          ),
          leading: LeftDrawerButton(),
          actions: [RefreshButton(), RightDrawerButton()],
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
                    Expanded(child: GraphView()),
                    // BalanceButtonRow(),
                  ],
                ),
              ),
              LeftDrawer(),
            ],
          );
        }),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TransferButton(),
            SizedBox(width: AppDimensions.horizontalPadding),
            CreateBookingButton(),
          ],
        ),
      ),
    );
  }
}
