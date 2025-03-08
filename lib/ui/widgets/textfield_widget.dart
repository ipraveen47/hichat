import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customTextField extends StatelessWidget {
  const customTextField({
    super.key,
    this.onChanged,
    this.hintText,
    this.focusNode,
  });

  final void Function(String)? onChanged;
  final String? hintText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.2),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none),
        hintText: hintText,
      ),
    );
  }
}
