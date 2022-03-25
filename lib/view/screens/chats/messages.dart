import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/view/screens/chats/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance.currentUser;
    return 
    StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (chatSnapshot.hasData) {
            var data = chatSnapshot.data!.docs;
            return ListView.builder(
                reverse: true,
                itemCount: data.length,
                itemBuilder: (ctx, index) {
                  return MessageBubble(key: ValueKey(data[index].id), textMessage: data[index]['text'],userName: data[index]['userName'] ,isMe: data[index]['userId'] == auth!.uid ,);
                });
          }
          return Center(
            child: Text('Something went wrong'),
          );
        });
  }
}
