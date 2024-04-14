import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:finsec/logic/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/stores/auth_store.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isVisiblePass = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        final NavigatorState navigator = Navigator.of(context);
        // if (vStatus[1] && !vStatus[2]) {
        //   await _showMaterialDialog(context, 1);
        // }
        navigator.pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: SizeConfig.safeBlockVertical! * 38,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      aspectRatio: 1,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      // onPageChanged: (index, reason) {},
                      // enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                    items: [
                      "assets/images/onboard_1.png",
                      "assets/images/onboard_2.png",
                      "assets/images/onboard_3.png",
                    ]
                        .map(
                          (item) => Image.asset(
                            item,
                            width: SizeConfig.screenWidth,
                            fit: BoxFit.fitWidth,
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: SizeConfig.getPercentSize(8),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.getPercentSize(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                          textController: emailController,
                          label: 'Email',
                          hint: 'example@email.com',
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: SizeConfig.getPercentSize(5),
                        ),
                        CustomTextField(
                          textController: passwordController,
                          label: 'Password',
                          hint: 'Password@123',
                          keyboardType: TextInputType.name,
                          icon: isVisiblePass == false
                              ? Icon(
                                  CupertinoIcons.eye_fill,
                                  color: ColorConstants.black,
                                  size: SizeConfig.getPercentSize(6),
                                )
                              : Icon(
                                  CupertinoIcons.eye_slash_fill,
                                  color: ColorConstants.black,
                                  size: SizeConfig.getPercentSize(6),
                                ),
                          obscureText: isVisiblePass,
                          onTapIcon: () {
                            setState(() {
                              isVisiblePass = !isVisiblePass;
                            });
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.getPercentSize(2),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: textWidget(
                            text: "Forgot password?",
                            style: textField(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.getPercentSize(2),
                  ),
                  GradientButton(
                    text: "Login",
                    onTap: () async {
                      if (await context.read<AuthStore>().signInWithEmailAndPassword(emailController.text, passwordController.text)) {
                        if (context.mounted) {
                          context.router.replace(const MainScaffoldRoute());
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid credentials'),
                            ),
                          );
                        }
                      }
                    },
                    // onTap: () {
                    // signUpUser(username: "mail@prerakgada.in", password: "Test@123", email: "mail@prerakgada.in");
                    // confirmUser(username: "mail@prerakgada.in", confirmationCode: "080420");
                    // },
                  ),
                  textWidget(
                    text: "OR",
                    style: textField(),
                  ),
                  BorderedButton(
                    text: "Continue with Google",
                    image: "assets/images/google.png",
                    onTap: () async {
                      if (await AuthRepo().googleAuth()) {
                        if (context.mounted) {
                          context.router.replaceAll([const MainScaffoldRoute()]);
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid credentials'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  BorderedButton(text: "Continue with Apple", image: "assets/images/apple.png", onTap: () async {}),
                  GestureDetector(
                    onTap: () => AutoRouter.of(context).push(RegisterRoute()),
                    child: textWidget(
                      text: "New Here? Sign Up",
                      style: textField(),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.getPercentSize(5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
