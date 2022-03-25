import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.textMessage, required this.isMe,required this.userName})
      : super(key: key);
  final String textMessage;
  final String userName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color:
                isMe ? Colors.blueGrey[300] : Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(8),
                topRight: const Radius.circular(8),
                bottomLeft:
                    isMe ? const Radius.circular(8) : const Radius.circular(0),
                bottomRight: !isMe
                    ? const Radius.circular(8)
                    : const Radius.circular(0)),
          ),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontWeight: FontWeight.bold,color: isMe ? Colors.white : Colors.black),
              ),
              Text(
                textMessage,
                style: TextStyle(color: isMe ? Colors.white : Colors.black)
              ),
            ],
          ),
        ),
      ],
    );
  }
}
