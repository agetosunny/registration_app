import 'package:flutter/material.dart';
import 'package:project/form_model.dart';
import 'package:project/functions.dart';
import 'package:project/students_list_sreen.dart';

class FormSreen extends StatefulWidget {
  const FormSreen({super.key});

  @override
  State<FormSreen> createState() => _FormSreenState();
}

class _FormSreenState extends State<FormSreen> {
  List<Student> studentList = List.empty(growable: true);
  final namecontroller = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final courseController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Registration Form",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: namecontroller,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Address",
                hintText: "Address",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: dobController,
              decoration: const InputDecoration(
                labelText: "Date of Birth",
                hintText: "Date of Birth",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: genderController,
              decoration: const InputDecoration(
                labelText: "Gender",
                hintText: "Gender",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: "Course",
                hintText: "Course",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email Id",
                hintText: "Email Id",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: contactController,
              decoration: const InputDecoration(
                labelText: "Contact Number",
                hintText: "Contact Number",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                onPressed: () {
                  _showRegisterDialog();
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                ),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisteredStudentScreen()));
                },
                child: const Text("Show Registred Students"),
              ),
            ),
        ],
      ),
    );
  }
   void _showRegisterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("By clicking yes, you are confirming your registration."),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (namecontroller.text.isEmpty || addressController.text.isEmpty || dobController.text.isEmpty || genderController.text.isEmpty || courseController.text.isEmpty || contactController.text.isEmpty || emailController.text.isEmpty) {
                  _showSnackBar(context, "Please Enter all Fields.");
                }else{setState(() {
                    studentList.add(Student(namecontroller.text, courseController.text));
                    saveStudentList(studentList);
                  });
                  _showSnackBar(context, "Registration Successful.");
                  
                }
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
    void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black87,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
