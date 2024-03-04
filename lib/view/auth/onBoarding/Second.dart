import 'dart:io';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:date/controller/auth_controller.dart';
import 'package:date/view/auth/onBoarding/Third.dart';
import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:uic/step_indicator.dart';

import '../../../widgets/custom_text_field.dart';
import 'package:gender_picker/source/enums.dart';

class SecondPage extends StatefulWidget {
  SecondPage();

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String selectedGender = 'Select Gender';
    var authenticationController =
        AuthenticationController.authenticationController;
    ValueNotifier<String> genderNotifier =
        ValueNotifier<String>('Select Gender');
    String countryValue;
    String stateValue;
    String cityValue;

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            StepIndicator(
              selectedStepIndex: 2,
              totalSteps: 4,
              showLines: true,
              colorCompleted: Colors.pink,
            ),
            SizedBox(
              height: 30,
            ),
            getWidget(true, false),
            const SizedBox(
              height: 35,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              child: CustomTextField(
                isObsecure: false,
                editingController: authenticationController.ageController,
                labelText: "Age",
                iconData: Icons.numbers,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width - 40,
            //   height: 50,
            //   child: CustomTextField(
            //     isObsecure: false,
            //     editingController: authenticationController.phoneController,
            //     labelText: "Phone",
            //     iconData: Icons.phone,
            //   ),
            // ),
            PhoneNumberInput(
              locale: 'en',
              allowSearch: false,
              countryListMode: CountryListMode.dialog,
              contactsPickerPosition: ContactsPickerPosition.suffix,
              onChanged: (p0) {
                print(p0);
                authenticationController.phoneController.text = p0;
              },
            ),

            const SizedBox(
              height: 35,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              child: CustomTextField(
                isObsecure: false,
                editingController: authenticationController.religionController,
                labelText: "Religion",
                iconData: Icons.church,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              child: CustomTextField(
                isObsecure: false,
                editingController:
                    authenticationController.professionController,
                labelText: "Profession",
                iconData: Icons.work,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 20,
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
                        Get.to(ThirdPage());
                      } else {
                        Get.to(ThirdPage());
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
    ));
  }

  Widget getWidget(bool showOtherGender, bool alignVertical) {
    var authenticationController =
        AuthenticationController.authenticationController;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        showOtherGender: showOtherGender,
        verticalAlignedText: alignVertical,

        // to show what's selected on app opens, but by default it's Male
        selectedGender: Gender.Male,
        selectedGenderTextStyle:
            TextStyle(color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        onChanged: (Gender? gender) {
          if (gender == Gender.Female) {
            authenticationController.genderController.text = 'female';
          } else if (gender == Gender.Male) {
            authenticationController.genderController.text = 'male';
          }
        },
        //Alignment between icons
        equallyAligned: true,

        animationDuration: Duration(milliseconds: 300),
        isCircular: true,
        // default : true,
        opacityOfGradient: 0.4,
        padding: const EdgeInsets.all(3),
        size: 50, //default : 40
      ),
    );
  }
}
