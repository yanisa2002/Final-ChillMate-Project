
import 'package:chillmate/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'กรอกอีเมลที่ถูกต้อง'
        : null;
  }

  Future<void> forgotPass(String email) async {
    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var request = http.Request(
          'GET', Uri.parse('http://161.246.5.159:7504/user/forget'));
      request.bodyFields = {'email': email};
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print('ForgotPassword -.');
      print(response.statusCode);
      //print(data);
      if (response.statusCode == 200) {
        print("yeah!");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15 * 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'ลืมรหัสผ่าน ? ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'กรุณากรอกอีเมลของคุณ. \nเราจะส่งรหัสที่อีเมลของคุณ.',
                    ),
                    const SizedBox(height: 15 * 3),
                    const Text("อีเมลผู้ใช้"),
                    const SizedBox(height: 8),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9@a-zA-Z.]")),
                        ],
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final isValidate = formKey.currentState!.validate();
                          if (isValidate) {
                            print(emailController.text.toString());
                            forgotPass(emailController.text.toString());
                          }
                        },
                        child: const Text('ส่งอีเมล'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
