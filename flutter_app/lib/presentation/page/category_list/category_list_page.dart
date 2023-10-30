import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/category_type.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/app_dimensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListPage extends StatefulWidget {
  static const String route = "CategoryListPage";

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() {
    BlocProvider.of<CategoryListBloc>(context).add(LoadCategoryListEvent());
  }

  _onCategoryTap(CategoryModel category) {
    Navigator.of(context).pushNamed(CategoryCrudPage.route, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: BlocConsumer<CategoryListBloc, CategoryListState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is CategoryLoadedState) {
            return _buildView(state.categories);
          } else if (state is CategoryErrorState) {
            return ErrorText(message: state.message, onReload: _load);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildView(List<CategoryModel> categories) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: CategoryType.outcome.name),
              Tab(text: CategoryType.income.name),
            ],
          ),
          SizedBox(height: AppDimensions.verticalPadding * 2),
          Expanded(
            child: TabBarView(
              children: [
                _buildList(categories, CategoryType.outcome),
                _buildList(categories, CategoryType.income),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<CategoryModel> categories, CategoryType type) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.verticalPadding * 2),
      child: Column(
        children: [
          Center(
            child: CategoryList(
              categories: categories,
              categoryType: type,
              onCategoryTap: _onCategoryTap,
            ),
          ),
        ],
      ),
    );
  }
}
