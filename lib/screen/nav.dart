import 'package:chillmate/screen/search/RecipeRecommandPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../screen/home.dart';
import '../screen/profile.dart';
import '../screen/mealPlan.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    HomePage(),
    RecipeRecomPage(),
    MealPlan(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        color: Color(0xFFF49D1A),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: GNav(
            backgroundColor: Color(0xFFF49D1A),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color(0xFFFFE15D),
            gap: 8,
            onTabChange: (i) {
              setState(() {
                _selectedIndex = i;
              });
              print(i);
            },
            selectedIndex: _selectedIndex,
            padding: EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'หน้าหลัก',
              ),
              GButton(
                icon: Icons.search,
                text: 'ค้นหา',
              ),
              GButton(
                icon: Icons.bookmark,
                text: 'การวางแผน',
              ),
              GButton(
                icon: Icons.person,
                text: 'บัญชีผู้ใช้',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
