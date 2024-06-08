import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Message Page!'),
      ),
    );
  }
}
