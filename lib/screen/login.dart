import 'dart:convert';
import 'package:chillmate/data/secure_storage.dart';
import 'package:chillmate/screen/forgotPassword.dart';
import 'package:chillmate/screen/nav.dart';
import 'package:chillmate/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _text = TextEditingController();
  // bool _validate = false;
  final storage = new FlutterSecureStorage();

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passToggle = true;
  bool check = false;

  void login(String username, password) async {
    try {
      Response response = await post(
          //Uri.parse('https://240a-161-246-144-211.ngrok-free.app/user/login'),
          Uri.parse('http://161.246.5.159:7504/user/login'),
          body: {'Username': username, 'Password': password});

      var data = jsonDecode(response.body.toString());
      //print(data['access_token']);
      print('Login -.');
      print(response.statusCode);
      print(data);
      if (response.statusCode == 201) {
        print("yeah!");
        print(data['access_token']);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Nav()),
        );
        await SecureStorage().writeSecureData('token', data['access_token']);
        print(SecureStorage().readSecureData('token'));
        setState(() {
          check = false;
        });
      } else {
        print('failed');
        setState(() {
          check = true;
        });

        //print('failed');
      }
    } catch (e) {
      print(e.toString());
      //  print('L5');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    //check storage token
    // if (SecureStorage().readSecureData('token') != null){
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => const Nav()),
    //     );
    // }
    super.initState();
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
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ยินดีต้อนรับ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'กรอกชื่อผู้ใช้\nเพื่อเข้าสู่ระบบ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    Visibility(
                      visible: check,
                      child: Text(
                        "บัญชีหรือรหัสผ่านไม่ถูกต้อง",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFB01E68),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Username',
                          // label: Text('Username'),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอกบัญชีผู้ใช้';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _passwordController,
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
                          // label: Text('Password'),
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอกรหัสผ่าน';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 5.0),
                      child: Row(
                        children: [
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword()),
                              );
                            },
                            child: Text(
                              "ลืมรหัสผ่าน",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              print("success");
                              login(_usernameController.text.toString(),
                                  _passwordController.text.toString());
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB01E68),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'ลงชื่อเข้าใช้งาน',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Text(
                    //         '---------',
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 20,
                    //         ),
                    //       ),
                    //       Text(
                    //         'หรือลงชื่อเข้าใช้ด้วย',
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       Text(
                    //         '---------',
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 20,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 15),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Container(
                    //       height: 50,
                    //       width: 100,
                    //       decoration: BoxDecoration(
                    //         color: Colors.grey,
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       child: Icon(
                    //         Icons.g_mobiledata,
                    //         color: Colors.white,
                    //         size: 40,
                    //       ),
                    //     ),
                    //     Container(
                    //       height: 50,
                    //       width: 100,
                    //       decoration: BoxDecoration(
                    //         color: Colors.grey,
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       child: Icon(
                    //         Icons.facebook,
                    //         color: Colors.white,
                    //         size: 40,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65, top: 30),
                      child: Row(
                        children: [
                          Text(
                            "ยังไม่มีบัญชีผู้ใช้?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Signup()),
                                );
                              },
                              child: Text(
                                "สมัครบัญชีผู้ใช้",
                                style: TextStyle(
                                  color: Color(0xFFB01E68),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )),
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
