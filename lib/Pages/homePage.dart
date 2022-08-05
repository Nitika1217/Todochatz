// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todochatz/Pages/chatPage.dart';
import 'package:todochatz/Pages/todoPage.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/cnt.png'),
              radius: 200,
            ),
            title: Text(FirebaseAuth.instance.currentUser!.displayName!),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(Icons.label))
            ]),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                selected = value;
              });
            },
            currentIndex: selected,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "chat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.today_outlined), label: "todo"),
            ]),
        body: selected == 0 ? chatPage() : todoPage(),
      ),
    );
  }
}
