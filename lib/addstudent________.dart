import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors_app.dart';
import 'firebase/firebase_functions.dart';
import 'models/Magmo3aModel.dart';
import 'models/StudentModel.dart';
import 'pages/Show groups.dart';
import 'loadingFile/loadingWidget.dart';
import 'cards/magmo3afor display widget.dart';

class AddStudentTab_ extends StatefulWidget {
  String? level;
  Magmo3amodel? group;

  AddStudentTab_({this.level, super.key, this.group});

  @override
  State<AddStudentTab_> createState() => _AddStudentTabState();
}

class _AddStudentTabState extends State<AddStudentTab_> {
  _AddStudentTabState();

  String? _selectedGender;
  bool? _secondMonth;
  bool? _firstMonth;
  bool? _thirdMonth;
  bool? _fourthMonth;
  bool? _fifthMonth;
  bool? _explainingNote;
  bool? _reviewNote;
  TextEditingController name_controller = TextEditingController();
  TextEditingController studentNumberController = TextEditingController();
  TextEditingController fatherNumberController = TextEditingController();
  TextEditingController motherNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 17),
        child: Container(
          decoration: BoxDecoration(
            color: app_colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          width: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 0),
                            child: Text(
                              textAlign: TextAlign.start,
                              '''  A D D
  Y O U R  S T U D E N T S''',
                              style: GoogleFonts.oswald(
                                fontSize: 30,
                                color: app_colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Divider(
                        color: app_colors.orange,
                        thickness: 4,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(" Pick the group "),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: app_colors.orange, width: 1),
                                  foregroundColor: app_colors.orange,
                                  backgroundColor: app_colors.green, // text color
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShowGroups(level: widget.level),
                                    ),
                                  ).then((result) {
                                    if (result != null) {
                                      setState(() {
                                        // Assuming 'result' is the group returned from the second screen
                                        widget.group = result;  // Update widget.group with the returned group
                                      });
                                      print('Received Group ID: ${result.id}');
                                    }
                                  });
                                },
                                child: Text(" Pick "),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        child: widget.group!= null? Magmo3aWidgetWithoutSlidable(magmo3aModel: widget.group,):Center(child: Text("please pick a group")),
                      ),
                      Divider(
                        color: app_colors.orange,
                        thickness: 4,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: name_controller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: " Student Name ",
                          labelStyle:
                              TextStyle(fontSize: 25, color: app_colors.orange),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: app_colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: app_colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: studentNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your student number';
                          }
                          // You can add additional validation for student number format if needed
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Student Number",
                          labelStyle:
                              TextStyle(fontSize: 25, color: app_colors.orange),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: app_colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: app_colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        // to allow only numbers
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ], // to allow only digits
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: fatherNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your father\'s number';
                          }
                          // You can add additional validation for phone number format if needed
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Father's Number",
                          labelStyle:
                              TextStyle(fontSize: 25, color: app_colors.orange),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: app_colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: app_colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        // to allow phone number input
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ], // to allow only digits
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: motherNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mother\'s number';
                          }
                          // You can add additional validation for phone number format if needed
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Mother's Number",
                          labelStyle:
                              TextStyle(fontSize: 25, color: app_colors.orange),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: app_colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: app_colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        // to allow phone number input
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ], // to allow only digits
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: app_colors.orange,
                        thickness: 4,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: app_colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            dropdownColor: app_colors.green,
                            value: _selectedGender ?? "Male",
                            // Set the default value to "Male"
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(
                                child: Text("Male",
                                    style: TextStyle(color: app_colors.orange)),
                                value: "Male",
                              ),
                              DropdownMenuItem(
                                child: Text("Female",
                                    style: TextStyle(color: app_colors.orange)),
                                value: "Female",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value as String;
                              });
                            },
                            elevation: 8,
                            style: TextStyle(color: app_colors.orange),
                            icon: Icon(Icons.arrow_forward_ios_outlined,
                                color: app_colors.orange),
                            iconSize: 24,
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                _selectedGender ?? "Select a gender",
                                style: TextStyle(color: app_colors.orange),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      _selectedGender != null
                          ? Wrap(
                              direction: Axis.horizontal,
                              spacing: 8,
                              children: [
                                Chip(
                                  backgroundColor: app_colors.green,
                                  label: Text(_selectedGender!,
                                      style:
                                          TextStyle(color: app_colors.orange)),
                                  deleteIcon: Icon(Icons.cancel,
                                      size: 20, color: app_colors.orange),
                                  shape: StadiumBorder(
                                      side:
                                          BorderSide(color: app_colors.orange)),
                                  onDeleted: () {
                                    setState(() {
                                      _selectedGender = null;
                                    });
                                  },
                                ),
                              ],
                            )
                          : Center(
                              child: Text("Select a gender",
                                  style: TextStyle(color: app_colors.orange)),
                            ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: app_colors.orange,
                        thickness: 4,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("First Month :"),
                                      buildDropdown("First Month", _firstMonth, (value) {
                                        setState(() {
                                          _firstMonth = value;
                                        });
                                      }),
                                    ],
                                  ),
                                  SizedBox(width: 16.0),
                                  Column(
                                    children: [
                                      Text("Second Month :"),
                                      buildDropdown("Second Month", _secondMonth, (value) {
                                        setState(() {
                                          _secondMonth = value;
                                        });
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Third Month :"),
                                      buildDropdown("Third Month", _thirdMonth, (value) {
                                        setState(() {
                                          _thirdMonth = value;
                                        });
                                      }),
                                    ],
                                  ),
                                  SizedBox(width: 16.0),
                                  Column(
                                    children: [
                                      Text("Fourth Month :"),
                                      buildDropdown("Fourth Month", _fourthMonth, (value) {
                                        setState(() {
                                          _fourthMonth = value;
                                        });
                                      }),
                                    ],
                                  ),
                                ],
                              ),Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Fifth Month :"),
                                      buildDropdown("Fifth Month", _fifthMonth, (value) {
                                        setState(() {
                                          _fifthMonth = value;
                                        });
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Explaining Note :"),
                                      buildDropdown("Explaining Note", _explainingNote, (value) {
                                        setState(() {
                                          _explainingNote = value;
                                        });
                                      }),
                                    ],
                                  ),
                                  SizedBox(width: 16.0),
                                  Column(
                                    children: [
                                      Text("Reviewing Note :"),
                                      buildDropdown("Review Note", _reviewNote, (value) {
                                        setState(() {
                                          _reviewNote = value;
                                        });
                                      }),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        )

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: app_colors.orange,
                                backgroundColor: app_colors.green, // text color
                              ),
                              onPressed: () {
                                if (widget.group==null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text(
                                            'Please pick a group')),
                                  );
                                  return;
                                }
                                // Check if all the form fields are filled
                                if (name_controller.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text(
                                            'Please enter the student\'s name')),
                                  );
                                  return;
                                }
                                if (studentNumberController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Please enter the student number'),
                                    ),
                                  );
                                  return;
                                }

// Validate that student number is exactly 11 digits
                                if (!RegExp(r'^\d{11}$').hasMatch(studentNumberController.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Student number must be exactly 11 digits'),
                                    ),
                                  );
                                  return;
                                }

                                if (fatherNumberController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Please enter the father\'s number'),
                                    ),
                                  );
                                  return;
                                }

// Validate that father's number is exactly 11 digits
                                if (!RegExp(r'^\d{11}$').hasMatch(fatherNumberController.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Father\'s number must be exactly 11 digits'),
                                    ),
                                  );
                                  return;
                                }

                                if (motherNumberController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Please enter the mother\'s number'),
                                    ),
                                  );
                                  return;
                                }

// Validate that mother's number is exactly 11 digits
                                if (!RegExp(r'^\d{11}$').hasMatch(motherNumberController.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Mother\'s number must be exactly 11 digits'),
                                    ),
                                  );
                                  return;
                                }

                                if (_selectedGender == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content:
                                            Text('Please select a gender')),
                                  );
                                  return;
                                }
                                if (_firstMonth == null ||
                                    _secondMonth == null ||
                                    _thirdMonth == null ||
                                      _fifthMonth == null ||
                                    _fourthMonth == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text(
                                            'Please select payment status for all months')),
                                  );
                                  return;
                                }
                                if (_explainingNote == null ||
                                    _reviewNote == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text(
                                            'Please select notes for explaining and reviewing')),
                                  );
                                  return;
                                }

                                // If all validations pass, proceed with your logic here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.green,
                                      content:
                                          Text('Student added successfully!')),
                                );
                                Magmo3amodel? updatedGroup = widget.group;
                                Studentmodel submodel = Studentmodel(
                                  days: updatedGroup?.days ,
                                  time: updatedGroup?.time ,
                                  name: name_controller.text,
                                  gender: _selectedGender,
                                  groupId: widget.group?.id,
                                  grade: widget.level,
                                  firstMonth: _firstMonth,
                                  secondMonth: _secondMonth,
                                  thirdMonth: _thirdMonth,
                                  fourthMonth: _firstMonth,
                                  fifthMonth: _fifthMonth,
                                  explainingNote: _explainingNote,
                                  reviewNote: _reviewNote,
                                  phoneNumber: studentNumberController.text,
                                  motherPhone: motherNumberController.text,
                                  fatherPhone: fatherNumberController.text,
                                );
                                FirebaseFunctions.addStudent(
                                    widget.group!.id, submodel);


                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/HomeScreen',
                                  (route) => false,
                                );
                              },
                              child: Text(" Add "),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildDropdown(
      String hint,
      bool? selectedValue,
      ValueChanged<bool?> onChanged,
      ) {
    return SizedBox(
      width: 200, // specify a width
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: app_colors.green, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<bool>(
          dropdownColor: app_colors.green,
          value: selectedValue,
          isExpanded: true,
          items: [
            DropdownMenuItem(
              child: Text("Paid", style: TextStyle(color: Colors.orange)),
              value: true,
            ),
            DropdownMenuItem(
              child: Text("Not Paid", style: TextStyle(color: Colors.orange)),
              value: false,
            ),
          ],
          onChanged: onChanged,
          elevation: 8,
          style: TextStyle(color: Colors.orange),
          icon: Icon(Icons.arrow_forward_ios_outlined, color: Colors.orange),
          iconSize: 24,
          hint: Text(
            selectedValue == null ? hint : (selectedValue ? "Paid" : "Not Paid"),
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
    );
  }
  }

