import 'dart:ui';

import 'package:chillmate/data/repository.dart';
import 'package:chillmate/models/recipe.dart';
import 'package:chillmate/models/saveRecipe.dart';
import 'package:chillmate/pkg/constant/asset.dart';
import 'package:chillmate/widgets/ingredientRecipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailRecipePage extends StatefulWidget {
  final Menu recipedetail;
  const DetailRecipePage({Key? key, required this.recipedetail})
      : super(key: key);

  @override
  _DetailRecipePageState createState() => _DetailRecipePageState();
}

class _DetailRecipePageState extends State<DetailRecipePage> {
  List<String> tabs = [
    "วัตถุดิบ",
    "วิธีทำ",
  ];
  int current = 0;

  late double _rating;
  double _userRating = 4;

  IconData? _selectedIcon;
  bool _isVertical = false;
  bool isSave = false;
  Repository repository = Repository();
  List<SaveRecipeList> dataSave = [];

  Future getSave() async {
    try {
      print("Profile---------");
      var recipeSave = await repository.getSaveRecipe();
      print("oooooooooo");
      print(recipeSave);
      setState(() {
        dataSave = recipeSave;
      });
    } catch (e) {
      print("Error fetching data Save: $e");
      // Handle the error accordingly
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String rateShow = widget.recipedetail.rate.toString();
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                // child: Image.network(
                //   '${AssetConst.RECIPE_IMAGE_URL}${widget.recipedetail.recipe?.image}',
                //   fit: BoxFit.cover,
                // ),
                child: Image.asset(
                  "assets/images/food1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              buttonArrow(context),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 270,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFF8F5E4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "${widget.recipedetail.recipe?.recipeName}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    radius: 100,
                    foregroundImage: NetworkImage(
                        '${AssetConst.PROFILE_IMAGE_URL}${widget.recipedetail.recipe?.image}'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(
                    "${widget.recipedetail.recipe?.usernameID?.userName}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 330,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xFFFFE15D),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.av_timer_rounded,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.recipedetail.recipe?.cookingTime}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "นาที",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      width: 2,
                      color: Colors.black,
                    ),
                    Container(
                      width: 160,
              
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_fire_department_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.recipedetail.recipe?.colorie}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "แคลอรี",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
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
            height: 20,
          ),
         
          Container(
            child: Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: showList(
                    current: current, listdata: widget.recipedetail.recipe),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buttonArrow(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      Icons.bookmark_outline,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 
  Widget UseIngredient() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              "ปริมาณที่ใช้",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "data",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Spacer(
                flex: 5,
              ),
              Text(
                "data",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                "กรัม",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Spacer(
                flex: 9,
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget Method(String detail) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Text("${detail}"),
    );
  }

  Widget Rating() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "ให้คะแนนสูตรอาหารนี้",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
              setState(() {
                _rating = rating;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildCategories(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          current = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 55),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: current == index ? Colors.amber : Colors.white,
          border: Border.all(width: 1, color: Colors.amber),
          borderRadius: BorderRadius.circular(16),
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

class showList extends StatelessWidget {
  const showList({
    super.key,
    required this.current,
    this.listdata,
  });

  final int current;
  final Recipe? listdata;

  @override
  Widget build(BuildContext context) {
    if (current == 0) {
      return ListView.builder(
        itemCount: listdata?.ingredients?.length,
        itemBuilder: (context, index) {
          return IngredientRecipe(
            listdata: listdata?.ingredients?[index],
          );
        },
      );
    } else {
      return Container(
        margin: EdgeInsets.all(20),
        child: Text("${listdata?.method}"),
      );
    }
  }
}
