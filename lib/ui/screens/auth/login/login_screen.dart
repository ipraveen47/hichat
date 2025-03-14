import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/constants/strings.dart';
import 'package:hichat/core/constants/styles.dart';
import 'package:hichat/core/enum/enum.dart';
import 'package:hichat/core/extension/widget_extension.dart';
import 'package:hichat/core/services/auth_services.dart';
import 'package:hichat/ui/screens/auth/login/login_viewmodel.dart';
import 'package:hichat/ui/widgets/button_widget.dart';
import 'package:hichat/ui/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewmodel(AuthServices()),
      child: Consumer<LoginViewmodel>(builder: (context, model, _) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80.h),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Login  ",
                      style: h,
                    ),
                    10.verticalSpace,
                    const Text("Please Login To Your Account "),
                    30.verticalSpace,
                    CustomTextField(
                        hintText: "Enter Email", onChanged: model.setEmail),
                    20.verticalSpace,
                    CustomTextField(
                      hintText: "Enter Password",
                      onChanged: model.setPassword,
                    ),
                    30.verticalSpace,
                    customButton(
                      loading: model.state == ViewState.loading,
                      text: "Login",
                      onPressed: model.state == ViewState.loading
                          ? null
                          : () async {
                              try {
                                await model.login();
                                context.showSnackbar(
                                    "User logged in Successfully! ");
                              } on FirebaseAuthException catch (e) {
                                context.showSnackbar(e.toString());
                              } catch (e) {
                                context.showSnackbar(e.toString());
                              }
                            },
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't Have an Account?"),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, signup);
                            },
                            child: const Text("SignUp",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
