import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/widgets/alert_dialog_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? countryName = 'Pakistan';
  String? countryCode = '+92';
  TextEditingController phoneNumberController = TextEditingController();

  authFunction() async {
    if (phoneNumberController.text[0] == '0') {
      var abc = phoneNumberController.text.substring(1);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode!+abc,
        verificationCompleted: (PhoneAuthCredential credential) {
          print(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          print(verificationId+resendToken.toString());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print(verificationId);
        },
      );
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode!+phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) {
          print(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          print(verificationId+resendToken.toString());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print(verificationId);
        },
      );
      print(phoneNumberController.text);
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Center(
            child: Text(
          'Enter your phone number',
          style: TextStyle(color: Colors.green.shade700),
        )),
        actions: [
          InkWell(
            onTap: () {
              print('Menu');
            },
            child: const Icon(
              Icons.more_vert,
              color: Colors.black45,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const TextSpan(
                          text:
                              'WhatsApp will need to verify your phone number. ',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextSpan(
                            text: 'What\'s my number?',
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 18),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('What\'s my number');
                              }),
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 280,
                  // height: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.teal, width: 2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            countryName!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          CountryCodePicker(
                            onChanged: (e) {
                              setState(() {
                                countryCode = e.dialCode;
                                countryName = e.name;
                              });
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'PK',
                            favorite: const ['+92', 'PK'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                            // showFlag: false,
                            showFlagMain: false,
                            hideMainText: true,
                            showDropDownButton: true,
                            onInit: (c) {
                              countryCode = c!.dialCode;
                              countryName = c.name;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 280,
                  height: 40,
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 30,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2, color: Colors.teal),
                          ),
                        ),
                        child:
                            // Row(
                            // children: const [
                            // Text(
                            //   '+',
                            //   style: TextStyle(fontSize: 16),
                            // ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            Text(
                          countryCode!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        // ],
                        // ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: 190,
                        height: 30,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2, color: Colors.teal),
                          ),
                        ),
                        child: TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'phone number',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Carrier charges may apply',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    AlertDialogWidget.showDialogg(
                        phoneNumber: countryCode,
                        subtitle: '03472837812',
                        fct: authFunction,
                        context: context);
                  },
                  child: const Text('Next'),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
