import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({Key? key}) : super(key: key);

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final TextEditingController _sendMessageController = TextEditingController();
  var _enteredMessage = '';
  _sendMessage() async {
    FocusScope.of(context).unfocus();
    var auth = FirebaseAuth.instance.currentUser;
    var userData = await FirebaseFirestore.instance.collection('users').doc(auth!.uid).get();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': auth.uid,
      'userName': userData['userName']
    });
    _sendMessageController.clear();
    setState(() {
      _enteredMessage = '';
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _sendMessageController,
              decoration: const InputDecoration(
                hintText: 'New message'
              ),
              onChanged: (value){
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send,color: Theme.of(context).primaryColor,),
          ),
        ],
      ),
    );
  }
}
