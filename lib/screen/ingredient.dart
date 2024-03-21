import 'package:chillmate/data/secure_storage.dart';
import 'package:chillmate/models/fridge.dart';
import 'package:chillmate/screen/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'addIngredient/addIngredientChoice.dart';
import 'package:chillmate/screen/addIngredient/viewDetailIngredientPage.dart';

class Ingredient extends StatefulWidget {
  final String name;
  final String id;
  final List<AddIngName> ingredients;
  const Ingredient(
      {Key? key,
      required this.name,
      required this.ingredients,
      required this.id})
      : super(key: key);

  @override
  _IngredientState createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
  List<AddIngName> ingredients = [];
  List<String> tabs = [
    "ทั้งหมด",
    "เห็ดหรือเนื้อสัตว์อื่น ๆ",
    "ผัก",
    "ผลไม้",
    "เครื่องดื่ม",
    "ผลิตภัณฑ์แปรรูปจากสัตว์",
    "อื่น ๆ",
  ];
  int current = 0;

  Future<void> deleteIngredient(String idIngredient) async {
    try {
      String token = await SecureStorage().readSecureData('token');
      var headers = {'Authorization': 'Bearer ${token}'};
      print(
          'http://161.246.5.159:7504/Ingredients/remove?uudi=' + idIngredient);
      Response response = await delete(
        Uri.parse('http://161.246.5.159:7504/Ingredients/remove?uudi=' +
            idIngredient),
        headers: headers,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Complete Deleate Ingredient');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Nav()),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    ingredients = widget.ingredients;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ingredients.sort(
      (a, b) {
        return DateTime.parse(a.eXP!).compareTo(DateTime.parse(b.eXP!));
      },
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.name,
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
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "วัตถุดิบของฉัน",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 40.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                itemBuilder: (context, index) => buildCategories(index),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.2,
                        motion: BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              print("Delete");
                                              print(ingredients[index]
                                                  .addingID
                                                  .toString());
                                              deleteIngredient(
                                                  ingredients[index]
                                                      .addingID
                                                      .toString());
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
                                        title: const Text('ลบวัตถุดิบ'),
                                        contentPadding:
                                            const EdgeInsets.all(20.0),
                                        content: const Text(
                                            'ต้องการออกลบวัตถุดิบใช่หรือไม่'),
                                      ));
                            },
                            foregroundColor: Color(0xFFFE4A49),
                            icon: Icons.delete,
                            label: 'ลบ',
                          ),
                        ],
                      ),
                      child: IngredientListItem(
                        ingredient: ingredients[index],
                        fridgeName: widget.name,
                      ),
                    );
                  }),
            ),
            SizedBox(height: 12.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddIngredientChoice(
                      name: widget.name,
                      fridgeID: widget.id,
                    )),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildCategories(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          current = index;
          if (current == 0) {
            ingredients = widget.ingredients;
          } else {
            ingredients = widget.ingredients
                .where((e) => e.type == tabs[current])
                .toList();
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: current == index ? Colors.amber : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: Colors.amber),
        ),
        child: Text(
          tabs[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: current == index ? Colors.white : Colors.amber,
          ),
        ),
      ),
    );
  }
}

class IngredientListItem extends StatelessWidget {
  final String fridgeName;
  final AddIngName ingredient;

  const IngredientListItem({
    required this.fridgeName,
    required this.ingredient,
    super.key,
  });

  int diff(String exp) {
    var now = DateTime.now();
    DateTime dt1 = DateTime.parse(exp);
    Duration sub = dt1.difference(now);
    return sub.inDays + 1;
  }

  String transformDate(String? date) {
    if (date == null) return '';

    final dateStr = date.split('-');
    return '${dateStr[2]}/${dateStr[1]}/${dateStr[0]}';
  }

  Color getColor(int exp) {
    if (exp > 4) {
      return Colors.green;
    } else if (exp > 1) {
      return Color(0xFFF49D1A);
    } else if (exp == 0) {
      return Color(0xFFDC3535);
    } else {
      return Color(0xFFB01E68);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewDetailIngredientPage(
                    fridgeName: fridgeName, ingredient: ingredient)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border(
              bottom: BorderSide(
                color: getColor(
                    diff(ingredient.eXP!)), // Dynamic color based on date
                width: 1.0,
              ),
              left: BorderSide(
                color: getColor(
                    diff(ingredient.eXP!)), // Dynamic color based on date
                width: 1.0,
              ),
              top: BorderSide(
                color: getColor(
                    diff(ingredient.eXP!)), // Dynamic color based on date
                width: 1.0,
              ),
              right: BorderSide(
                color: getColor(
                    diff(ingredient.eXP!)), // Dynamic color based on date
                width: 20.0,
              ),
            ),
          ),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
      
            ),
            title: Text(
              ingredient.raw?.nameing ?? '',
          
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              "วันที่เพิ่ม : ${transformDate(ingredient.addTime)}",
              style: TextStyle(
                  color: Colors.grey[600], fontWeight: FontWeight.normal),
            ),
            trailing: Column(
              children: [
                Text(
                  '${ingredient.amount} ${ingredient.unit}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: getColor(diff(ingredient.eXP!))),
                    child: Text(
                      'EXP ${transformDate(ingredient.eXP)}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
