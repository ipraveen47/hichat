import 'package:flutter/material.dart';
import 'package:hichat/core/enum/enum.dart';
import 'package:hichat/core/other/user_provider.dart';

import 'package:hichat/core/services/auth_services.dart';
import 'package:hichat/core/services/database_service.dart';
import 'package:hichat/ui/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(DatabaseService()),
      child: Consumer<HomeViewModel>(builder: (context, model, _) {
        return Scaffold(
          body: Center(
              child: userProvider.user == null
                  ? CircularProgressIndicator()
                  : InkWell(
                      onTap: () {
                        AuthServices().logout();
                      },
                      child: Text(userProvider.user.toString()))),
        );
      }),
    );
  }
}
