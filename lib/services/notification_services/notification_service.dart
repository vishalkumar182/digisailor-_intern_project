import 'package:construction_manager_app/models/notification/notification_model.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  List<NotificationModel> _notifications = [];
  final List<Function()> _listeners = [];

  NotificationService._internal() {
    _initializeDummyData();
  }

  void _initializeDummyData() {
    _notifications = [
      NotificationModel(
        id: '1',
        title: 'Safety Update',
        message: 'New safety regulations are now in effect. Please review.',
        date: DateTime.now(),
        type: 'safety',
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: 'System Maintenance',
        message: 'Scheduled maintenance tonight from 2-4 AM.',
        date: DateTime.now().subtract(const Duration(hours: 2)),
        type: 'system',
        isRead: true,
      ),
    ];
  }

  // Add listener for changes
  void addListener(Function() listener) {
    _listeners.add(listener);
  }

  // Remove listener
  void removeListener(Function() listener) {
    _listeners.remove(listener);
  }

  // Notify all listeners
  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  NotificationModel? get currentNotification {
    final unread = _notifications.where((n) => !n.isRead).toList();
    return unread.isNotEmpty ? unread.first : null;
  }

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  List<NotificationModel> get allNotifications =>
      List.unmodifiable(_notifications);

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      _notifyListeners();
    }
  }

  // For testing/development
  void addTestNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    _notifyListeners();
  }
}
