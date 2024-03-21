import 'package:chillmate/data/repository.dart';
import 'package:chillmate/models/userData.dart';
import 'package:chillmate/pkg/constant/asset.dart';
import 'package:chillmate/screen/setting/setting.dart';
import 'package:chillmate/screen/setting/editProfilePage.dart';
import 'package:flutter/material.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({Key? key}) : super(key: key);

  @override
  _ProfileViewPageState createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  bool isObscurePassword = true;

  List<String> InterestType = [
    'อาหารเช้า',
    'อาหารจานเดียว',
    'กับแกล้ม/อาหารว่าง',
    'มังสวิรัติ',
    'อาหารไทย',
    'อาหารเหนือ',
    'อาหารอีสาน',
    'อาหารใต้',
    'อาหารญี่ปุ่น',
    'อาหารจีน',
    'อาหารเกาหลี',
    'อาหารฝรั่ง',
    'อาหารอิตาเลียน',
    'สเต๊ก',
    'แกง',
    'สูตรน้ำจิ้ม',
    'อาหารฟิวชัน',
    'ซุป',
    'อาหารนานาชาติ',
    'แซนด์วิช',
    'อาหารเย็น',
    'น้ำพริก',
    'กับข้าว',
    'ก๋วยเตี๋ยว',
    'เครื่องดื่ม',
    'อาหารเพื่อสุขภาพ',
    'ของหวาน/เบเกอรี่',
  ];
  List<String> AllergiesType = [
    'นม',
    'ไข่',
    'ปลา',
    'กุ้ง',
    'หอย',
    'ปู',
    'ปลาหมึก',
    'ถั่งลิสง',
    'ถั่วเหลือง',
    'นัท',
    'ข้าวสาลี',
  ];

  Repository repository = Repository();
  User? listUser;

  Future getProfile() async {
    try {
      print("Profile---------");
      var user = await repository.getProfile();
      print("oooooooooo");
      print(listUser);
      setState(() {
        listUser = user;
      });
      print(listUser?.userName);
    } catch (e) {
      print("Error fetching data Profile: $e");
      // Handle the error accordingly
    }
  }

  @override
  void initState() {
    getProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String interestsString = listUser?.interest.join(', ') ?? '';
    String allogreString = listUser?.allogre.join(', ') ?? '';
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'ข้อมูลผู้ใช้',
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
              MaterialPageRoute(builder: (context) => Setting()),
            );
          },
          icon: Icon(Icons.keyboard_arrow_left),
          color: Colors.amber,
          iconSize: 40,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfilePage()),
              );
            },
            icon: Icon(Icons.edit),
            color: Colors.amber,
            iconSize: 25,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            '${AssetConst.PROFILE_IMAGE_URL}${listUser?.image}'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            showText('ชื่อสกุล', listUser?.name),
            showText('ชื่อผู้ใช้', listUser?.userName),
            showText('อีเมล', listUser?.email),
            showText('รหัสผ่าน', listUser?.password),
            //---------------------------------------------
            InterestAllogre(
                interestsString: interestsString, allogreString: allogreString),
          ],
        ),
      ),
    );
  }

  Widget showText(String type, String? text) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            type,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            //color: Colors.amber,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text ?? 'ไม่ระบุ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}

class InterestAllogre extends StatelessWidget {
  const InterestAllogre({
    super.key,
    required this.interestsString,
    required this.allogreString,
  });

  final String interestsString;
  final String allogreString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'อาหารที่สนใจ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            //color: Colors.amber,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            interestsString,
            // listUser?.Interest as String,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ),
        //---------------------------
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'อาหารที่แพ้',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            //color: Colors.amber,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            allogreString,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
