import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:int20h/core/helper/images.dart';
import 'package:int20h/core/helper/notification.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/input_converter.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/buttons/base_button.dart';
import 'package:int20h/features/sign_up/presentation/components/auth_text_field.dart';
import 'package:int20h/features/sign_up/presentation/registration_screen.dart';
import 'package:int20h/injection_container.dart';

import 'cubit/auth_cubit/auth_cubit.dart';
import 'cubit/sign_in_cubit/sign_in_cubit.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, required this.authCubit}) : super(key: key);

  final AuthCubit authCubit;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SignInCubit cubit = sl();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      bloc: cubit,
      listener: (context, state) async {
        if (state is SignInSuccess) {
          widget.authCubit
              .saveUserSession(state.token)
              .then((value) => cubit.setFirebaseToken(FCM.fbToken));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CColors.white,
          body: KeyboardDismissOnTap(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.pw),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.ph,
                      ),
                      Image.asset(
                        PngIcons.compass,
                        //color: CColors.green,
                        height: 100.ph,
                      ),
                      SizedBox(
                        height: 30.ph,
                      ),
                      Column(
                        children: [
                          Text(
                            'Welcome to CampusCompass!',
                            style: gilroy.black.w700.s24,
                          ),
                          SizedBox(
                            height: 16.ph,
                          ),
                          Text(
                            'Sign in your account to explore',
                            style: gilroy.black.w500.s18,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.ph,
                      ),
                      AuthTextField(
                         hintText: 'Enter your email',
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
                      AuthTextField(
                          hintText: 'Enter your password',

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
                      state is SignInFailure
                          ? Container(
                              width: double.infinity,
                              margin:
                                  EdgeInsets.only(bottom: 10.ph, left: 6.pw),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  state.message,
                                  style: gilroy.w500.s13
                                      .wrong,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      _button(state),
                      SizedBox(
                        height: 30.ph,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: gilroy.black.s14.w500,
                          children: <TextSpan>[
                            TextSpan(
                                text: '  Sign up',
                                style: gilroy.green.s14.w500,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RegistrationScreen(
                                          authCubit: widget.authCubit,
                                        ),
                                      ),
                                    );
                                  })
                          ],
                        ),
                      ),
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

  Widget _button(SignInState state) => BaseButton(
    isGradient: true,
    label: "Continue",
        onTap: () {
          if (InputChecker.checkEmail(email)) {
            cubit.signIn(email, password);
          } else {
            cubit.setEmailValidationError();
          }
        },
        isActive: email.isNotEmpty && password.length > 5,
        isLoading: state is SignInLoading,
        padding: EdgeInsets.symmetric(horizontal: 16.pw, vertical: 14.ph),
      );
}
