import 'package:flutter/material.dart';

class Studentmodel {
  String id = "";
  String? name;
  String? grade;
  String? groupId;
  TimeOfDay? time;
  List? days;
  String? gender;

  String? phoneNumber;
  String? motherPhone;
  String? fatherPhone;
  bool? firstMonth;
  bool? secondMonth;
  bool? thirdMonth;
  bool? fourthMonth;
  bool? fifthMonth;
  bool? explainingNote;
  bool? reviewNote;

  Studentmodel(
      {this.id = "",
      this.grade,
      this.groupId,
      this.name,
      this.time,
      this.days,
      this.gender,
      this.explainingNote,
      this.reviewNote,
      this.phoneNumber,
      this.motherPhone,
      this.fatherPhone,
      this.firstMonth,
      this.secondMonth,
      this.thirdMonth,
      this.fourthMonth,
      this.fifthMonth});

  factory Studentmodel.fromJson(Map<String, dynamic> json) {
    return Studentmodel(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      groupId: json['groupId'],
      grade: json['grade'],
      fatherPhone: json['fatherphone'],
      firstMonth: json['firstmonth'],
      fourthMonth: json['fourthmonth'],
      fifthMonth:json['fifthMonth'],
      motherPhone: json['mothernumber'],
      phoneNumber: json['phonenumber'],
      secondMonth: json['secondmonth'],
      thirdMonth: json['thirdmonth'],
      explainingNote: json['explainingnote'],
      reviewNote: json['reviewnote'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gender': gender,
      'grade': grade,
      "name": name,
      'groupId': groupId,
      'fatherphone': fatherPhone,
      'firstmonth': firstMonth,
      'fourthmonth': fourthMonth,
      'fifthMonth':fifthMonth,
      'mothernumber': motherPhone,
      'phonenumber': phoneNumber,
      'secondmonth': secondMonth,
      'thirdmonth': thirdMonth,
      'explainingnote': explainingNote,
      'reviewnote': reviewNote,
    };
  }
}
