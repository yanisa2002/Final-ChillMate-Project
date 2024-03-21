import 'package:chillmate/models/recipe.dart';
import 'package:flutter/material.dart';

class MyRecipe extends StatelessWidget {
  final Recipe? recipes;
  const MyRecipe({Key? key, this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
  
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => DetailRecipePage()),
          // );
        },
        child: ListTile(
          contentPadding: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 1, color: Colors.amber),
          ),
          title: Text(
            recipes?.recipeName ?? '',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "แคลอรี : ${recipes?.colorie}",
            style: TextStyle(
              color: Color(0xFFB01E68),
            ),
          ),
          trailing: Text(
            "แคลอรี : ${recipes?.colorie}",
            style: TextStyle(
              color: Color(0xFFB01E68),
            ),
          ),
        ),
      ),
    );
  }
}
