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
  final _formKey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();
  final courseController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  String? selectedGender;
  String? selectedCourse;

  final List<String> courses = [
    'Select a course',
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    label: labelWithAsterisk("Name"),
                    hintText: "Name",
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill this field.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    label: labelWithAsterisk("Course"),
                    border: const OutlineInputBorder(),
                  ),
                  value: selectedCourse,
                  items: courses
                      .map((course) => DropdownMenuItem<String>(
                            value: course == 'Select a course' ? null : course,
                            child: Text(course),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCourse = value;
                    });
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value == 'Select a course') {
                      return 'Please select a course';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: contactController,
                  decoration: InputDecoration(
                    label: labelWithAsterisk("Contact Number"),
                    hintText: "Contact Number",
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill this field.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  controller: addressController,
                  decoration: const InputDecoration(
                    label: Text("Address"),
                    hintText: "Address",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: dobController,
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
                    labelText: "Gender",
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
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
                      if (_formKey.currentState!.validate()) {
                        _showRegisterDialog();
                      } else {
                        _showSnackBar(
                            context, "Please Enter Mandatory Fields.");
                      }
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisteredStudentScreen()));
                    },
                    child: const Text(
                      "Show Registered Students",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    studentList
                        .add(Student(namecontroller.text, selectedCourse!));
                    saveStudentList(studentList);
                  });
                  _showSnackBar(context, "Registration Successful.");
                  namecontroller.clear();
                  selectedCourse = null;
                  contactController.clear();
                  addressController.clear();
                  selectedGender = null;
                  dobController.clear();
                  emailController.clear();
                } else {
                  _showSnackBar(context, "Please Enter Mandatory Fields.");
                }
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  String? fieldIsEmpty(String? value) {
    if (value == null || value.isEmpty) {
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
