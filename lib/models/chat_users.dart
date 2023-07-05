class ChatArchitectsListModel {
  String clientsName;
  String architectsName;
  String message;
  String imageURL;
  String time;
  bool isRead;
  int unreadCount;
  String chatId;
  String clientsEmail;
  ChatArchitectsListModel({
    required this.clientsName,
    required this.architectsName,
    required this.message,
    required this.imageURL,
    required this.time,
    required this.isRead,
    required this.unreadCount,
    required this.chatId,
    required this.clientsEmail,
  });
}
