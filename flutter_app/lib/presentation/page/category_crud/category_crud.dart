import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/category_color_list.dart';
import 'widget/category_icon_list.dart';
import 'widget/category_name_input.dart';
import 'widget/category_type_row.dart';

class CategoryCrudPage extends StatefulWidget {
  static const String route = "CategoryCrudPage";
  final CategoryModel model;

  const CategoryCrudPage({required this.model});

  @override
  State<CategoryCrudPage> createState() => _CategoryCrudPageState();
}

class _CategoryCrudPageState extends State<CategoryCrudPage> {
  final TextEditingController _nameController = TextEditingController();
  late CategoryType _selectedType;
  IconDataModel? _selectedIcon;
  IconColorModel? _selectedColor;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryCrudBloc>(context).add(InitCategoryCrudEvent());
    _selectedType = widget.model.categoryType;
    _load();
  }

  _load() {
    BlocProvider.of<CategoryIconBloc>(context).add(LoadCategoryIconEvent());
  }

  _onTypeChange(CategoryType type) {
    _hideKeyboard();
    setState(() {
      _selectedType = type;
    });
  }

  _onIconChange(IconDataModel icon) {
    _hideKeyboard();
    setState(() {
      _selectedIcon = icon;
    });
  }

  _onColorChange(IconColorModel color) {
    _hideKeyboard();
    setState(() {
      _selectedColor = color;
    });
  }

  _hideKeyboard () {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  _upload() {
    final model = CategoryModel(
      id: widget.model.id,
      name: _nameController.text,
      iconData: _selectedIcon,
      iconColor: _selectedColor,
      categoryType: _selectedType,
    );
    BlocProvider.of<CategoryCrudBloc>(context).add(UploadCategoryCrudEvent(model));
  }

  _onUploadSuccess() {
    showSnackBar(context, "success");
    BlocProvider.of<CategoryListBloc>(context).add(LoadCategoryListEvent(forceReload: true));
    Navigator.of(context).pop();
  }

  _onUploadError(String message) {
    showErrorSnackBar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreating() ? "New Category" : "Edit Category"),
      ),
      body: BlocListener<CategoryCrudBloc, CategoryCrudState>(
        listener: (context, state) {
          if (state is CategoryCrudFinishedState) {
            _onUploadSuccess();
          } else if (state is CategoryCrudErrorState) {
            _onUploadError(state.message);
          }
        },
        child: BlocBuilder<CategoryIconBloc, CategoryIconState>(
          builder: (context, state) {
            if (state is CategoryIconErrorState) {
              return ErrorText(message: state.message, onReload: _load);
            }
            if (state is CategoryIconLoadedState) {
              return _buildView(state.categoryIcons, state.categoryColors);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildView(List<IconDataModel> categoryIcons, List<IconColorModel> categoryColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.verticalPadding, horizontal: AppDimensions.horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CategoryNameInput(controller: _nameController),
            const SizedBox(height: AppDimensions.verticalPadding * 2),
            CategoryTypeRow(onTypeChange: _onTypeChange, selectedType: _selectedType),
            const SizedBox(height: AppDimensions.verticalPadding),
            CategoryIconList(
              categoryIcons: categoryIcons,
              onTap: _onIconChange,
              selectedIcon: _selectedIcon,
              selectedColor: _selectedColor,
            ),
            const SizedBox(height: AppDimensions.verticalPadding),
            CategoryColorList(
              categoryColors: categoryColors,
              onTap: _onColorChange,
              selectedColor: _selectedColor,
            ),
            const SizedBox(height: AppDimensions.verticalPadding),
            _buildSaveButton(),
            const SizedBox(height: AppDimensions.verticalPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return BlocBuilder<CategoryCrudBloc, CategoryCrudState>(
      builder: (context, state) {
        final isLoading = state is CategoryCrudLoadingState;
        return SaveButton(
          text: _isCreating() ? "Add" : "Edit",
          onTap: _upload,
          isLoading: isLoading,
        );
      },
    );
  }

  bool _isCreating() {
    return widget.model.id == null;
  }
}
