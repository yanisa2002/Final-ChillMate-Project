import 'package:chillmate/data/repository.dart';
import 'package:chillmate/models/recipe.dart';
import 'package:chillmate/screen/search/RecipeRecommandPage.dart';
import 'package:flutter/material.dart';

class SearchForPlan extends StatefulWidget {
  const SearchForPlan({Key? key}) : super(key: key);

  @override
  _SearchForPlanState createState() => _SearchForPlanState();
}

class _SearchForPlanState extends State<SearchForPlan> {
  List<Menu> listRecipeAll = [];

  Repository repository = Repository();

  getRecipeAll() async {
    try {
      print("Recipes---------");
      var showRecipe = await repository.getRecipeAll();
      print("oooooooooo");
      print(listRecipeAll);
      setState(() {
        listRecipeAll = showRecipe;
      });
      print(listRecipeAll);
    } catch (e) {
      print("Error fetching data Recommand Recipes: $e");
      // Handle the error accordingly
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getRecipeAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'เพิ่มอาหารเช้า',
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
      ),
      body: Expanded(
        child: listRecipeAll.length == 0
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
                itemCount: listRecipeAll.length,
                itemBuilder: (context, index) {
                  Menu RecomRecipe = listRecipeAll[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => DetailRecipePage(
                        //             recipedetail: RecomRecipe,
                        //           )),
                        // );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        tileColor: Color(0xFFFFFCED),
                        title: detailRecipe(RecomRecipe: RecomRecipe),
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
    );
  }
}
