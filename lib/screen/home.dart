import 'package:chillmate/models/fridge.dart';
import 'package:chillmate/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../screen/addRefri.dart';
import '../screen/ingredient.dart';
import 'notificationPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  var formatter = DateFormat.yMMMMd('en_US');

  Repository repository = Repository();

  List<Fridge> listFridge = [];

  late Future<Fridge> fridge;

  getData() async {
    try {
      print("Fridge---------");
      listFridge = await repository.getData() as List<Fridge>;
      print("oooooooooo");
      print(listFridge);
      setState(() {});
    } catch (e) {
      print("Error fetching data fridge: $e");
      // Handle the error accordingly
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leadingWidth: 0,
        leading: SizedBox(),
        title: Text(
          'CHILLMATE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotiPage()),
                );
              },
              child: SvgPicture.asset(
                "assets/icons/notifications.svg",
                height: 32.0,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [],
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${formatter.format(now)}"),
                  SizedBox(height: 12.0),
                  Text(
                    "ตู้เย็นของฉัน",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: listFridge.length == 0
                  ? Center(
                      child: Text(
                        "ไม่พบตู้เย็น",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: listFridge.length,
                      itemBuilder: (context, index) {
                        Fridge fridge = listFridge[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ingredient(
                                          name: fridge.nameFridge ?? '',
                                          ingredients: fridge.addIngName ?? [],
                                          id: fridge.fridgeID ?? '',
                                        )),
                              );
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              tileColor: Color(0xFFFFFCED),
                              title: Text(
                                '${fridge.nameFridge}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              leading: Image.asset(
                                "assets/images/fridge.png",
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRefri()),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }
}
