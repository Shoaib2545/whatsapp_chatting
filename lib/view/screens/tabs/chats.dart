import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        FirebaseFirestore.instance.collection('chats/OaNNkLkRDvkUuFNijAUj/messages').snapshots().listen((event) { print(event.docs[0]['text']); });
      },child: const Icon(Icons.add,size: 32,),),
      body: ListView.builder(
          itemCount: 55,
          itemBuilder: (ctx, index) {
            return const ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.yellow,
                child: Text('Name'),
              ),
              title: Text('How are you?'),
              subtitle: Text('I am fine.'),
              trailing: Text('Yesterday'),
            );
          }),
    );
  }
}