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
      return Dismissible(
        key: ValueKey<Student>(studentList![index]),
        background: Container(
          color: Colors.blue[400],
          child: const Icon(Icons.delete),
        ),
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
        confirmDismiss: (DismissDirection direction){
          return _alerDisplay(index);
        },
      );
  
  }
  Future<bool?> _alerDisplay(index) async {
    bool? del= await
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation!"),
          content: const Text(
              "Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                setState(() {
                  studentList!.removeAt(index);
                  saveStudentList(studentList!);
                });
                showSnackBar(context, "Item Deleted Successfully.");
                
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
    return del;
    
  }
}