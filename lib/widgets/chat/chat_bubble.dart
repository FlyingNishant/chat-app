import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userName;
  final String userImage;
  const ChatBubble({
    required this.message,
    required this.isMe,
    required this.userName,
    required this.userImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              constraints: BoxConstraints(
                minWidth: 70,
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                color:
                    isMe ? Colors.greenAccent : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(isMe ? 12 : 0),
                  bottomRight: Radius.circular(!isMe ? 12 : 0),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black : Colors.white,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: isMe ? -10 : null,
              top: -10,
              right: isMe ? null : -10,
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(userImage),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
