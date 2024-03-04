import 'package:date/view/auth/onBoarding/onBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../controller/auth_controller.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showProgressBar = false;
  var controllerAuth = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Positioned.fill(
        top: 0,
        child: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/images/log.webp',
              ),
              fit: BoxFit.cover,
            )),
            child: showProgressBar == true
                ? GFLoader(
                    type: GFLoaderType.ios,
                    size: GFSize.LARGE,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          height: 50,
                          child: CustomTextField(
                              editingController: emailTextEditingController,
                              iconData: Icons.email_outlined,
                              isObsecure: false,
                              labelText: "beki@gmail.com"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          height: 60,
                          child: CustomTextField(
                              editingController: passwordTextEditingController,
                              iconData: Icons.email_outlined,
                              isObsecure: true,
                              labelText: "******"),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: InkWell(
                            onTap: () {
                              if (emailTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  passwordTextEditingController.text
                                      .trim()
                                      .isNotEmpty) {
                                setState(() {
                                  showProgressBar = true;
                                });
                                controllerAuth.loginUser(
                                    emailTextEditingController.text.trim(),
                                    passwordTextEditingController.text.trim());
                                setState(() {
                                  showProgressBar = false;
                                });
                              } else {
                                Get.snackbar("Email/Password is missing",
                                    "please fill all fields");
                              }
                            },
                            child: Center(
                                child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 95,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
