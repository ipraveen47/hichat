import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hichat/core/constants/strings.dart';
import 'package:hichat/core/constants/styles.dart';
import 'package:hichat/core/enum/enum.dart';
import 'package:hichat/core/extension/widget_extension.dart';
import 'package:hichat/core/services/auth_services.dart';
import 'package:hichat/core/services/database_service.dart';
import 'package:hichat/core/services/storage_service.dart';
import 'package:hichat/ui/screens/auth/signup/signp_viewmodel.dart';
import 'package:hichat/ui/widgets/button_widget.dart';
import 'package:hichat/ui/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignpViewmodel>(
      create: (context) =>
          SignpViewmodel(AuthServices(), DatabaseService(), StorageService()),
      child: Consumer<SignpViewmodel>(builder: (context, model, _) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80.h),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Create Your Account ",
                      style: h,
                    ),
                    const Text("Please Enter Your Details"),
                    20.verticalSpace,
                    InkWell(
                      onTap: () {
                        model.pickImage();
                      },
                      child: model.image == null
                          ? CircleAvatar(
                              radius: 40.r,
                              child: Icon(Icons.camera_alt),
                            )
                          : CircleAvatar(
                              radius: 40.r,
                              backgroundImage: FileImage(model.image!),
                            ),
                    ),
                    20.verticalSpace,
                    CustomTextField(
                      hintText: "Full Name",
                      onChanged: model.setName,
                    ),
                    20.verticalSpace,
                    CustomTextField(
                      hintText: "Enter Email",
                      onChanged: model.setEmail,
                    ),
                    20.verticalSpace,
                    CustomTextField(
                      hintText: "Enter Password",
                      onChanged: model.setPassword,
                      isPassword: true,
                    ),
                    20.verticalSpace,
                    CustomTextField(
                      hintText: "Confirm Password",
                      isPassword: true,
                      onChanged: model.setConfirmPassword,
                    ),
                    30.verticalSpace,
                    customButton(
                      loading: model.state == ViewState.loading,
                      text: "Sign Up",
                      onPressed: model.state == ViewState.loading
                          ? null
                          : () async {
                              try {
                                await model.signup();
                                context.showSnackbar(
                                    "User Created Successfully!!!");
                                Navigator.pop(context);
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
                        const Text("Already have an account?"),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, login);
                            },
                            child: const Text("Login",
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
