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
  final courseController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  String? nameErrorText;
  String? courseErrorText;
  String? phoneErrorText;
  String? selectedGender;
  String? selectedCourse;

  final List<String> courses = [

    'Machine Learning and Artificial Intelligence',
    'Data Science and Analytics',
    'Cybersecurity Fundamentals',
    'Cloud Computing and Architecture',
    'Full Stack Web Development',
    'Mobile App Development(Flutter)',
    'Blockchain and Cryptocurrency',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Registration Form",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  label: labelWithAsterisk("Name"),
                  hintText: "Name",
                  border: OutlineInputBorder(),
                  errorText: nameErrorText,
                ),
                onChanged: (value) {
                  setState(() {
                    nameErrorText = fieldIsEmpty(value);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  label: labelWithAsterisk("Course"),
                  border: OutlineInputBorder(),
                  errorText: courseErrorText,
                ),
                value: selectedCourse,
                items: courses
                    .map((course) => DropdownMenuItem<String>(
                          value: course,
                          child: Text(course),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCourse = value;
                    courseErrorText = null;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a course';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: contactController,
                decoration: InputDecoration(
                  label: labelWithAsterisk("Contact Number"),
                  hintText: "Contact Number",
                  border: OutlineInputBorder(),
                  errorText: phoneErrorText,
                ),
                onChanged: (value) {
                  setState(() {
                    phoneErrorText = fieldIsEmpty(value);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(
                  label: Text("Address"),
                  hintText: "Address",
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: dobController,
                decoration: InputDecoration(
                  label: Text("Date of Birth"),
                  hintText: "Date of Birth",
                  border: OutlineInputBorder(),
                ),
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Gender", // No asterisk since it's optional
                  border: OutlineInputBorder(),
                ),
                value: selectedGender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                // No validator since it's not mandatory
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
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    _showRegisterDialog();
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
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
                          builder: (context) =>
                              const RegisteredStudentScreen()));
                },
                child: const Text("Show Registered Students"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _showRegisterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text(
              "By clicking yes, you are confirming your registration."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  nameErrorText = fieldIsEmpty(namecontroller.text);
                  courseErrorText = fieldIsEmpty(selectedCourse);
                  phoneErrorText = fieldIsEmpty(contactController.text);
                });
                if (namecontroller.text.isEmpty ||
                    selectedCourse!.isEmpty || selectedCourse == null ||
                    contactController.text.isEmpty ) {
                  _showSnackBar(context, "Please Enter Mandatory Fields.");
                  print("Snackbar ok.");
                } else {
                  setState(() {
                    studentList.add(
                        Student(namecontroller.text, selectedCourse!));
                    saveStudentList(studentList);
                  });
                  _showSnackBar(context, "Registration Successful.");
                  namecontroller.clear();
                  selectedCourse=null;
                  contactController.clear();
                  addressController.clear();
                  selectedGender=null;
                  dobController.clear();
                  emailController.clear();

                }
                print("selected : $selectedCourse");
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  String? fieldIsEmpty(value) {
    if (value.isEmpty) {
      return "Please fill this field.";
    }
    return null;
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black87,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget labelWithAsterisk(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        const Text(
          ' *',
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
