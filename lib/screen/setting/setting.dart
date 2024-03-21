import 'package:chillmate/data/secure_storage.dart';
import 'package:chillmate/screen/login.dart';
import 'package:chillmate/screen/setting/ProfileViewPage.dart';
import 'package:chillmate/screen/nav.dart';
import 'package:chillmate/screen/setting/groupRefriPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'การตั้งค่า',
          style: TextStyle(
              color: Color(0xFFF49D1A),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Nav()),
            );
          },
          icon: Icon(Icons.keyboard_arrow_left),
          color: Colors.amber,
          iconSize: 40,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Color.fromARGB(255, 255, 243, 182),
                title: Text(
                  "ข้อมูลผู้ใช้",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileViewPage()),
                    );
                  },
                  icon: Icon(Icons.keyboard_arrow_right),
                  color: Colors.black,
                  iconSize: 40,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Color.fromARGB(255, 255, 243, 182),
                title: Text(
                  "กลุ่มผู้ใช้",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GroupRefriPage()),
                    );
                  },
                  icon: Icon(Icons.keyboard_arrow_right),
                  color: Colors.black,
                  iconSize: 40,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Color.fromARGB(255, 255, 243, 182),
                title: Text(
                  "รายงาน",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    String mailId = '63010069@kmitl.ac.th';
                    String subject = 'รายงาน';
                    String message = '';
                    launchUrl(Uri.parse(
                        "mailto:$mailId?subject=$subject&body=$message"));
                    print('Report');
                  },
                  icon: Icon(Icons.keyboard_arrow_right),
                  color: Colors.black,
                  iconSize: 40,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print("Delete Account");
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Center(
                      child: Text(
                        "ลบบัญชีผู้ใช้",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      await SecureStorage()
                                          .deleteSecureData('token');
                                      print("Sign out");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()),
                                      );

                                      print(SecureStorage()
                                          .readSecureData('token'));
                                    },
                                    child: Text('ตกลง'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('ยกเลิก'),
                                  ),
                                ],
                                title: const Text('ออกจากระบบ'),
                                contentPadding: const EdgeInsets.all(20.0),
                                content: const Text(
                                    'คุณต้องการออกจากระบบใช่หรือไม่'),
                              ));
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Center(
                      child: Text(
                        "ออกจากระบบ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
