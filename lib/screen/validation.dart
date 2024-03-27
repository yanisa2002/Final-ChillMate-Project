import 'dart:convert';
import 'package:chillmate/pkg/constant/asset.dart';
import 'package:chillmate/screen/login.dart';
import 'package:chillmate/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Validation extends StatefulWidget {
  final String name;
  final String username;
  final String email;
  final String password;
  const Validation(
      {Key? key,
      required this.name,
      required this.username,
      required this.email,
      required this.password})
      : super(key: key);

  @override
  State<Validation> createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  final validatController = TextEditingController();
  String ref = '';
  String id = '';
  bool check = false;

  Future<void> toComplete(
    String name,
    String username,
    String email,
    String password,
    String id,
    String otp,
  ) async {
    try {
      Response response = await post(
          Uri.parse('${AssetConst.API_URL}user/regiter'),
          body: {
            'otp': otp,
            'id': id,
            'Username': username,
            'Name': name,
            'Email': email,
            'Password': password,
          });
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      print('Complete Register -.');
      if (response.statusCode == 201) {
        print("yeah! register");
        print(data);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getOTP(String email) async {
    try {
      Response response = await post(
          Uri.parse('http://161.246.5.159:7504/user/otp'),
          body: {'email': email});

      var data = jsonDecode(response.body.toString());
      print('OTP -.');
      if (response.statusCode == 201) {
        print("yeah!");
        print(data['id']);
        print(data['ref']);
        ref = data['ref'];
        id = data['id'];
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getOTP(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF49D1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Signup()),
            );
          },
          icon: Icon(Icons.keyboard_arrow_left),
          color: Colors.white,
          iconSize: 40,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 200),
                Text(
                  "กรอกรหัสยืนยัน",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "เราได้ส่งรหัสยืนยันไปที่",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.email,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: validatController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'รหัสยืนยัน',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      print("sent OTP");
                      toComplete(
                          widget.name,
                          widget.username,
                          widget.email,
                          widget.password,
                          id,
                          validatController.text.toString());
                      print("Goooo");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB01E68),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'ส่งรหัสยืนยัน',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 00),
          duration: Duration(seconds: 30),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.grey),
          ),
          onEnd: () {},
        )
      ],
    );
  }
}
