import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/page/main/widget/balance_text.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/app_dimensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widget/booking_overview.dart';
import 'widget/date_panel.dart';
import 'widget/graph_panel.dart';

class GraphView extends StatefulWidget {
  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _reload() {
    BlocProvider.of<GraphViewBloc>(context).add(RefreshGraphViewEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphViewBloc, GraphViewState>(
      builder: (context, state) {
        if (state is GraphViewErrorState) {
          return ErrorText(message: state.message, onReload: _reload);
        }
        if (state is GraphViewLoadedState) {
          return _buildView(state.bookModel);
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  void _onPageChanged(int pageIndex) {
    setState(() {
      _currentIndex = pageIndex;
    });
  }

  Widget _buildView(BudgetBookModel bookModel) {
    return PageView.builder(
      controller: _pageController,
      itemCount: bookModel.periodModels.length,
      onPageChanged: _onPageChanged,
      reverse: true,
      itemBuilder: (context, index) {
        return ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DatePanel(periodModel: bookModel.periodModels[index]),
                SizedBox(width: AppDimensions.horizontalPadding),
                BalanceText(periodModel: bookModel.periodModels[index]),
              ],
            ),
            GraphPanel(periodModel: bookModel.periodModels[index]),
            BookingOverview(periodModel: bookModel.periodModels[index], categories: bookModel.categories),
            SizedBox(height: AppDimensions.verticalPadding),
          ],
        );
      },
    );
  }
}
