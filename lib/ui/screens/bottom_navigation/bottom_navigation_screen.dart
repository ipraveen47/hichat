import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/constants/strings.dart';
import 'package:hichat/ui/screens/bottom_navigation/bottom_navigation_viewModel.dart';
import 'package:hichat/ui/screens/bottom_navigation/chat_list/chats_list_screen.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  static final List<Widget> _screens = [
    Center(child: const Text("Chat Screen")),
    const ChatsListScreen(),
    Center(child: const Text("Profile Screen")),
  ];

  @override
  Widget build(BuildContext context) {
    const items = [
      BottomNavigationBarItem(
          label: "", icon: BottomNavButton(iconPath: homeIcon)),
      BottomNavigationBarItem(
          label: "", icon: BottomNavButton(iconPath: chatsIcon)),
      BottomNavigationBarItem(
          label: "", icon: BottomNavButton(iconPath: profileIcon)),
    ];
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationViewModel(),
      child: Consumer<BottomNavigationViewModel>(builder: (context, model, _) {
        return Scaffold(
            body: BottomNavigationScreen._screens[model.currentIndex],
            bottomNavigationBar:
                CustomNavbar(onTap: model.setIndex, items: items));
      }),
    );
  }
}

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key, this.onTap, required this.items});

  final void Function(int)? onTap;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    final borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(35),
      topRight: Radius.circular(35),
    );
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), topLeft: Radius.circular(35)),
          boxShadow: [
            BoxShadow(color: Colors.black, spreadRadius: 0, blurRadius: 10),
          ]),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BottomNavigationBar(
          onTap: onTap,
          items: items,
        ),
      ),
    );
  }
}

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    super.key,
    required this.iconPath,
  });

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Image.asset(
        iconPath,
        color: Colors.black,
        height: 50,
        width: 50,
      ),
    );
  }
}
