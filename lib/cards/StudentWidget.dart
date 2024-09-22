import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../colors_app.dart';
import '../models/Magmo3aModel.dart';
import '../models/StudentModel.dart';
import '../firebase/firebase_functions.dart';
import '../pages/EditStudent.dart';

class StudentWidget extends StatelessWidget {
  final Studentmodel studentModel;
  final String magmo3aId;
  final Magmo3amodel magmo3amodel;

  StudentWidget(
      {required this.studentModel,
      required this.magmo3amodel,
      required this.magmo3aId,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        extentRatio: 0.4, // Adjust width as needed
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(25),
            onPressed: (context) {
              print('Student days: ${studentModel.days}');
              _showDeleteDialog(context);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditStudentScreen(
                student: studentModel,
                group: magmo3amodel,
              );
            }));
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: app_colors.ligthGreen,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(context, "Name:", studentModel.name ?? 'N/A'),
                  _buildInfoRow(context, "Phone Number:",
                      studentModel.phoneNumber ?? 'N/A'),
                  _buildInfoRow(context, "Mother Number:",
                      studentModel.motherPhone ?? 'N/A'),
                  _buildInfoRow(context, "Father Number:",
                      studentModel.fatherPhone ?? 'N/A'),

                  _buildInfoRow(context, "Grade:", studentModel.grade ?? 'N/A'),
                  const SizedBox(height: 10),

                  // Display days from Magmo3amodel
                  _buildDaysList(),

                  // Additional data from the Magmo3amodel if needed

                  // Checking if 'days' from studentModel is not null and not empty before displaying
                  if (studentModel.days != null &&
                      studentModel.days!.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStudentDaysList(),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: app_colors.green,
            fontSize: 18,
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: app_colors.green.withOpacity(0.5),
              // Highlight (mark) color when selecting text
              cursorColor: app_colors.green, // Cursor color
            ),
          ),
          child: SelectableText(
            value,
            style: TextStyle(
              color: app_colors.orange,
              fontSize: 25,
            ),
          ),
        ),
      ],
    );
  }

  // Widget to display group days from Magmo3amodel
  Widget _buildDaysList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Group Days:",
          style: TextStyle(
            color: app_colors.green,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: magmo3amodel.days!
              .map((day) => Chip(
                    label: Text(
                      day,
                      style: TextStyle(
                        color: app_colors.orange,
                      ),
                    ),
                    backgroundColor: app_colors.green,
                  ))
              .toList(),
        ),
      ],
    );
  }

  // Widget to display student-specific days if available
  Widget _buildStudentDaysList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Student Days:",
          style: TextStyle(
            color: app_colors.green,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: studentModel.days!
              .map((day) => Chip(
                    label: Text(
                      day,
                      style: TextStyle(
                        color: app_colors.orange,
                      ),
                    ),
                    backgroundColor: app_colors.green,
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                'Warning',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                      fontSize: 30,
                    ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              )
            ],
          ),
          content: Text(
            'This will delete this student record!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.red[300],
                  fontSize: 20,
                ),
          ),
          actions: [
            ElevatedButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                      fontSize: 20,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
            ),
            ElevatedButton(
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                      fontSize: 20,
                    ),
              ),
              onPressed: () {
                // Call the delete function
                FirebaseFunctions.deleteStudent(magmo3aId, studentModel.id);
                Navigator.of(context).pop(); // close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
