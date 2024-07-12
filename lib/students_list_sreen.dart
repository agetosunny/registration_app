import 'package:flutter/material.dart';
import 'package:project/form_model.dart';
import 'package:project/functions.dart';

class RegisteredStudentScreen extends StatefulWidget {
  const RegisteredStudentScreen({super.key});

  @override
  State<RegisteredStudentScreen> createState() => _RegisteredStudentScreenState();
}

class _RegisteredStudentScreenState extends State<RegisteredStudentScreen> {
 
  List<Student>?studentList=List.empty(growable: true);
   @override
     void initState() {
    super.initState();
    _loadStudentList();
  }
  Future<void> _loadStudentList() async {
    List<Student>? savedStudentList = await getStudentList();
    setState(() {
      studentList = savedStudentList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registred Students",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),),
      ),
      
      body: (studentList == null || studentList!.isEmpty)
        ? const Center(child: Text("No data recorded."))
        : ListView.builder(
        itemCount: studentList?.length,
        itemBuilder: (context,index) => getField(index),),
      
    );
  }
   Widget getField(int index){
      return Card(
        child: ListTile(leading:  const Icon(Icons.person,size: 50,),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(studentList![index].name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ) ,),
            Text("Course: ${studentList![index].course}"),
          ],
        ),
        ),
      );
  }
}