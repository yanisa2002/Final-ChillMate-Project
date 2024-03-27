import 'dart:convert';

import 'package:chillmate/data/repository.dart';
import 'package:chillmate/data/secure_storage.dart';
import 'package:chillmate/models/raw.dart';
import 'package:chillmate/models/recipe.dart';
import 'package:chillmate/pkg/constant/asset.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:chillmate/widgets/slider_view.dart';
import 'package:http/http.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double distValue = 0.0;
  List<String> _selectedIngre = [];
  List<String> _selectedType = [];

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

  Repository repository = Repository();
  List<Ingre> listRaw = [];
  List<String> itemName = [];

  getRaw() async {
    try {
      print("Add Raw---------");
      listRaw = await repository.getRaw();
      print("oooooooooo");
      print(listRaw.length);
      print(listRaw[0].nameing);
      setState(() {
        itemName =
            listRaw.map((item) => item.nameing).whereType<String>().toList();
      });
    } catch (e) {
      print("Error fetching data Raw: $e");
      // Handle the error accordingly
    }
  }

  Future<List<Menu?>?> sentFilter(
      List<String> ingredient, List<String> Type) async {
    String token = await SecureStorage().readSecureData('token');
    var headers = {'Authorization': 'Bearer ${token}'};
    print(ingredient);
    print(Type);
    try {
      Response response = await post(
          Uri.parse('${AssetConst.API_URL}recipe/filter'),
          body: {'ingredients': ingredient.join(','), 'type': Type.join(',')},
          headers: headers);

      var data = jsonDecode(response.body.toString());
      print('Filter -.');
      print(response.statusCode);
      print(data);
      if (response.statusCode == 201) {
        print("yeah!");
        List<Menu> result = List<Menu>.from(data.map((x) => Menu.fromJson(x)));

        print('result is ');
        print(result);
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getRaw();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'วัตถุดิบ',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 360
                                          ? 18
                                          : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                            )),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: DropdownSearch<String>.multiSelection(
                            popupProps: PopupPropsMultiSelection.menu(
                              showSelectedItems: true,
                            ),
                            items: itemName,
                            onChanged: (value) {
                              setState(() {
                                _selectedIngre = value;
                              });
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                              hintText: "วัตถุดิบ",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )),
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'ประเภทอาหาร',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 360
                                          ? 18
                                          : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                            )),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: DropdownSearch<String>.multiSelection(
                            popupProps: PopupPropsMultiSelection.menu(
                              showSelectedItems: true,
                            ),
                            items: InterestType,
                            onChanged: (value) {
                              setState(() {
                                _selectedType = value;
                              });
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                              hintText: "ประเภทอาหาร",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      sentFilter(_selectedIngre, _selectedType);
                    },
                    child: Center(
                      child: Text(
                        'ค้นหา',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget distanceViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'เวลาในการทำอาหาร',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.amber,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        SliderView(
          distValue: distValue,
          onChangedistValue: (double value) {
            distValue = value;
            print(distValue);
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'ตัวกรอง',
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
