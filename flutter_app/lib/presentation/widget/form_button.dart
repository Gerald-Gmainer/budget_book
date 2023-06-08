import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  const FormButton({required this.text, this.isLoading = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        elevation: 3,
      ),
      child: isLoading ? _buildLoginLoading() : Text(text),
    );
  }

  Widget _buildLoginLoading() {
    return const Center(
      child: SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(strokeWidth: 3),
      ),
    );
  }
}
