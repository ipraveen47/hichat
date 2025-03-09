import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/constants/colors.dart';
import 'package:hichat/core/constants/strings.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onChanged,
    this.hintText,
    this.focusNode,
    this.isChatText = false,
    this.isSearch = false,
  });

  final void Function(String)? onChanged;
  final String? hintText;
  final FocusNode? focusNode;
  final bool isSearch;
  final bool isChatText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isChatText ? 35.h : null,
      child: TextField(
        onChanged: onChanged,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding:
              isChatText ? EdgeInsets.symmetric(horizontal: 12.w) : null,
          filled: true,
          suffixIcon: isSearch
              ? Container(
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(10.r)),
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.all(12),
                  child: Image.asset(searchIcon),
                )
              : null,
          fillColor: isChatText ? white : gray.withOpacity(0.12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isChatText ? 30.r : 15.r),
              borderSide: BorderSide.none),
          hintText: hintText,
        ),
      ),
    );
  }
}
