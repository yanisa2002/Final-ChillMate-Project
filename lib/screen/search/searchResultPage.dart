import 'dart:convert';

import 'package:chillmate/data/secure_storage.dart';
import 'package:chillmate/models/recipe.dart';
import 'package:chillmate/screen/detailRecipePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchResultPage extends StatefulWidget {
  final String? word;
  final List<Menu>? Type;
  const SearchResultPage({Key? key, this.word, this.Type}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List<Menu>? result = [];

  Future<void> searchResult(String data) async {
    String nameSearch = data;

    String token = await SecureStorage().readSecureData('token');
    var headers = {'Authorization': 'Bearer ${token}'};
    try {
      Response response = await get(
          Uri.parse('http://161.246.5.159:7504/recipe/search?searching=' +
              nameSearch),
          headers: headers);

      var data = jsonDecode(response.body.toString());

      print('Sent Search -.');
      print(response.statusCode);
      print(data);
      if (response.statusCode == 200) {
        print("yeah! sent search");

        final responseBody = jsonDecode(response.body);
        List<Menu> data =
            List<Menu>.from(responseBody.map((x) => Menu.fromJson(x)));
        setState(() {
          result = data;
        });
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
    searchResult(widget.word!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.Type);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
        "ผลการค้นหา",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: Expanded(
        child: widget.Type?.length == 0
            ? Center(
                child: Text(
                  "ไม่พบสูตรอาหาร",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: result?.length,
                itemBuilder: (context, index) {
                  Menu RecomRecipe = result![index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailRecipePage(
                                    recipedetail: RecomRecipe,
                                  )),
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        tileColor: Color(0xFFFFFCED),
                        title: detailRecipe(RecomRecipe: RecomRecipe),
                        leading: Image.asset(
                          "assets/images/salad.png",
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}

class detailRecipe extends StatelessWidget {
  const detailRecipe({
    super.key,
    required this.RecomRecipe,
  });

  final Menu RecomRecipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '${RecomRecipe.recipe?.recipeName ?? ""}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: Colors.black,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${RecomRecipe.recipe?.cookingTime ?? ""}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              Text(
                ' นาที',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.local_fire_department_outlined,
                color: Colors.black,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${RecomRecipe.recipe?.colorie ?? ""}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              Text(
                ' แคลอรี',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
