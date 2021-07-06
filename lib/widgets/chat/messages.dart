import 'package:chat_app/widgets/chat/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messeges extends StatelessWidget {
  const Messeges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          final chatDocs = streamSnapshot.data!.docs;

          return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) {
                return ChatBubble(
                  message: chatDocs[index]['text'],
                  userName: chatDocs[index]['username'],
                  userImage: chatDocs[index]['user_image'],
                  isMe: chatDocs[index]['uid'] ==
                      FirebaseAuth.instance.currentUser!.uid,
                  key: ValueKey(chatDocs[index].id),
                );
              });
        }
      },
    );
  }
}
