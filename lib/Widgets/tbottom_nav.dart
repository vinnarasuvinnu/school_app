import 'package:flutter/material.dart';
import 'package:flutter_application/Teacher/create.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:flutter_application/myProfile.dart';

class TBottomNav extends StatefulWidget {
  const TBottomNav({super.key});

  @override
  State<TBottomNav> createState() => _TBottomNavState();
}

class _TBottomNavState extends State<TBottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _list = [

    //teavher specific home page
    tcreate(),

   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Visibility(
        child: Container(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GNav(
              backgroundColor: Colors.grey,
              padding: const EdgeInsets.all(16),
              tabBackgroundColor: Colors.white,
              gap: 8,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [

                /* GButton(
                  icon: Icons.home,
                  text: 'home',
                ),*/
           
                GButton(
                  icon: Icons.add,
                  text: 'Class',
                ),
             
               /* GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
