import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactScreen extends StatelessWidget {
  static const routeName = "/contact-screen";

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat With Us"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, top: 25, bottom: 40, right: 25),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Tawk(
            directChatLink: 'https://tawk.to/chat/642eb13431ebfa0fe7f6d6e7/1gtb68dtg',
            visitor: TawkVisitor(
              name: user?.displayName ?? "Unknown",
              email: user?.email ?? "Email N/A",
            ),
          ),
        ),
      ),
    );
  }
}
