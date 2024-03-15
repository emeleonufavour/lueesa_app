// ignore_for_file: public_member_api_docs, sort_constructors_first

class InfoBox {
  String from;
  String to;
  String message;
  String? userId;
  String time;
  InfoBox({
    required this.from,
    required this.to,
    required this.message,
    this.userId,
    required this.time,
  });

  InfoBox copyWith({
    String? from,
    String? to,
    String? message,
    String? userId,
    String? time,
  }) {
    return InfoBox(
      from: from ?? this.from,
      to: to ?? this.to,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'message': message,
      'userId': userId,
      'time': time,
    };
  }

  factory InfoBox.fromJson(Map<String, dynamic> map) {
    return InfoBox(
        from: map['from'] as String,
        to: map['to'] as String,
        message: map['message'] as String,
        userId: map['userId'] as String,
        time: map['time'] as String);
  }

  @override
  String toString() =>
      'InfoBox(from: $from, to: $to, message: $message, userId: $userId, time: $time)';
}
