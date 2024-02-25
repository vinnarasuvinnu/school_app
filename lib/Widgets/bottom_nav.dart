import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_application/Student/HomeS.dart';
// import 'package:flutter_application/myProfile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _list = [
  
    StudentHome(),
    //profile page
 
    
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: _list.elementAt(_selectedIndex),
      ),
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
                GButton(
                  icon: Icons.home,
                  text: 'Home',
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
