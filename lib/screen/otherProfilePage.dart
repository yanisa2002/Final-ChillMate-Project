import 'package:chillmate/data/repository.dart';
import 'package:chillmate/models/userData.dart';
import 'package:chillmate/screen/recipe/createRecipe.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Repository repository = Repository();
  User? listUser;

  Future getProfile() async {
    try {
      print("Profile---------");
      var user = await repository.getProfile();
      print("oooooooooo");
      print(listUser);
      setState(() {
        listUser = user;
      });
    } catch (e) {
      print("Error fetching data Profile: $e");
      // Handle the error accordingly
    }
  }

  List<String> tabs = [
    "สูตรอาหารของฉัน",
    "บันทึกไว้",
  ];
  int current = 0;

  @override
  void initState() {
    getProfile();
    print(listUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TabController _tabController = TabController(length: 2, vsync: this);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'บัญชีผู้ใช้',
          style: TextStyle(
              color: Color(0xFFF49D1A),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Setting()),
              // );
            },
            icon: Icon(Icons.more_vert),
            color: Color(0xFFF49D1A),
            iconSize: 35,
          ),
        ],
        backgroundColor: Colors.white,
        leading: SizedBox(),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/food2.jpg'),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'ffffff',
                  // listUser?.UserName ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'fffffff',
                  //listUser!.UserName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF797979),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const FollowerPage()),
                          // );
                        },
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              //color: Colors.amber,
                              height: 40,
                              width: 160,
                              child: Text(
                                'ผู้ติดตาม',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFDC3535),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              //color: Colors.amber,
                              height: 40,
                              width: 160,
                              child: Text(
                                'ddddddddddd',
                                // "${listUser!.Followers.length}",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFFDC3535)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            //color: Colors.red,
                            height: 40,
                            width: 160,
                            child: Text(
                              'กำลังติดตาม',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFDC3535),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            //color: Colors.yellow,
                            height: 40,
                            width: 160,
                            child: Text(
                              'gggggggggg',
                              //"${listUser!.Follows.length}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFDC3535),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xFFF49D1A),
                  height: 10,
                  thickness: 3,
                  indent: 5,
                  endIndent: 5,
                ),

                // SizedBox(
                //   width: size.width,
                //   //height: size.height,
                //   child: Column(
                //     children: [
                //       Container(
                //         width: size.width,
                //         height: size.height * 0.05,
                //         color: Colors.red,
                //         child: Stack(children: [
                //           Container(
                //             width: size.width,
                //             height: size.height * 0.04,
                //             color: Colors.yellow,
                //             child: ListView.builder(
                //               scrollDirection: Axis.horizontal,
                //                 itemCount: tabs.length,
                //                 physics: BouncingScrollPhysics(),
                //                 itemBuilder: (context, index) {
                //                   return GestureDetector(
                //                     onTap: () {
                //                       setState(() {
                //                         current = index;
                //                       });
                //                     },
                //                     child: Padding(
                //                       padding: EdgeInsets.only(
                //                           left: index == 0 ? 10 : 22, top: 7),
                //                       child: Text(
                //                         tabs[index],
                //                         style: TextStyle(
                //                             fontSize:
                //                                 current == index ? 16 : 14,
                //                             fontWeight: current == index
                //                                 ? FontWeight.w500
                //                                 : FontWeight.w400,
                //                             color: current == index
                //                                 ? Colors.amber
                //                                 : Colors.white24),
                //                       ),
                //                     ),
                //                   );
                //                 }),
                //           ),
                //         ]),
                //       ),
                //     ],
                //   ),
                // ),

                // Container(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'My Recipes',
                //     style: TextStyle(
                //         fontSize: 24,
                //         color: Color(0xFF3F497F),
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40.0,
                  // height: 60.0,
                  // width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) => buildCategories(index),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   child: TabBar(
                //     //controller: _tabController,
                //     tabs: [
                //       Tab(
                //         text: "สูตรอาหารของฉัน",
                //       ),
                //       Tab(
                //         text: "บันทึกไว้",
                //       )
                //     ],
                //   ),
                // ),
                // Container(
                //   width: double.maxFinite,
                //   child: TabBarView(
                //     //controller: _tabController,
                //     children: [
                //       Text("Hi"),
                //       Text("there"),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: listUser!.postRecipes.length == 0
                      ? Center(
                          child: Text(
                            "ไม่พบสูตรอาหารที่สร้าง",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ListView.builder(
                          //itemCount: listUser!.PostRecipes.length,
                          itemBuilder: (context, index) {
                          //List<PostRecipe> userP = listUser!.PostRecipes;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => Ingredient(
                                //             name: fridge.nameFridge ?? '',
                                //             ingredients: fridge.addIngName ?? [],
                                //           )),
                                // );
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                tileColor: Color(0xFFFFFCED),
                                title: Text(
                                  'jjjjj',
                                  //userP[index].RecipeName,
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
                // ListView.builder(
                //   itemCount: listUser!.PostRecipes.length,
                //   itemBuilder: (context, index) {
                //     User userP = listUser?.PostRecipes[index];
                //   },
                //   child: Container(
                //     decoration: ShapeDecoration(
                //         color: Color(0xFFF8F5E4),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(16))),
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Row(
                //         children: [
                //           Container(
                //             width: 100,
                //             alignment: Alignment.center,
                //             child: Text('Photo'),
                //           ),
                //           Column(
                //             children: [
                //               Container(
                //                 width: 120,
                //                 // color: Colors.yellow,
                //                 child: Text(
                //                   'Name',
                //                   style: TextStyle(
                //                     fontSize: 20,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: 120,
                //                 child: Text(
                //                   'Rate',
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.normal,
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: 120,
                //                 child: Text(
                //                   'Time',
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.normal,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //           Container(
                //             alignment: Alignment.center,
                //             width: 100,
                //             // color: Colors.yellow,
                //             child: Text('next'),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 12.0,
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue, Colors.green],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateRecipe()),
                          );
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: const Center(
                          child: Text(
                            "สร้างสูตรอาหาร",
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
        margin: EdgeInsets.only(left: 30),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: current == index ? Colors.amber : Colors.white,
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
