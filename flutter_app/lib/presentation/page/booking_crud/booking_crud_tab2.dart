import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/account_select_input.dart';
import 'widget/category_list_input.dart';
import 'widget/description_input.dart';

class BookingCrudTab2 extends StatelessWidget {
  final BookingModel model;
  final VoidCallback onUpload;

  const BookingCrudTab2({required this.model, required this.onUpload});

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
        _buildOverview(context),
        const SizedBox(height: AppDimensions.verticalPadding),
        DescriptionInput(model: model),
        const SizedBox(height: AppDimensions.verticalPadding),
        Expanded(child: CategoryListInput(categories: categories, model: model)),
        const SizedBox(height: AppDimensions.verticalPadding * 2),
        SaveButton(text: "save", onTap: onUpload),
        const SizedBox(height: AppDimensions.verticalPadding),
      ],
    );
  }

  _buildOverview(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return AnimatedSize(
      duration: Duration(milliseconds: 100),
      child: SizedBox(
        height: keyboardIsOpen ? 0.0 : null,
        child: SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                right: AppDimensions.horizontalPadding,
                top: AppDimensions.verticalPadding,
                bottom: AppDimensions.verticalPadding,
                left: AppDimensions.horizontalPadding / 2,
              ),
              child: Row(
                children: [
                  AccountSelectInput(model: model),
                  Expanded(
                    child: Column(
                      children: [
                        _buildDate(),
                        const SizedBox(height: AppDimensions.verticalPadding),
                        _buildAmount(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildDate() {
    return Text(
      DateTimeConverter.toEEEEdMMMM(model.bookingDate),
      style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
    );
  }

  _buildAmount() {
    return CurrencyText(value: model.amount, style: const TextStyle(fontSize: 38, color: AppColors.primaryTextColor));
  }
}
