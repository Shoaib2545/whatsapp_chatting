import 'package:flutter/material.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
