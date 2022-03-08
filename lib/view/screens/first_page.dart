import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Welcome to WhatsApp',
              style: TextStyle(color: Colors.green.shade700, fontSize: 26),
            ),
            const SizedBox(height: 60),
            const CircleAvatar(
              radius: 132,
            ),
            const SizedBox(height: 60),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  const TextSpan(text: 'Read our '),
                  TextSpan(
                      style: const TextStyle(color: Colors.blue),
                      text: 'Privacy Policy',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Privacy Policy');
                        }),
                  const TextSpan(
                      text: '.Tap "Agree and continue" to accept the '),
                  TextSpan(
                      style: const TextStyle(color: Colors.blue),
                      text: 'Terms of Services',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Terms of Services');
                        }),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
            // const Text(
            //   'Read our Privacy Policy. Tap "Agree and Continue" to accept the Terms of Service.',
            //   style: TextStyle(fontSize: 18),
            // ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text('AGREE AND CONTINUE'))
          ],
        ),
      ),
    );
  }
}
