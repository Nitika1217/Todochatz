import 'package:flutter/material.dart';
import 'package:todochatz/Controllers/notes.dart';
import 'package:todochatz/Widgets/todo_body.dart';

class todoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: notes.getnotes(context),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text("An Error Occoured"));
          } else {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Todobody();
          }
        });
  }
}
