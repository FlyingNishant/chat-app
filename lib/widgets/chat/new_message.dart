import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final msgController = TextEditingController();
  var enteredMessage = '';

  void sendMsg() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
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
            icon: Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
