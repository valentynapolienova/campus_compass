
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:int20h/core/helper/notification.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/util/input_converter.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/app_bars/base_app_bar.dart';
import 'package:int20h/core/widgets/buttons/base_button.dart';
import 'package:int20h/injection_container.dart';

import 'cubit/auth_cubit/auth_cubit.dart';
import 'cubit/sign_in_cubit/sign_in_cubit.dart';
import 'cubit/sign_up_cubit/sign_up_cubit.dart';


class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key, required this.authCubit}) : super(key: key);

  final AuthCubit authCubit;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  SignUpCubit cubit = sl();

  String name = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) async {
        if (state is SignUpSuccess) {
          widget.authCubit.saveUserSession(state.token).then((value) {
            sl<SignInCubit>().setFirebaseToken(FCM.fbToken);
            Navigator.pop(context);
          });
        }
      },
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: const BaseAppBar(
            isBackButton: true,
          ),
          backgroundColor: CColors.black,
          body: KeyboardDismissOnTap(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.pw),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.ph,
                      ),
                      SizedBox(
                        height: 30.ph,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your name',
                        ),
                        onChanged: (s) {
                          setState(() {
                            name = s;
                          });
                        },
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 12.ph,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                        ),
                        onChanged: (s) {
                          setState(() {
                            email = s;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 12.ph,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your password',
                        ),
                        onChanged: (s) {
                          setState(() {
                            password = s;
                          });
                        },
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 30.ph,
                      ),
                      state is SignUpFailure
                          ? Container(
                              width: double.infinity,
                              margin:
                                  EdgeInsets.only(bottom: 10.ph, left: 6.pw),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email is incorrect',
                                 /* style: montserrat.w500.s13
                                      .copyWith(color: Colors.red.shade400),*/
                                ),
                              ),
                            )
                          : const SizedBox(),
                      _button(state),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _button(SignUpState state) => BaseButton(
        label: "Continue",
        onTap: () {
          if (InputChecker.checkEmail(email)) {
            cubit.signUp(name, email, password);
          } else {
            cubit.setEmailValidationError();
          }
        },
        isActive: name.isNotEmpty && email.isNotEmpty && password.length > 5,
        isLoading: state is SignUpLoading,
        padding: EdgeInsets.symmetric(horizontal: 16.pw, vertical: 14.ph),
      );
}
