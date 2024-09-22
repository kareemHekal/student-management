

import 'package:flutter/material.dart';

import '../Appbar_TAbs/1 S.dart';
import '../Appbar_TAbs/2 S.dart';
import '../Appbar_TAbs/3 S.dart';
import '../colors_app.dart';



class StudentsTab extends StatelessWidget {
  const StudentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Center(child: Image.asset("assets/images/1......1.png")),
      ),
      SizedBox(height: 50),
      DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                color: app_colors.green,
                child:  TabBar(
                  labelColor: app_colors.orange,
                  indicatorColor: app_colors.orange,
                  indicatorWeight: 5,
                  indicatorSize:TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.white,
                  tabs:const [
                    Tab(
                      child: Text(" 1 S"),
                    ),
                    Tab(
                      child: Text(" 2 S"),
                    ),
                    Tab(
                      child: Text(" 3 S"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  FirstS(),
                  SecondS(),
                  ThirdS(),
                ]),
              )
            ],
          ),
        ),
      ),
    ],
    );
  }
}