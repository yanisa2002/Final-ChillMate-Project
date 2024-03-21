import 'package:chillmate/screen/addIngredient/editDetailIngredientPage.dart';
import 'package:flutter/material.dart';
import '../../models/fridge.dart';

class ViewDetailIngredientPage extends StatefulWidget {
  final String fridgeName;
  final AddIngName ingredient;
  const ViewDetailIngredientPage({
    required this.fridgeName,
    required this.ingredient,
    Key? key,
  }) : super(key: key);

  @override
  _ViewDetailIngredientPageState createState() =>
      _ViewDetailIngredientPageState();
}

class _ViewDetailIngredientPageState extends State<ViewDetailIngredientPage> {
  String transformSaveDate(String? date) {
    if (date == null) return '';

    final dateStr = date.split('-');
    return '${dateStr[2]}/${dateStr[1]}/${dateStr[0]}';
  }

  String transformShowDate(String? date) {
    if (date == null) return '';

    final dateStr = date.split('-');
    return '${dateStr[1]}/${dateStr[2]}/${dateStr[0]}';
  }

  @override
  Widget build(BuildContext context) {
    print(widget.fridgeName);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'รายละเอียดวัตถุดิบ',
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
            );
          },
          icon: Icon(Icons.keyboard_arrow_left),
          color: Colors.amber,
          iconSize: 40,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditDetailIngredientPage(
                          fridgeName: widget.fridgeName,
                          ingredient: widget.ingredient,
                        )),
              );
            },
            icon: Icon(Icons.edit),
            color: Colors.amber,
            iconSize: 25,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "ประเภท",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: 250,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${widget.ingredient.type}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "ชื่อ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: 250,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${widget.ingredient.raw?.nameing}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ปริมาณ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${widget.ingredient.amount}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Text(
                    "กรัม",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "วันที่บันทึก",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: 200,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${transformSaveDate(widget.ingredient.addTime)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "วันผลิต",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: 200,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${transformSaveDate(widget.ingredient.mFG)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "วันหมดอายุ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: 200,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${transformSaveDate(widget.ingredient.eXP)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "ระยะแจ้งเตือน",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${widget.ingredient.ntiPeriod}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "วัน",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "เก็บที่",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${widget.fridgeName}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
