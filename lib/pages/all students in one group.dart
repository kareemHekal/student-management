import 'package:flutter/material.dart';

import '../cards/StudentWidget.dart';
import '../colors_app.dart';
import '../firebase/firebase_functions.dart';
import '../loadingFile/loadingWidget.dart';
import '../models/Magmo3aModel.dart';
import 'EditStudent.dart';

class StudentInAgroup extends StatefulWidget {
  final String magmo3aId;
  Magmo3amodel magmo3aModel;

  StudentInAgroup({required this.magmo3aModel, required this.magmo3aId, super.key});

  @override
  State<StudentInAgroup> createState() => _StudentInAgroupState();
}

class _StudentInAgroupState extends State<StudentInAgroup> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: app_colors.orange),
        ),
        backgroundColor: app_colors.green,
        title: Image.asset(
          "assets/images/2....2.png",
          height: 100,
          width: 90,
        ),
        toolbarHeight: 150,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Center(child: Image.asset("assets/images/1......1.png")),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8), // Adjust as needed
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity, // Ensures the container takes the full width
                      decoration: BoxDecoration(
                        color: app_colors.green,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10), // Add some padding to prevent the field from touching edges
                        child: TextFormField(
                          style: TextStyle(color: app_colors.green),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white, // Sets the background color to white
                            hintText: 'Search',
                            hintStyle: TextStyle(color: app_colors.green),
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Adjust the internal padding of the field
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: app_colors.orange, width: 2.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: app_colors.orange, width: 2.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear, color: app_colors.orange),
                              onPressed: () {
                                _searchController.clear();
                              },
                            ),
                          ),
                          cursorColor: app_colors.green,
                          controller: _searchController,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    StreamBuilder(
                      stream: FirebaseFunctions.getMagmo3aSubdocuments(widget.magmo3aId, widget.magmo3aModel.grade ?? ""),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: DiscreteCircle(
                              color: app_colors.green,
                              size: 30,
                              secondCircleColor: app_colors.ligthGreen,
                              thirdCircleColor: app_colors.orange,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Something went wrong"),
                                ElevatedButton(onPressed: () {}, child: Text('Try again')),
                              ],
                            ),
                          );
                        }

                        var students = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

                        if (students.isEmpty) {
                          return Center(
                            child: Text(
                              "No students found",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 25, color: app_colors.black),
                            ),
                          );
                        }

                        List filteredStudents = students;

                        if (_searchController.text.isNotEmpty) {
                          filteredStudents = students.where((student) {
                            return student.name?.toLowerCase().contains(_searchController.text.toLowerCase()) ?? false;
                          }).toList();
                        }

                        return Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(height:5),
                            itemBuilder: (context, index) {
                              return StudentWidget(
                                magmo3amodel: widget.magmo3aModel,
                                magmo3aId: widget.magmo3aId,
                                studentModel: filteredStudents[index],
                              );
                            },
                            itemCount: filteredStudents.length,
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}