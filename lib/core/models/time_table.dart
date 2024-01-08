// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<Map<String, String>> mondayCourses = [];
List<Map<String, dynamic>> timeTable = [
  {"day": "Monday", "courses": []},
  {"day": "Tuesday", "courses": []},
  {"day": "Wednesday", "courses": []},
  {"day": "Thursday", "courses": []},
  {"day": "Friday", "courses": []},
];

class Course {
  final String? code;
  final String? title;
  final String? time;
  final String? lect;
  Course({
    this.code,
    this.title,
    this.time,
    this.lect,
  });

  Course copyWith({
    String? code,
    String? title,
    String? time,
    String? lect,
  }) {
    return Course(
      code: code ?? this.code,
      title: title ?? this.title,
      time: time ?? this.time,
      lect: lect ?? this.lect,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code': code,
      'title': title,
      'time': time,
      'lect': lect,
    };
  }

  factory Course.fromJson(Map<String, dynamic> map) {
    return Course(
      code: map['code'] as String,
      title: map['title'] as String,
      time: map['time'] as String,
      lect: map['lect'] as String,
    );
  }

  @override
  String toString() {
    return 'Course(code: $code, title: $title, time: $time, lect: $lect)';
  }
}
