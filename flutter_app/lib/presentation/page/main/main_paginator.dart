import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widget/date_row.dart';
import 'widget/detail_row.dart';
import 'widget/graph_row.dart';

class MainPaginator extends StatefulWidget {
  @override
  State<MainPaginator> createState() => _MainPaginatorState();
}

class _MainPaginatorState extends State<MainPaginator> {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPaginatorBloc, MainPaginatorState>(
      builder: (context, state) {
        // TODO build error text with reload button
        if (state is MainPaginatorLoadedState) {
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateRow(periodModel: bookModel.periodModels[index]),
            GraphRow(),
            DetailRow(periodModel: bookModel.periodModels[index], categories: bookModel.categories),
          ],
        );
      },
    );
  }
}
