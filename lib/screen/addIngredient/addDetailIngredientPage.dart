import 'dart:convert';
import 'package:chillmate/data/repository.dart';
import 'package:chillmate/data/secure_storage.dart';
import 'package:chillmate/models/raw.dart';
import 'package:chillmate/pkg/constant/asset.dart';
import 'package:chillmate/screen/nav.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class AddDetailIngredientPage extends StatefulWidget {
  final String fridgeName;
  final String uuID;
  const AddDetailIngredientPage({
    required this.fridgeName,
    required this.uuID,
    Key? key,
  }) : super(key: key);

  @override
  _AddDetailIngredientPageState createState() =>
      _AddDetailIngredientPageState();
}

class _AddDetailIngredientPageState extends State<AddDetailIngredientPage> {
  final dataKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final pdateController = TextEditingController();
  final expController = TextEditingController();

  String nameRaw = "";
  String mfg = "";
  String exp = "";
  String img = "";

  List<String> selectedName = [];
  List<String> itemName = [];

  List<Ingre> listRaw = [];

  List<String> listCatagory = [
    "เห็ดหรือเนื้อสัตว์อื่น ๆ",
    "ผัก",
    "ผลไม้",
    "เครื่องดื่ม",
    "ผลิตภัณฑ์แปรรูปจากสัตว์",
    "อื่น ๆ",
  ];
  List<String> listNoti = ['1', '2', '3', '4', '5', '6', '7'];
  String? _selectedCata;
  String? _selectedNoti;

  var now = DateTime.now();
  var formatter = DateFormat("dd/MM/yyyy");

  void addIngredient(
    String uuid,
    String type,
    String nameing,
    String amount,
    String unit,
    String mfg,
    String exp,
    String noti,
    String img,
  ) async {
    try {
      print(uuid);
      print(type);
      print(nameing);
      print('Amount before parsing: $amount');
      print(unit);
      print(mfg);
      print(exp);
      print('Noti before parsing: $noti');
      print(img);
      String token = await SecureStorage().readSecureData('token');
      print("Recipeeeee");
      var headers = {'Authorization': 'Bearer ${token}'};
      Response response =
          await post(Uri.parse('${AssetConst.API_URL}Ingredients/add'),
              body: {
                'uudifridge': uuid,
                'type': type,
                'nameing': nameing,
                'amount': amount,
                'Unit': unit,
                'MFG': mfg,
                'EXP': exp,
                'ntPeriod': noti,
                'img_path': img,
              },
              headers: headers);

      var data = jsonDecode(response.body.toString());
      //print(data['access_token']);
      print('Add Manual Ingredient -.');
      print(response.statusCode);
      print(data);
      if (response.statusCode == 201) {
        print("yeah!");
        print("add complete");
        //print(data['access_token']);

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
    }
  }

  @override
  void initState() {
    getRaw();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              addIngredient(
                  widget.uuID,
                  _selectedCata!,
                  nameRaw,
                  amountController.text.toString(),
                  "กรัม",
                  mfg,
                  exp,
                  _selectedNoti!,
                  img);
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
                    width: 70,
                  ),
                  Container(
                    width: 240,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2)),
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
                              Function onSubmit) =>
                          TextField(
                        controller: controller,
                        focusNode: node,
                        decoration:
                            InputDecoration(hintText: 'ชื่อวัตถุดิบ...'),
                      ),
                      displayStringForOption: (Ingre option) => option.nameing!,
                      onSelected: (option) {
                        setState(() {
                          nameRaw = option.nameing.toString();
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
                        //label: Text('Name'),
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
                      "${formatter.format(now)}",
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
                            final _date = await pickDateMFG(context);
                            if (_date == null) return; //Cancel Button
                            print(_date);
                            final _onlyDate =
                                DateFormat("MM/dd/yyyy").format(_date);
                            print(_onlyDate);
                            final _formattedDate =
                                DateFormat("dd/MM/yyyy").format(_date);
                            print(_formattedDate);
                            setState(() {
                              pdateController.text = _formattedDate;
                              mfg = _onlyDate;
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
                            final _expdate = await pickDateEXP(context);
                            if (_expdate == null) return; //Cancel Button
                            print(_expdate);
                            final _onlyDate =
                                DateFormat("MM/dd/yyyy").format(_expdate);
                            print(_onlyDate);
                            final _formattedexpDate =
                                DateFormat("dd/MM/yyyy").format(_expdate);
                            print(_formattedexpDate);
                            setState(() {
                              expController.text = _formattedexpDate;
                              exp = _onlyDate;
                            });
                          },
                          icon: Icon(Icons.calendar_month),
                        ),
                        hintText: 'เลือกวันหมดอายุ',
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

  Future<DateTime?> pickDateEXP(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100).add(Duration(days: 365)),
    );
  }

  Future<DateTime?> pickDateMFG(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100).add(Duration(days: 365)),
    );
  }
}
