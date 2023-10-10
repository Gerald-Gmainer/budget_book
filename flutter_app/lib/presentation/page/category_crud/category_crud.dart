import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class CategoryCrudPage extends StatefulWidget {
  static const String route = "CategoryCrudPage";
  final CategoryModel model;

  const CategoryCrudPage({required this.model});

  @override
  State<CategoryCrudPage> createState() => _CategoryCrudPageState();
}

class _CategoryCrudPageState extends State<CategoryCrudPage> {
  final TextEditingController _nameController = TextEditingController();
  CategoryType _selectedType = CategoryType.outcome;
  CategoryIconDataModel? _selectedIcon;
  CategoryColorDataModel? _selectedColor;

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() {
    BlocProvider.of<CategoryIconBloc>(context).add(LoadCategoryIconEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreating() ? "New Category" : "Edit Category"),
      ),
      body: BlocBuilder<CategoryIconBloc, CategoryIconState>(
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
    );
  }

  Widget _buildView(List<CategoryIconDataModel> categoryIcons, List<CategoryColorDataModel> categoryColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.verticalPadding, horizontal: AppDimensions.horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildName(),
            const SizedBox(height: AppDimensions.verticalPadding * 2),
            _buildType(),
            const SizedBox(height: AppDimensions.verticalPadding),
            _buildIcons(categoryIcons),
            const SizedBox(height: AppDimensions.verticalPadding),
            _buildColors(categoryColors),
            const SizedBox(height: AppDimensions.verticalPadding),
            _buildSaveButton(),
            const SizedBox(height: AppDimensions.verticalPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildName() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Category Name',
      ),
      validator: (value) {
        if (value?.isNotEmpty == false) {
          return 'Please enter a name';
        }
        return null;
      },
    );
  }

  Widget _buildType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Category Type', style: TextStyle(fontSize: 16)),
        Row(
          children: <Widget>[
            IntrinsicWidth(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                title: const Text('Outcome'),
                leading: Radio(
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: CategoryType.outcome,
                  groupValue: _selectedType,
                  onChanged: (CategoryType? value) {
                    setState(() {
                      if (value != null) {
                        _selectedType = value!;
                      }
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.horizontalPadding),
            IntrinsicWidth(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Income'),
                minLeadingWidth: 0,
                leading: Radio(
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: CategoryType.income,
                  groupValue: _selectedType,
                  onChanged: (CategoryType? value) {
                    setState(() {
                      if (value != null) {
                        _selectedType = value!;
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIcons(List<CategoryIconDataModel> categoryIcons) {
    const rowsCount = 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Select an Icon', style: TextStyle(fontSize: 16)),
        Container(
          height: 250,
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.verticalPadding),
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Horizontal scroll
            itemCount: ((categoryIcons.length) / rowsCount).ceil(),
            itemBuilder: (BuildContext context, int rowIndex) {
              final startIndex = rowIndex * rowsCount;
              final endIndex = math.min(startIndex + rowsCount, (categoryIcons.length));
              final iconsForRow = categoryIcons.sublist(startIndex, endIndex);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: iconsForRow.map((icon) {
                  return _buildIcon(icon);
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(CategoryIconDataModel icon) {
    Color color = AppColors.secondaryColor;
    bool showBorder = false;
    if (_selectedIcon == icon && _selectedColor != null) {
      color = ColorConverter.stringToColor(_selectedColor!.code);
      showBorder = true;
    }
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIcon = icon;
        });
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          // color: Colors.red,
          borderRadius: BorderRadius.circular(12),
          border: showBorder
              ? Border.all(
                  color: AppColors.primaryTextColor, // Border color
                  width: 1, // Border width
                )
              : null,
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            IconConverter.getIconData(icon.name),
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildColors(List<CategoryColorDataModel> categoryColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Select a Color',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 60, // Adjust the height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryColors.length,
            itemBuilder: (BuildContext context, int index) {
              final color = categoryColors[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildColor(color),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildColor(CategoryColorDataModel color) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            backgroundColor: ColorConverter.stringToColor(color.code),
            radius: 20,
          ),
          if (_selectedColor == color)
            Positioned.fill(
              child: Center(
                child: Text(
                  String.fromCharCode(Icons.check.codePoint),
                  style: TextStyle(
                    inherit: false,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: Icons.space_dashboard_outlined.fontFamily,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
        ),
        child: const Text("Add", style: TextStyle(fontSize: 16)),
      ),
    );
  }

  bool _isCreating() {
    return widget.model.id == null;
  }
}
