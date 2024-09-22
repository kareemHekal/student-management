import 'package:flutter/material.dart';

import 'BottomSheets/add_magmo3a.dart';
import 'models/Magmo3aModel.dart';
import 'cards/Magmo3aWidget.dart';
import 'colors_app.dart';
import 'firebase/firebase_functions.dart';
import 'loadingFile/loadingWidget.dart';

class Magmo3as extends StatelessWidget {
  String level;

  Magmo3as({required this.level, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // the add icon
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: app_colors.green,
                    borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddMagmo3a(),
                            ));
                  },
                  icon: Icon(Icons.add),
                  color: app_colors.orange,
                  iconSize: 30,
                ),
              ),
            )
          ],
        ),
        Container(
          child: StreamBuilder(
            stream: FirebaseFunctions.getMagmo3as(level),
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
                    return Magmo3aWidget(
                       magmo3aModel: Magmo3as[index],
                    );
                  },
                  itemCount: Magmo3as.length,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
