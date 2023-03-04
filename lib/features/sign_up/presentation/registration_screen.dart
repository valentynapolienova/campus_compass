
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:int20h/core/helper/images.dart';
import 'package:int20h/core/helper/notification.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/bottom_sheet_opener.dart';
import 'package:int20h/core/util/input_converter.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/app_bars/base_app_bar.dart';
import 'package:int20h/core/widgets/buttons/base_button.dart';
import 'package:int20h/features/sign_up/domain/entities/university.dart';
import 'package:int20h/features/sign_up/presentation/components/auth_text_field.dart';
import 'package:int20h/features/sign_up/presentation/components/choose_bottom_sheet.dart';
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
  void initState() {
    cubit.getUniversities();
    super.initState();
  }

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
          backgroundColor: CColors.white,
          body: KeyboardDismissOnTap(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.pw),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.ph,
                      ),
                      Image.asset(
                        PngIcons.compass,
                        //color: CColors.green,
                        height: 100.ph,
                      ),
                      SizedBox(
                        height: 30.ph,
                      ),
                      AuthTextField(

                          hintText: 'Enter your name',

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
                        height: 12.ph,
                      ),
                      InkWell(
                        onTap: () {
                          showCustomBottomSheet(context,  ChooseBottomSheet(
                            chosenId: state.universityId ?? -1,
                            title: "Choose your university", options: state.universities, onTap: cubit.chooseUniversity, cubit: cubit,),);

                        },
                        child: AuthTextField(
hintColor: state.universityId == null ? null : CColors.black,
                            hintText: state.universityId == null ? 'Choose your university' : state.universities.firstWhere((element) => element.id == state.universityId).name ?? '',
                          onChanged: (s) {
                          },
                         enabled: false,
                        ),
                      ), SizedBox(
                        height: 12.ph,
                      ),
                      IgnorePointer(
                        ignoring: state.universityId == null,
                        child: InkWell(
                          onTap: (){
                            showCustomBottomSheet(context,  ChooseBottomSheet(title: "Choose your group", options: state.groups, onTap: cubit.chooseGroup, cubit: cubit, chosenId: state.groupId ?? -1,),);
                          },
                          child: AuthTextField(

                            hintColor: state.groupId == null ? null : CColors.black,
                            hintText: state.groupId == null ? 'Choose your group' : state.groups.firstWhere((element) => element.id == state.groupId).name ?? '',
                            onChanged: (s) {
                            },
                            enabled: false,
                          ),
                        ),
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
                                  style: gilroy.w500.s13
                                      .copyWith(color: Colors.red.shade400),
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
    isGradient: true,
        label: "Continue",
        onTap: () {
          if (InputChecker.checkEmail(email)) {
            cubit.signUp(name, email, password, state.groupId!);
          } else {
            cubit.setEmailValidationError();
          }
        },
        isActive: name.isNotEmpty && email.isNotEmpty && password.length > 5 && state.groupId != null,
        isLoading: state is SignUpLoading,
        padding: EdgeInsets.symmetric(horizontal: 16.pw, vertical: 14.ph),
      );

}
