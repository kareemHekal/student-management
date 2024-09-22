import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Nav_Bar_Tabs/Add_student_tab.dart';
import 'Nav_Bar_Tabs/students_tab.dart';
import 'colors_app.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currant_index = 0;

  List<Widget> _bodytabs = [
    StudentsTab(),
    AddStudentTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/LoginPage', (route) => false);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.redAccent,
              size: 30,
            )),
        centerTitle: true,
        backgroundColor: app_colors.green,
        title: Image.asset(
          "assets/images/2....2.png",
          height: 100,
          width: 90,
        ),
        toolbarHeight: 120,
      ),
      body: _bodytabs[_currant_index],
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.linear,
        onTap: (index) {
          setState(() {
            _currant_index = index;
          });
        },
        backgroundColor: Colors.transparent,
        color: app_colors.green,
        animationDuration: Duration(milliseconds: 600),
        items: [
          Icon(Icons.person, color: _currant_index == 0 ? app_colors.orange : Colors.white),
          Icon(Icons.add, color: _currant_index == 1 ? app_colors.orange : Colors.white),
        ],
      ),
    );
  }
}
