import 'package:chillmate/data/repository.dart';
import 'package:chillmate/models/recipe.dart';
import 'package:chillmate/screen/detailRecipePage.dart';
import 'package:chillmate/screen/filter/filterPage.dart';
import 'package:chillmate/screen/search/searchResultPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipeRecomPage extends StatefulWidget {
  const RecipeRecomPage({Key? key}) : super(key: key);

  @override
  _RecipeRecomPageState createState() => _RecipeRecomPageState();
}

class _RecipeRecomPageState extends State<RecipeRecomPage> {
  Repository repository = Repository();

  List<Menu> listRecipeRecommand = [];
  List<Menu> listRecipeAll = [];
  List<Menu>? resultToSent = [];
  String nameSearch = "";
  TextEditingController searchController = TextEditingController();

  getRecipe() async {
    try {
      print("Recipes---------");
      var showRecipe = await repository.getRecipes();
      print("oooooooooo");
      print(listRecipeRecommand);
      setState(() {
        listRecipeRecommand = showRecipe;
      });
      print(listRecipeRecommand);
    } catch (e) {
      print("Error fetching data Recommand Recipes: $e");
      // Handle the error accordingly
    }
  }

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
    getRecipeAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(
        
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              color: Colors.white,
            ),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CHILLMATE',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print("Notification"),
                    child: SvgPicture.asset(
                      "assets/icons/notifications.svg",
                      height: 32.0,
                    ),
                  ),
                ],
              ),
            ),
         
            Container(
              height: 12,
              color: Colors.white,
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          print(value);
                        },
                        onSubmitted: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultPage(
                                word: value,
                              ),
                            ),
                          );
                          
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 34.0,
                          ),
                          hintText: "ค้นหา",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FilterPage()),
                      );
                    },
           
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 15.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/filter.svg",
                        height: 34.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    
            Container(
              height: 12,
              color: Colors.white,
            ),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "แนะนำสำหรับคุณ",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
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
                              // leading: Image.network(
                              //     '${AssetConst.RECIPE_IMAGE_URL}${RecomRecipe.recipe?.image}',height: 50,width: 50,),
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
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'CHILLMATE',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/notifications.svg",
            height: 32.0,
          ),
          onPressed: () {},
        )
      ],
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
