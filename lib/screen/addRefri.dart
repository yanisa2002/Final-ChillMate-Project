import 'package:chillmate/data/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../screen/nav.dart';

class AddRefri extends StatefulWidget {
  const AddRefri({Key? key}) : super(key: key);

  @override
  _AddRefriState createState() => _AddRefriState();
}

class _AddRefriState extends State<AddRefri> {
  final _nameFridgeController = TextEditingController();

  @override
  void AddFridge(String Namefridge) async {
    String token = await SecureStorage().readSecureData('token');
    try {
      Response response = await post(
          Uri.parse('http://161.246.5.159:7504/Fridge/create'),
          headers: {'Authorization': 'Bearer ${token}'},
          body: {'name': Namefridge});
      print(token);
      if (response.statusCode == 201) {
        print("yeah, Add Fridge");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Nav()),
        );
      } else {
        print('failed');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'เพิ่มตู้เย็น',
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
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ชื่อตู้เย็น : ",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _nameFridgeController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.amber,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Name',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 50.0),
              Center(
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        print("Add Refri");
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const Nav()),
                        // );
                        AddFridge(_nameFridgeController.text.toString());
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: const Center(
                        child: Text(
                          "บันทึก",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
