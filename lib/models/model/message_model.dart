class MessageModel {
  final String? id;
  final String? message;
  final String? time;
  final bool isMe;
  final String? day;
  final String? imagePath;

  MessageModel({
    this.id,
    this.message,
    required this.time,
    required this.isMe,
    this.day,
    this.imagePath,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, String currentUserId) {
    return MessageModel(
      id: json['id']?.toString(),
      message: json['message']?.toString(),
      time: json['time']?.toString() ?? 'Now',
      isMe: json['sender_id']?.toString() == currentUserId,
      day: json['day']?.toString(),
      imagePath: json['image_path']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'time': time,
      'day': day,
      'image_path': imagePath,
    };
  }
}
