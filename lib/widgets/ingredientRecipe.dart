import 'package:chillmate/models/recipe.dart';
import 'package:flutter/material.dart';

class IngredientRecipe extends StatelessWidget {
  final Ingredients? listdata;
  const IngredientRecipe({Key? key, this.listdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(listdata);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: ListTile(
        title: Row(
          children: [
            Text(
              '${listdata!.rawMaterial?.nameing}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Spacer(
              flex: 6,
            ),
            Text(
              '${listdata?.amount}',
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
          ],
        ),
      ),
    );
  }
}
