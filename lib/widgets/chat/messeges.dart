import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messeges extends StatelessWidget {
  const Messeges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (ctx,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          final chatDocs = streamSnapshot.data!.docs;
          return ListView.builder(
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) {
                return Text(chatDocs[index]['text']);
              });
        }
      },
    );
  }
}
