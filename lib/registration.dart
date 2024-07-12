import 'package:project/login.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isSelectedPass = true;
  bool isSelectedConfPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 19, 144, 255),
              Color.fromARGB(255, 65, 206, 241),
              Color.fromARGB(255, 143, 228, 254),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.2,0.5,0.1]
          ),
        ),
        child: Center(
          child: Container(
            width: 450,
            height: 400,
            decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24),topRight: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 14.0,
                      spreadRadius: 1,
                    ),
                  ]),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(14),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(14),
                    child: TextField(
                      obscureText: isSelectedPass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isSelectedPass ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isSelectedPass = !isSelectedPass;
                            });
                          },
                        ),
                        labelText: "Password",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(14),
                    child: TextField(
                      obscureText: isSelectedConfPass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isSelectedConfPass ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isSelectedConfPass = !isSelectedConfPass;
                            });
                          },
                        ),
                        labelText: "Confirm Password",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          )),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
