import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DescriptionInput extends StatelessWidget {
  final BookingModel model;
  final TextEditingController controller;

  DescriptionInput({required this.model}) : controller = TextEditingController(text: model.description);

  _onChanged(String value) {
    model.description = value;
  }

  _onSelect(String value) {
    // controller.text = value;
    model.description = value;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestionBloc, SuggestionState>(
      builder: (context, state) {
        if (state is SuggestionLoadedState) {
          return _buildInput(state.suggestions);
        }
        return _buildInput([]);
      },
    );
  }

  Widget _buildInput(List<String> suggestions) {
    return TypeAheadFormField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        onChanged: _onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.edit),
          labelText: 'Note',
        ),
      ),
      suggestionsCallback: (pattern) async {
        return suggestions.where((suggestion) => suggestion.toLowerCase().contains(pattern.toLowerCase()));
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (String suggestion) {
        _onSelect(suggestion);
      },
    );
  }
}
