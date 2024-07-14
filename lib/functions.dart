import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/form_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Student>?> getStudentList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? studentListString = prefs.getString('studentList');
    if (studentListString != null) {
      final List<dynamic> jsonList = jsonDecode(studentListString);
      List<Student>studentList = jsonList.map((json) => Student.fromJson(json)).toList();
      return studentList;
    }
    return null;
  }

  Future<void> saveStudentList(List<Student> studentList) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentListString = jsonEncode(studentList.map((student) => student.toJson()).toList());
    await prefs.setString('studentList', studentListString);
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black87,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
