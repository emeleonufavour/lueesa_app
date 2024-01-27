// ignore_for_file: public_member_api_docs, sort_constructors_first

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
      'lect': lect,
      'time': time,
      'title': title,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'title': title,
      'time': time,
      'lect': lect,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      code: map['code'] != null ? map['code'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      lect: map['lect'] != null ? map['lect'] as String : null,
    );
  }

  @override
  bool operator ==(covariant Course other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.title == title &&
        other.time == time &&
        other.lect == lect;
  }

  @override
  int get hashCode {
    return code.hashCode ^ title.hashCode ^ time.hashCode ^ lect.hashCode;
  }
}
