//--------------Not Used-----------------------

import 'dart:ui';

import 'package:flutter/material.dart';

class DetailRecipe extends StatefulWidget {
  const DetailRecipe({Key? key}) : super(key: key);

  @override
  _DetailRecipeState createState() => _DetailRecipeState();
}

  class _DetailRecipeState extends State<DetailRecipe> {
  List<String> tabs = [
    "วัตถุดิบ",
    "วิธีทำ",
    "คะแนน",
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/food1.jpg",
                fit: BoxFit.cover,
              ),
            ),
            buttonArrow(context),
            scroll(tabs),
          ],
        ),
      ),
    );
  }
}

buttonArrow(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
            ],
          ),
        ),
      ),
    ),
  );
}

scroll(List tabs) {
  return DraggableScrollableSheet(
    initialChildSize: 0.6,
    maxChildSize: 1.0,
    minChildSize: 0.6,
    builder: (context, scrollController) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 35,
                      color: Colors.black12,
                    )
                  ],
                ),
              ),
              Text(
                "Cacao",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Food .60 min",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Color(0xFF9FA5C0)),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) =>
                    //             ProfileTap(showFollowBottomInProfile: true),
                    //       ));
                    // },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/images/food2.jpg"),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Elena Shelby",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Color(0xFF2E3E5C)),
                  ),
                  const Spacer(),
                  // const CircleAvatar(
                  //   radius: 25,
                  //   backgroundColor: Color(0xFF1FCC79),
                  //   child: Icon(
                  //     IconlyLight.heart,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "273 การบันทึก",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Color(0xFF2E3E5C)),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  height: 4,
                ),
              ),
              Text(
                "Description",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Color(0xFF9FA5C0)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  height: 4,
                ),
              ),
              // SizedBox(
              //     height: 40.0,
              //     // height: 60.0,
              //     // width: double.infinity,
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: tabs.length,
              //       itemBuilder: (context, index) => buildCategories(index),
              //     ),
              //   ),
              Text(
                "Ingredients",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "สัดส่วนที่ใช้",
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) => ingredients(context),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  height: 4,
                ),
              ),
              Text(
                "Steps",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) => steps(context, index),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// buildCategories(int index,current) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           current = index;
//         });
//       },
//       child: Container(
//         alignment: Alignment.center,
//         margin: EdgeInsets.only(left: 30),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 5,
//         ),
//         decoration: BoxDecoration(
//           color: current == index ? Colors.amber : Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Text(
//           tabs[index],
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: current == index ? Colors.white : Colors.amber,
//           ),
//         ),
//       ),
//     );
//   }

ingredients(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        const CircleAvatar(
          radius: 10,
          backgroundColor: Color(0xFFE3FFF8),
          child: Icon(
            Icons.done,
            size: 15,
            color: Color(0xFF1FCC79),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "4 Eggs",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          width: 50,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: TextField(
        //     decoration: InputDecoration(
        //       //fillColor: Colors.grey,
        //       border: OutlineInputBorder(),
        //       hintText: 'Enter a search term',
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}

steps(BuildContext context, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          backgroundColor: Color(0xFF2E3E5C),
          radius: 12,
          // child: Text("test"),
          child: Text("${index + 1}"),
        ),
        Column(
          children: [
            SizedBox(
              width: 270,
              child: Text(
                "Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your",
                maxLines: 3,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Color(0xFF2E3E5C)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/images/food3.jpg",
              height: 155,
              width: 270,
            )
          ],
        )
      ],
    ),
  );
}
