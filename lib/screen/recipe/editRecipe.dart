import 'package:chillmate/widgets/recipe_form.dart';

import 'package:flutter/material.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({Key? key}) : super(key: key);

  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  List<String> listFoodCatagory = [
    'ผัก',
    'ผลไม้',
    'เนื้อ',
    'เครื่องดื่ม',
    'ผลิตภัณฑ์จากสัตว์',
    'อื่นๆ'
  ];

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
  List<String> selectedInterestType = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'สร้างสูตรอาหาร',
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
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            RecipeForm(),
          ],
        ),
      ),
    );
  }
}
