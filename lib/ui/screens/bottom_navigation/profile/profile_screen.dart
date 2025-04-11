import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/other/user_provider.dart';
import 'package:hichat/core/services/auth_services.dart';
import 'package:hichat/ui/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05),
      child: Column(
        children: [
          100.verticalSpace,
          CircleAvatar(
            radius: 40.r,
            child: Icon(
              Icons.person,
              size: 40.sp,
            ),
          ),
          20.verticalSpace,
          UserInfoTile(
            name: user.name ?? "No Name",
            email: user.email ?? "No Email",
          ),
          50.verticalSpace,
          customButton(
            text: "Logout",
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).clearUser();
              AuthServices().logout();
            },
          )
        ],
      ),
    ));
  }
}

class UserInfoTile extends StatelessWidget {
  final String name;
  final String email;

  const UserInfoTile({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        5.verticalSpace,
        Text(
          email,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      ],
    );
  }
}
