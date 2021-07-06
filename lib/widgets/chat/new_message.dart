import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final msgController = TextEditingController();
  var enteredMessage = '';

  void sendMsg() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!;
    print(user.uid);
    print('hello');
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'username': userData['username'],
      'uid': user.uid,
      'user_image': userData['user_image']
    });
    msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                decoration: InputDecoration(labelText: 'Enter a msg'),
                controller: msgController,
                onChanged: (value) {
                  setState(() {
                    enteredMessage = value;
                  });
                }),
          ),
          IconButton(
            onPressed: enteredMessage.isEmpty ? null : sendMsg,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
