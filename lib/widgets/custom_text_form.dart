import 'package:flutter/material.dart';

import '../theme_manager/color_manager.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required TextEditingController searchController,
    Widget? suffixIcon,
    String? hint,
  })  : _searchController = searchController,
        _suffixIcon = suffixIcon,
        _hint = hint;

  final TextEditingController _searchController;
  final Widget? _suffixIcon;
  final String? _hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      decoration: InputDecoration(
        suffixIcon: _suffixIcon,
        hintText: _hint,
        hintStyle: TextStyle(color: ColorManager.grey),
        fillColor: ColorManager.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
