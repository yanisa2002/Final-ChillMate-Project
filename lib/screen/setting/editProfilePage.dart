import 'dart:io';
import 'dart:typed_data';

import 'package:chillmate/pkg/constant/asset.dart';
import 'package:chillmate/screen/setting/ProfileViewPage.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isObscurePassword = true;
  Uint8List? _image;
  File? selectedImage;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _interestController = TextEditingController();
  final _allergiesController = TextEditingController();

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
  List<String> selectedInterestType = [];
  List<String> selectedAllergiesType = [];

  void uploadFile(filePath) async {
    String fileName = basename(filePath.path);
    print("file base name: $fileName");

    try {
      FormData formData = new FormData.fromMap({
        "img": await MultipartFile.fromFile(filePath.path, filename: fileName),
      });
      Response response = await Dio()
          .post("${AssetConst.API_URL}user/chageimage", data: formData);
      print("File upload response: $response");
    } catch (e) {
      print("expectation Caugch: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'แก้ไขข้อมูลผู้ใช้',
          style: TextStyle(
              color: Color(0xFFF49D1A),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              // MaterialPageRoute(builder: (context) => const Nav()),
            );
          },
          icon: Icon(Icons.keyboard_arrow_left),
          color: Colors.amber,
          iconSize: 40,
        ),
        actions: [
          IconButton(
            onPressed: () {
              uploadFile(selectedImage);
            },
            icon: Icon(Icons.done),
            color: Colors.amber,
            iconSize: 40,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(_image!),
                                ),
                              ),
                            )
                          : Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 4, color: Colors.white),
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
                                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            color: Colors.blue,
                          ),
                          child: IconButton(
                            onPressed: () {
                              showImagePickerOption(context);
                            },
                            icon: Icon(Icons.add_a_photo),
                            iconSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                buildTextField("Name", "Kantida Parsomsup", false),
                buildTextField("Profile", "Kantida", false),
                buildTextField("Email", "kiitykan0808@gmail.com", false),
                buildTextField("Password", "54321", true),
                //---------------------------------------------
                DropdownSearch<String>.multiSelection(
                  popupProps: PopupPropsMultiSelection.menu(
                    showSelectedItems: true,
                  ),
                  items: InterestType,
                  onChanged: print,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                    labelText: "อาหารที่สนใจ",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownSearch<String>.multiSelection(
                  popupProps: PopupPropsMultiSelection.menu(
                    showSelectedItems: true,
                  ),
                  items: AllergiesType,
                  onChanged: print,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                    labelText: "อาหารที่แพ้",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )),
                ),
                //---------------------------------------------
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileViewPage()),
                          );
                        },
                        child: Text(
                          "บันทึก",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileViewPage()),
                          );
                        },
                        child: Text(
                          "ยกเลิก",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: Colors.black,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: SizedBox(
                          child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text("แกลอรี")
                        ],
                      )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: SizedBox(
                          child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                          ),
                          Text("กล้อง")
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future _pickImageFromGallery() async {
    final XFile? returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    //Navigator.of(context).pop();
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    //Navigator.of(context).pop();
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
      ),
    );
  }
}
