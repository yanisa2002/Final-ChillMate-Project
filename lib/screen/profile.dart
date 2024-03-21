import 'package:chillmate/data/repository.dart';
import 'package:chillmate/models/userData.dart';
import 'package:chillmate/pkg/constant/asset.dart';

import 'package:chillmate/screen/recipe/createRecipe.dart';

import 'package:chillmate/widgets/myRecipe.dart';
import 'package:flutter/material.dart';
import 'package:chillmate/screen/setting/setting.dart';

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
      print(listUser?.userName);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
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
      body: Container(
        // color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ProfileAvatar(userData: listUser),
                  SizedBox(height: 10),
                  ProfileName(listUser: listUser),
                  const Divider(
                    color: Color(0xFFF49D1A),
                    height: 10,
                    thickness: 3,
                    indent: 5,
                    endIndent: 5,
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
                ],
              ),
            ),
            Container(
              child: Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: showList(current: current, listUser: listUser),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateRecipe()),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
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
            border: Border.all(width: 1, color: Colors.amber)),
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
    required this.listUser,
  });

  final int current;
  final User? listUser;

  @override
  Widget build(BuildContext context) {
    if (current == 0) {
      return listUser?.postRecipes.length == 0
          ? Center(
              child: Text(
                "ไม่มีสูตรอาหารที่สร้าง",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: listUser?.postRecipes.length,
              itemBuilder: (context, index) {
                return MyRecipe(
                  recipes: listUser?.postRecipes[index],
                );
              },
            );
    } else {
      return listUser?.saves.length == 0
          ? Center(
              child: Text(
                "ไม่มีสูตรอาหารที่บันทึกไว้",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: listUser?.saves.length,
              itemBuilder: (context, index) {
                return MyRecipe(
                  recipes: listUser?.saves[index],
                );
              },
            );
    }
  }
}

class ProfileName extends StatelessWidget {
  const ProfileName({
    super.key,
    required this.listUser,
  });

  final User? listUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          listUser?.name ?? "",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          //'gggg',
          listUser?.userName ?? "",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFF797979),
          ),
        ),
      ],
    );
  }
}

class FollowerZone extends StatelessWidget {
  const FollowerZone({
    super.key,
    required this.listUser,
  });

  final User? listUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const FollowerPage()),
              // );
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
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
                  height: 40,
                  width: 160,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const FollowerPage()),
                      // );
                    },
                    child: Text(
                      "${listUser?.followers.length}",
                      style: TextStyle(fontSize: 18, color: Color(0xFFDC3535)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
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
                height: 40,
                width: 160,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const FollowingPage()),
                    // );
                  },
                  child: Text(
                    "${listUser?.follows.length}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFDC3535),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  User? userData;
  ProfileAvatar({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    print('testing');
    print(userData?.image);
    return SizedBox(
      width: 120,
      height: 120,
      child: CircleAvatar(
        radius: 100,
        backgroundImage: AssetImage('assets/images/food2.jpg'),
        foregroundImage:
            NetworkImage('${AssetConst.PROFILE_IMAGE_URL}${userData?.image}'),
      ),
    );
  }
}
