import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/constants/colors.dart';
import 'package:hichat/core/constants/styles.dart';
import 'package:hichat/ui/screens/bottom_navigation/chat_list/chat_room/chat_widgets.dart';
import 'package:hichat/ui/widgets/textfield_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
              child: Column(
                children: [
                  30.verticalSpace,
                  _buildHeader(context, name: "Jack"),
                  10.verticalSpace,
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) => ChatBubble(
                        isCurrentUser: false,
                      ),
                      separatorBuilder: (context, index) => 10.verticalSpace,
                      itemCount: 5,
                    ),
                  )
                ],
              ),
            ),
          ),
          BottomField(
            onChanged: (p0) {},
            onTap: () {},
          )
        ],
      ),
    );
  }

  Row _buildHeader(BuildContext context, {String name = ""}) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: gray.withOpacity(0.15)),
            child: Icon(Icons.arrow_back),
          ),
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
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, this.isCurrentUser = true});

  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    final alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    final borderRadius = isCurrentUser
        ? BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          );
    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        constraints: BoxConstraints(maxWidth: 1.sw * 0.8, minWidth: 50.w),
        decoration: BoxDecoration(
            color: isCurrentUser ? primary : gray.withOpacity(0.2),
            borderRadius: borderRadius),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              "vkahvowrvheouqr  h;boiqbv ",
              style:
                  TextStyle(color: isCurrentUser ? Colors.white : Colors.black),
            ),
            5.verticalSpace,
            Text(
              "08:00 AM",
              style: small.copyWith(color: isCurrentUser ? white : null),
            )
          ],
        ),
      ),
    );
  }
}
