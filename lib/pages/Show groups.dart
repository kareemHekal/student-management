import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors_app.dart';
import '../firebase/firebase_functions.dart';
import '../loadingFile/loadingWidget.dart';
import '../cards/magmo3afor display widget.dart';

class ShowGroups extends StatelessWidget {
  String? level;
   ShowGroups({ this.level,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: app_colors.orange,)),
        backgroundColor: app_colors.green,
        title: Image.asset(
          "assets/images/2....2.png",
          height: 100,
          width: 90,
        ),
        toolbarHeight: 120,
      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Center(child: Image.asset("assets/images/1......1.png")),
          ),
          Container (
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(" Just Pick the Group ",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: app_colors.green,fontSize: 30
                      ),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  StreamBuilder(
                    stream: FirebaseFunctions.getMagmo3as(level!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: DiscreteCircle(
                              color: app_colors.green,
                              size: 30,
                              secondCircleColor: app_colors.ligthGreen,
                              thirdCircleColor: app_colors.orange,
                            ));
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            children: [
                              Text("Something went wrong"),
                              ElevatedButton(onPressed: () {}, child: Text('try again'))
                            ],
                          ),
                        );
                      }
                      var Magmo3as =
                          snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                      if (Magmo3as.isEmpty) {
                        return Center(
                            child: Text(
                              " no groups ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 25,color: app_colors.black),
                            ));
                      }
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            height: 12,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.pop(context, Magmo3as[index]);
                              },
                              child: Magmo3aWidgetWithoutSlidable(
                                magmo3aModel: Magmo3as[index],
                              ),
                            );
                          },
                          itemCount: Magmo3as.length,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
