// ignore_for_file: avoid_print, dead_code, prefer_interpolation_to_compose_strings, prefer_const_declarations, camel_case_types

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API_controller {
  static final url = "https://global-chat-test.herokuapp.com/";

  static Future<void> addnote(BuildContext context, String note) async {
    try {
      final response = await http.post(Uri.parse(url + 'addnote'), body: {
        'email': FirebaseAuth.instance.currentUser!.email,
        'task': note
      });
      print(response.body);
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<String>> getnotes() async {
    try {
      final response = await http.get(Uri.parse(
          url + 'getnote?email=${FirebaseAuth.instance.currentUser!.email}'));
      final body = jsonDecode(jsonEncode(response.body));
      if (response.statusCode == 200) {
        final List<String> l = [];
        for (var i in body['message']) {
          l.add(i);
        }
        return l;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw body['message'];
      }
    } catch (error) {
      rethrow;
    }
  }
}
