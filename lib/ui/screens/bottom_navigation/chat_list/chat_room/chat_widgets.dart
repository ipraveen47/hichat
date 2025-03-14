import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/constants/colors.dart';
import 'package:hichat/core/constants/styles.dart';
import 'package:hichat/ui/widgets/textfield_widget.dart';

class BottomField extends StatelessWidget {
  const BottomField({
    super.key,
    this.onTap,
    this.onChanged,
    this.controller,
  });

  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gray.withOpacity(0.2),
      padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 20.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: null,
            child: CircleAvatar(
              radius: 20.r,
              child: Icon(Icons.add),
              backgroundColor: Colors.white,
            ),
          ),
          10.horizontalSpace,
          Expanded(
              child: CustomTextField(
            controller: controller,
            isChatText: true,
            onChanged: onChanged,
            hintText: "Type Your Message...",
            onTap: onTap,
          ))
        ],
      ),
    );
  }
}

Row _buildHeader({String name = ""}) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: gray.withOpacity(0.15)),
        child: Icon(Icons.arrow_back),
      ),
      20.horizontalSpace,
      Text(name,
          style: h.copyWith(
            fontSize: 20.sp,
          )),
      const Spacer(),
      Container(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: gray.withOpacity(0.15)),
        child: Icon(Icons.more_vert),
      ),
    ],
  );
}
