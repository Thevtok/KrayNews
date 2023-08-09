import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onTextChanged;
  final VoidCallback onSearchPressed;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onTextChanged,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: onTextChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Cari sesuatu',
          filled: true,
          fillColor: const Color.fromARGB(255, 241, 244, 251),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          suffixIcon: IconButton(
            onPressed: onSearchPressed,
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 134, 132, 132),
            ),
          ),
        ),
      ),
    );
  }
}
