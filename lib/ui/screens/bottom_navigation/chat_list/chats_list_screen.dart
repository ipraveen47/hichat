import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/constants/colors.dart';
import 'package:hichat/core/constants/strings.dart';
import 'package:hichat/core/constants/styles.dart';
import 'package:hichat/core/models/user_model.dart';
import 'package:hichat/core/other/user_provider.dart';
import 'package:hichat/core/services/database_service.dart';
import 'package:hichat/ui/screens/bottom_navigation/chat_list/chat_list_viewModel.dart';
import 'package:hichat/ui/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return ChangeNotifierProvider(
      create: (context) => ChatListViewmodel(DatabaseService(), currentUser!),
      child: Consumer<ChatListViewmodel>(builder: (context, model, _) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
          child: Column(
            children: [
              30.verticalSpace,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Chats",
                  style: h,
                ),
              ),
              20.verticalSpace,
              const CustomTextField(
                isSearch: true,
                hintText: "Search here...",
              ),
              10.verticalSpace,
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  itemCount: model.users.length,
                  separatorBuilder: (context, index) => 5.verticalSpace,
                  itemBuilder: (context, index) {
                    final user = model.users[index];
                    return ChatTile(
                      user: user,
                      onTap: () => Navigator.pushNamed(context, chatRoom),
                    );
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, this.onTap, required this.user});
  final void Function()? onTap;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: gray.withOpacity(0.18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        radius: 35,
        backgroundColor: gray,
        child: Text(user.name![0]),
      ),
      title: Text(user.name!),
      subtitle: Text(
        "this is subtitle and i'm checking the overflow  ",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("15 min ago"),
          10.verticalSpace,
          CircleAvatar(
            radius: 10.r,
            backgroundColor: primary,
            child: Text(
              "1",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
