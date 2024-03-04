import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:date/view/auth/onBoarding/Fourth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uic/step_indicator.dart';

import '../../../controller/auth_controller.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    String countryValue;
    String stateValue;
    String cityValue;
    var authenticationController =
        AuthenticationController.authenticationController;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            StepIndicator(
              selectedStepIndex: 3,
              totalSteps: 4,
              showLines: true,
              colorCompleted: Colors.pink,
            ),
            SelectState(
              // style: TextStyle(color: Colors.red),
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue = value;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue = value;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
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
                        Get.to(FourthPage());
                      } else {
                        Get.to(ThirdPage());
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
