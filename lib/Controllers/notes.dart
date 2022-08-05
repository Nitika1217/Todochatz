// ignore_for_file: non_constant_identifier_names, camel_case_types
import 'package:flutter/material.dart';
import 'package:todochatz/Controllers/API_controller.dart';

class notes {
  static final ValueNotifier<List<String>> Note = ValueNotifier([]);

  static Future<void> addnote(BuildContext context, String note) async {
    try {
      await API_controller.addnote(context, note);
      Note.value.add(note);
      Note.notifyListeners();
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(error.toString()),
              ));
    }
  }

  static Future<void> getnotes(BuildContext context) async {
    try {
      Note.value = await API_controller.getnotes();
      Note.notifyListeners();
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(error.toString()),
              ));
    }
  }
}
