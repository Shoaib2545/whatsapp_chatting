import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  submitAuthForm(String? emailAddress, String? userName, String? password, bool isLogin,BuildContext ctx) async {
    UserCredential authResult;
    try{
      setState(() {
        _isLoading = true;
      });
      if(isLogin){
        authResult = await _auth.signInWithEmailAndPassword(email: emailAddress!, password: password!);
        var snackbar = const SnackBar(content: Text('Successfully logged in'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackbar);
      }else{
        authResult = await _auth.createUserWithEmailAndPassword(email: emailAddress!, password: password!);
        await firebaseFirestore.collection('users').doc(authResult.user!.uid).set({
          'userName' : userName,
          'emailAddress' : emailAddress
        });
        var snackbar = const SnackBar(content: Text('Successfully created'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackbar);
      }
    }on PlatformException catch(err){
      setState(() {
        _isLoading = false;
      });
      var snackbar = SnackBar(content: Text(err.message!));
      ScaffoldMessenger.of(ctx).showSnackBar(snackbar);
    } catch(e){
      setState(() {
        _isLoading = false;
      });
      var snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(ctx).showSnackBar(snackbar);
    } finally{
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthFormWidget(submitFn: submitAuthForm,isLoading: _isLoading),
    );
  }
}
