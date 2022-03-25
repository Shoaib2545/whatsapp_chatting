import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/view/home.dart';
import 'package:whatsapp/view/screens/auth/auth_screen.dart';
import 'package:whatsapp/view/screens/chat_screen.dart';
import 'package:whatsapp/view/screens/chats/messages.dart';
import 'package:whatsapp/view/screens/tabs/chats.dart';
import './view/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.teal,
          secondary: Colors.purpleAccent // Your accent color
        ),
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.auth StateChanges(),builder: (ctx,userSnapshot){
        if(userSnapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(userSnapshot.hasData){
          // return const Home();
          return const ChatMessageScreen();
        }
        return const AuthScreen();
      },),
    );
  }
}
