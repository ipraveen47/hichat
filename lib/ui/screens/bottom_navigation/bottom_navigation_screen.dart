import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/constants/strings.dart';
import 'package:hichat/ui/screens/bottom_navigation/chat_list/chats_list_screen.dart';

List<Widget> screens = [
  const ChatsListScreen(),
  const ChatsListScreen(),
  const ChatsListScreen(),
];

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), topLeft: Radius.circular(35)),
          boxShadow: [
            BoxShadow(color: Colors.black, spreadRadius: 0, blurRadius: 10),
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                label: "",
                icon: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Image.asset(
                    homeIcon,
                    color: Colors.black,
                    height: 50,
                    width: 50,
                  ),
                )),
            BottomNavigationBarItem(
                label: "",
                icon: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Image.asset(
                    chatsIcon,
                    height: 30,
                    width: 30,
                  ),
                )),
            BottomNavigationBarItem(
                label: "",
                icon: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Image.asset(
                    profileIcon,
                    height: 50,
                    width: 50,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
