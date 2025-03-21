import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/other/user_provider.dart';
import 'package:hichat/core/services/database_service.dart';
import 'package:hichat/firebase_options.dart';
import 'package:hichat/ui/screens/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'core/utils/route_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const hichat());
}

class hichat extends StatelessWidget {
  const hichat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) => ChangeNotifierProvider(
              create: (context) => UserProvider(DatabaseService()),
              child: const MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: RouteUtils.onGenerateRoute,
                home: SplashScreen(),
              ),
            ));
  }
}
