import 'dart:io';
import 'dart:ui';

import 'package:date/controller/auth_controller.dart';
import 'package:date/view/auth/onBoarding/Second.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uic/widgets.dart';

import '../../../widgets/custom_text_field.dart';

class FirstPage extends StatefulWidget {
  FirstPage();

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    var authenticationController =
        AuthenticationController.authenticationController;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StepIndicator(
                selectedStepIndex: 1,
                totalSteps: 4,
                showLines: true,
                colorCompleted: Colors.pink,
              ),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   "Profile Details",
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 22),
              // ),
              SizedBox(
                height: 30,
              ),
              authenticationController.imageFile == null
                  ? CircleAvatar(
                      radius: 80,
                      backgroundImage:
                          AssetImage('assets/images/profile_avatar.jpg'),
                      backgroundColor: Colors.white,
                    )
                  : Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: FileImage(File(
                                  authenticationController.imageFile!.path)))),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        await authenticationController
                            .pickImageFileFromGallery();
                        setState(() {
                          authenticationController.imageFile;
                        });
                      },
                      icon: Icon(
                        Icons.image_outlined,
                        color: Colors.pink,
                        size: 30,
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () async {
                        await authenticationController.captureImageFromPhone();
                        setState(() {
                          authenticationController.imageFile;
                        });
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.pink,
                        size: 30,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: CustomTextField(
                  isObsecure: false,
                  editingController: authenticationController.nameController,
                  labelText: "name",
                  iconData: Icons.person,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: CustomTextField(
                  isObsecure: false,
                  editingController: authenticationController.emailController,
                  labelText: "email",
                  iconData: Icons.email_outlined,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: CustomTextField(
                  isObsecure: true,
                  editingController:
                      authenticationController.passwordController,
                  labelText: "******",
                  iconData: Icons.person,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Or',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              GFButton(
                onPressed: () {},
                text: "Google",
                icon: Icon(Icons.email),
                type: GFButtonType.outline2x,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: TextButton(
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      if (authenticationController.imageFile == null &&
                          authenticationController.nameController.text
                              .trim()
                              .isEmpty &&
                          authenticationController.emailController.text
                              .trim()
                              .isEmpty &&
                          authenticationController.passwordController.text
                              .trim()
                              .isEmpty) {
                        Get.to(SecondPage());
                      } else {
                        Get.to(SecondPage());
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
