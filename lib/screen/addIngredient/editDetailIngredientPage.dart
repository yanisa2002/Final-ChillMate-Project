import 'dart:convert';
import 'package:chillmate/data/repository.dart';
import 'package:chillmate/data/secure_storage.dart';
import 'package:chillmate/models/raw.dart';
import 'package:chillmate/screen/nav.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../models/fridge.dart';

class EditDetailIngredientPage extends StatefulWidget {
  final String fridgeName;
  final AddIngName? ingredient;
  const EditDetailIngredientPage({
    required this.fridgeName,
    this.ingredient,
    Key? key,
  }) : super(key: key);

  @override
  _EditDetailIngredientPageState createState() =>
      _EditDetailIngredientPageState();
}

class _EditDetailIngredientPageState extends State<EditDetailIngredientPage> {
  final dataKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  final amountController = TextEditingController();
  final pdateController = TextEditingController();
  final expController = TextEditingController();

  String mfg = "";
  String exp = "";
  String mfgEdit = "";
  String expEdit = "";

  List<String> nameItems = <String>[];

  List<String> listCatagory = [
    "เห็ดหรือเนื้อสัตว์อื่น ๆ",
    "ผัก",
    "ผลไม้",
    "เครื่องดื่ม",
    "ผลิตภัณฑ์แปรรูปจากสัตว์",
    "อื่น ๆ",
  ];
  List<String> listType = ['หมู', 'ไก่', 'ปลา', 'เนื้อวัว', 'อื่นๆ'];
  List<String> listNoti = ['1', '2', '3', '4', '5', '6', '7'];
  List<Ingre> listRaw = [];
  String? _selectedCata;
  String? _selectedNoti;

  var now = DateTime.now();
  var formatter = DateFormat("dd/MM/yyyy");


  String transformShowDate(String? date) {
    if (date == null) return '';

    final dateStr = date.split('-');
    return '${dateStr[2]}/${dateStr[1]}/${dateStr[0]}';
  }

  String transformtoSentDate(String? date) {
    if (date == null) return '';

    final dateStr = date.split('-');
    return '${dateStr[1]}/${dateStr[2]}/${dateStr[0]}';
  }

  void editIngredient(
    String? uuid,
    String type,
    String nameing,
    String amount,
    String unit,
    String mfg,
    String exp,
    String noti,
  ) async {
    try {
      print(uuid);
      print(type);
      print(nameing);
      print(amount);
      print(unit);
      print(mfg);
      print(exp);
      print(noti);
      String token = await SecureStorage().readSecureData('token');
      print("------Edit Ingredient------");
      var headers = {'Authorization': 'Bearer ${token}'};
      Response response =
          await post(Uri.parse('http://161.246.5.159:7504/Ingredients/edit'),
              body: {
                'uudiIngredients': uuid,
                'type': type,
                'nameing': nameing,
                'amount': amount,
                'Unit': unit,
                'MFG': mfg,
                'EXP': exp,
                'ntPeriod': noti,
              },
              headers: headers);

      var data = jsonDecode(response.body.toString());
      print('Edit Ingredient -.');
      print(response.statusCode);
      print(data);
      if (response.statusCode == 201) {
        print("yeah!");
        print("edit complete");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Nav()),
        );
      } else {
        print('failed');

      }
    } catch (e) {
      print(e.toString());
    }
  }

  Repository repository = Repository();

  getRaw() async {
    try {
      print("Add Raw---------");
      listRaw = await repository.getRaw();
      print("oooooooooo");
      print(listRaw.length);
      print(listRaw[0].nameing);
    } catch (e) {
      print("Error fetching data Raw: $e");
      // Handle the error accordingly
    }
  }

  @override
  void initState() {
    getRaw();
    final ingredient = widget.ingredient;
    if (ingredient != null) {
      _selectedCata = ingredient.type;
      nameController.text = ingredient.raw!.nameing.toString();
      amountController.text = ingredient.amount.toString();
      pdateController.text = transformShowDate(ingredient.mFG ?? '');
      expController.text = transformShowDate(ingredient.eXP ?? '');
      _selectedNoti = ingredient.ntiPeriod.toString();
      mfg = transformtoSentDate(ingredient.mFG.toString());
      exp = transformtoSentDate(ingredient.eXP.toString());
    }
    //TODO Get Raw in Nameitems
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
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
              editIngredient(
                  widget.ingredient?.addingID,
                  _selectedCata!,
                  nameController.text,
                  amountController.text,
                  "กรัม",
                  mfg,
                  exp,
                  _selectedNoti!);
             
            },
            icon: Icon(Icons.done),
            color: Colors.green,
            iconSize: 40,
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
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  SizedBox(
                    width: 240,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 2, color: Colors.black),
                      )),
                      items: listCatagory
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                 
                                  style: TextStyle(fontSize: 18),
                                ),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => _selectedCata = item),
                      hint: Text(
                        "เลือกประเภท",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      value: _selectedCata,
                    ),
                  )
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
                  SizedBox(
                    width: 75,
                  ),
                  SizedBox(
                    width: 240,
                    child: Autocomplete<Ingre>(
                      optionsBuilder: (TextEditingValue value) {
                        if (value.text.isEmpty) {
                          return List.empty();
                        }
                        return listRaw
                            .where((element) => element.nameing!
                                .toLowerCase()
                                .contains(value.text.toLowerCase()))
                            .toList();
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController controller,
                          FocusNode node,
                          Function onSubmit) {
                        controller.text = nameController.text;
                        return TextField(
                          // controller: nameController,
                          controller: controller,
                          focusNode: node,
                          decoration:
                              InputDecoration(hintText: 'ชื่อวัตถุดิบ...'),
                    
                        );
                      },
                      displayStringForOption: (Ingre option) => option.nameing!,
                      onSelected: (option) {
                        setState(() {
                          nameController.text = option.nameing.toString();
                        });
                      },
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
           
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Amount',
                    
                        fillColor: Colors.white,
                        filled: true,
                      ),
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
                  SizedBox(
                    width: 35,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      "${transformShowDate(widget.ingredient?.addTime)}",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
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
                  SizedBox(
                    width: 35,
                  ),
                  SizedBox(
                    width: 240,
                    child: TextFormField(
                      controller: pdateController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final DateTime? _date = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100).add(Duration(days: 365)),
                            );
                            final _onlyDate =
                                DateFormat("MM/dd/yyyy").format(_date!);
                            print(_onlyDate);
                            final _formattedDate =
                                DateFormat("dd/MM/yyyy").format(_date);
                            print(_formattedDate);
                            setState(() {
                              pdateController.text = _formattedDate;
                              mfg = _onlyDate;
                              print('mfg ${mfg}');
                            });
                          },
                          icon: Icon(Icons.calendar_month),
                        ),
                        hintText: 'เลือกวันผลิต',
                        //label: Text('Name'),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  )
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
                  SizedBox(
                    width: 35,
                  ),
                  SizedBox(
                    width: 210,
                    child: TextFormField(
                      controller: expController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final DateTime? _expdate = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: now,
                              lastDate: DateTime(2100).add(Duration(days: 365)),
                            );
                            final _onlyexpDate =
                                DateFormat("MM/dd/yyyy").format(_expdate!);
                            print(_onlyexpDate);
                            final _formattedexpDate =
                                DateFormat("dd/MM/yyyy").format(_expdate);
                            print(_formattedexpDate);
                            setState(() {
                              expController.text = _formattedexpDate.toString();
                              exp = _onlyexpDate;
                            });
                          },
                          icon: Icon(Icons.calendar_month),
                        ),
                        hintText: 'เลือกวันหมดอายุ',
                        //label: Text('Name'),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  )
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
                  SizedBox(
                    width: 150,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 2, color: Colors.black),
                      )),
                      items: listNoti
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => _selectedNoti = item),
                      hint: Text(
                        "เลือก",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      value: _selectedNoti,
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
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.fridgeName,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
