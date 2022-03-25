import 'package:flutter/material.dart';
import 'package:whatsapp/view/screens/chats/messages.dart';
import 'package:whatsapp/view/screens/chats/send_message.dart';

class ChatMessageScreen extends StatelessWidget {
  const ChatMessageScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: ChatMessages()),
          SendMessage(),
        ],
      ),
      
    );
  }
}