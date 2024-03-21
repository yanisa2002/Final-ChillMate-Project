import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'ingredients_section.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({Key? key}) : super(key: key);

  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  Uint8List? _image;
  File? selectedImage;
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _pickImageFromGallery();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              dashPattern: [10, 4],
              strokeCap: StrokeCap.round,
              color: Colors.grey.shade400,
              child: Stack(
                children: [
                  _image != null
                      ? Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50.withOpacity(.3),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(_image!),
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50.withOpacity(.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.folder_open,
                                color: Colors.grey,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'เลือกรูปอาหาร',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Container(
                alignment: FractionalOffset.centerLeft,
                child: Text(
                  "ชื่อสูตรอาหาร",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 350,
                height: 50,
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Name',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Expanded(
            child: Column(
              children: [
                Container(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    "เวลา",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 350,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Time',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 10,
          ),
          child: Column(
            children: [
              Container(
                alignment: FractionalOffset.centerLeft,
                child: Text(
                  "ประเภทอาหาร",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: DropdownSearch<String>.multiSelection(
                  popupProps: PopupPropsMultiSelection.menu(
                    showSelectedItems: true,
                  ),
                  items: InterestType,
                  onChanged: print,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Container(
                alignment: FractionalOffset.centerLeft,
                child: Text(
                  "วัตถุดิบ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              IngredientsSection(),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Container(
                alignment: FractionalOffset.centerLeft,
                child: Text(
                  "วิธีทำ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future _pickImageFromGallery() async {
    final XFile? returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
      print(selectedImage);
    });
  }
}
