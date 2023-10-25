import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/category_list.dart';
import 'widget/crud_overview.dart';
import 'widget/description_input.dart';

class BookingCrudTab2 extends StatelessWidget {
  final BookingModel model;
  final VoidCallback onUpload;

  const BookingCrudTab2({required this.model, required this.onUpload});

  _onCategoryTap(CategoryModel category) {}

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
          return _buildView(context, state.categories);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildView(BuildContext context, List<CategoryModel> categories) {
    return Column(
      children: [
        CrudOverview(model: model),
        const SizedBox(height: AppDimensions.verticalPadding),
        DescriptionInput(model: model),
        const SizedBox(height: AppDimensions.verticalPadding),
        Expanded(child: CategoryList(categories: categories, model: model)),
        const SizedBox(height: AppDimensions.verticalPadding * 2),
        SaveButton(text: "save", onTap: onUpload),
        const SizedBox(height: AppDimensions.verticalPadding),
      ],
    );
  }
}
