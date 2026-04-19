import 'package:flutter/material.dart';


class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
  });

  OutlineInputBorder get _border => OutlineInputBorder(
      borderSide: BorderSide(
          style: BorderStyle.none
      ),
      borderRadius: BorderRadius.circular(12)
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          enabledBorder: _border,
          focusedBorder: _border,
          errorBorder: _border
      ),
    );
  }
}