import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/constants/colors.dart';

class customButton extends StatelessWidget {
  const customButton({
    this.onPressed,
    required this.text,
    this.loading = false,
    super.key,
  });
  final void Function()? onPressed;
  final String text;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 40.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: primary),
        onPressed: onPressed,
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
