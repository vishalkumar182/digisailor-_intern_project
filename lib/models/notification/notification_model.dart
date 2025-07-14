class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  final String type;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.type,
    this.isRead = false,
  });

  // Helper for immutability
  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      message: message,
      date: date,
      type: type,
      isRead: isRead ?? this.isRead,
    );
  }
}
