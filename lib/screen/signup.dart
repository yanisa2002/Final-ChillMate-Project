import 'package:chillmate/screen/validation.dart';
import 'package:flutter/material.dart';
import 'package:chillmate/screen/login.dart';
import 'package:chillmate/screen/nav.dart';
import 'dart:convert';
import 'package:http/http.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final dataKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool passToggle = true;
  bool passConToggle = true;

  
  void register(String name,String email,String username,String password) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>  Validation(
                name: name,
                username: username,
                email: email,
                password: password,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF49D1A),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100.0, left: 8.0, right: 8.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Form(
                key: dataKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'สมัครบัญชีผู้ใช้',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'กรุณากรอกข้อมูลให้ถูกต้อง',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Name',
                          //label: Text('Name'),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Username',
                          //label: Text('Username'),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Email',
                          //label: Text('Email'),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: passToggle,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Password',
                          //label: Text('Password'),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: confirmPasswordController,
                        obscureText: passConToggle,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Confirm Password',
                          //label: Text('ยืนยันรหัสผ่าน'),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passConToggle = !passConToggle;
                              });
                            },
                            child: Icon(passConToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () {
                          if (dataKey.currentState!.validate()) {
                            print("sent register");
                            register(
                                nameController.text.toString(),
                                emailController.text.toString(),
                                usernameController.text.toString(),
                                passwordController.text.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB01E68),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'สมัครบัญชีผู้ใช้',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 67, top: 30),
                      child: Row(
                        children: [
                          Text(
                            "มีบัญชีผู้ใช้แล้ว?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: Text(
                              "ลงชื่อเข้าใช้งาน",
                              style: TextStyle(
                                color: Color(0xFFB01E68),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
