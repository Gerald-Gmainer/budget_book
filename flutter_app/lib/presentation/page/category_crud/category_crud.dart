import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';

class CategoryCrudPage extends StatefulWidget {
  static const String route = "CategoryCrudPage";
  final CategoryModel model;

  const CategoryCrudPage({required this.model});

  @override
  State<CategoryCrudPage> createState() => _CategoryCrudPageState();
}

class _CategoryCrudPageState extends State<CategoryCrudPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreating() ? "New" : "Edit"),
      ),
      body: Center(child: Text("category crud")),
    );
  }

  bool _isCreating() {
    return widget.model.dataModel.id == null;
  }
}
