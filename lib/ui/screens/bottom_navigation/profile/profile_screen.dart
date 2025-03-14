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
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05),
      child: Column(
        children: [
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
