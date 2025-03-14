import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/constants/colors.dart';
import 'package:hichat/core/constants/styles.dart';
import 'package:hichat/core/extension/widget_extension.dart';
import 'package:hichat/core/models/message_model.dart';
import 'package:hichat/core/models/user_model.dart';
import 'package:hichat/core/other/user_provider.dart';
import 'package:hichat/core/services/chat_service.dart';
import 'package:hichat/ui/screens/bottom_navigation/chat_list/chat_room/chat_viewmodel.dart';
import 'package:hichat/ui/screens/bottom_navigation/chat_list/chat_room/chat_widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.receiver});
  final UserModel receiver;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return ChangeNotifierProvider(
      create: (context) => ChatViewmodel(ChatService(), currentUser!, receiver),
      child: Consumer<ChatViewmodel>(builder: (context, model, _) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.sw * 0.05, vertical: 10.h),
                  child: Column(
                    children: [
                      35.verticalSpace,
                      _buildHeader(context, name: receiver.name!),
                      15.verticalSpace,
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(0),
                          itemCount: model.messages.length,
                          separatorBuilder: (context, index) =>
                              10.verticalSpace,
                          itemBuilder: (context, index) {
                            final message = model.messages[index];
                            return ChatBubble(
                              isCurrentUser:
                                  message.senderId == currentUser!.uid,
                              message: message,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BottomField(
                controller: model.controller,
                onTap: () async {
                  try {
                    await model.saveMessage();
                  } catch (e) {
                    context.showSnackbar(e.toString());
                  }
                },
              )
            ],
          ),
        );
      }),
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
  const ChatBubble(
      {super.key, this.isCurrentUser = true, required this.message});
  final bool isCurrentUser;
  final Message message;

  @override
  Widget build(BuildContext context) {
    final borderRadius = isCurrentUser
        ? BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r))
        : BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r));
    final alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: 1.sw * 0.75, minWidth: 50.w),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isCurrentUser ? primary : Colors.grey.withOpacity(0.2),
            borderRadius: borderRadius),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              message.content!,
              style: body.copyWith(color: isCurrentUser ? white : null),
            ),
            5.verticalSpace,
            Text(
              DateFormat('hh:mm a').format(message.timestamp!),
              style: small.copyWith(color: isCurrentUser ? white : null),
            )
          ],
        ),
      ),
    );
  }
}
