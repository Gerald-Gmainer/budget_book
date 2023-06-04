import 'package:flutter/material.dart';
import 'date_row.dart';
import 'detail_row.dart';
import 'graph_row.dart';

class MainPaginator extends StatefulWidget {
  const MainPaginator({super.key});

  @override
  State<MainPaginator> createState() => _MainPaginatorState();
}

class _MainPaginatorState extends State<MainPaginator> {
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
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, pageIndex + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: 12,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) {
        final month = DateTime(_currentMonth.year, index + 1);
        return Column(
          children: [
            DateRow(currentMonth: month),
            const GraphRow(),
            const DetailRow(),
          ],
        );
      },
    );
  }
}
