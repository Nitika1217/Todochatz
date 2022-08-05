import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final formkey = GlobalKey<FormState>();
  final controller_ = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login Page'),
      ),
      body: SafeArea(
        child: Center(
            child: AnimatedContainer(
          duration: Duration(milliseconds: 800),
          decoration: BoxDecoration(color: Colors.white),
          width: 300,
          height: 288,
          child: SingleChildScrollView(
            child: Card(
              child: Form(
                key: formkey,
                child: Column(children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val!.contains('0')) {
                        return null;
                      }
                      return "Not a valid email address";
                    },
                    decoration: InputDecoration(hintText: 'E-mail'),
                    controller: controller_[0],
                  ),
                  TextFormField(
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Not a valid password";
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: 'Password'),
                      controller: controller_[1]),
                  TextFormField(
                      validator: (val) {
                        if (val!.length < 4 || val == null) {
                          return "Not a valid name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: 'Name'),
                      controller: controller_[2]),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: controller_[0].text,
                            password: controller_[1].text);
                      }
                    },
                    child: Text("Login"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: controller_[0].text,
                                  password: controller_[1].text)
                              .then((value) async {
                            await FirebaseAuth.instance.currentUser!
                                .updateDisplayName(controller_[2].text);
                          });
                        } catch (error) {
                          print(error);
                        }
                      }
                    },
                    child: Text("Register"),
                  ),
                ]),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
