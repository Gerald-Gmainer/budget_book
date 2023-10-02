import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/category_list.dart';

class BookingCrudTab2 extends StatelessWidget {
  final BookingCrudModel crudModel;
  final VoidCallback onUpload;

  const BookingCrudTab2({required this.crudModel, required this.onUpload});

  _reload(BuildContext context) {
    BlocProvider.of<CategoryListBloc>(context).add(LoadCategoryListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryListBloc, CategoryListState>(
      builder: (context, state) {
        if (state is CategoryErrorState) {
          return ErrorText(
            message: state.message,
            onReload: () {
              _reload(context);
            },
          );
        }
        if (state is CategoryLoadedState) {
          return _buildView(state.categories);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildView(List<CategoryModel> categories) {
    return Column(
      children: [
        Text("omg"),
        Expanded(child: CategoryList(model: crudModel, onCategoryTap: onUpload, categories: categories)),
      ],
    );
    // return CategoryList(model: crudModel, onCategoryTap: onUpload, categories: categories);
  }
}
