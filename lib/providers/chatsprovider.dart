import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../firebase/authentication.dart';
import '../models/chat_users.dart';
import '../models/chats_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatsProvider with ChangeNotifier {
  final List<ChatArchitectsListModel> _chatClientList = [];

  List<ChatArchitectsListModel> get getArchitectsList {
    return [..._chatClientList];
  }

  Future<List<dynamic>> getMessagedClientsID() async {
    final User? user = Auth().currentUser;
    var architectId = user!.uid;
    final CollectionReference architectsCollection =
        FirebaseFirestore.instance.collection("architects");
    DocumentSnapshot documentSnapshot =
        await architectsCollection.doc(architectId).get();
    if (documentSnapshot.exists) {
      print(documentSnapshot.get("architectClientsId"));
      return documentSnapshot.get("architectClientsId");
    } else {
      print('Document does not exists on the Database');
      return [];
    }
  }

  Future<List<ChatArchitectsListModel>> getMessagedClientssDetails() async {
    final User? architect = Auth().currentUser;
    var architectId = architect!.uid;
    List<dynamic> clientsIdArray = await getMessagedClientsID();
    List<Future<void>> futures = clientsIdArray.map((userId) async {
      //Write Code to retrieve and update List
      String chatId = userId + architectId;
      final CollectionReference clientsCollection =
          FirebaseFirestore.instance.collection("users");
      DocumentSnapshot docClientSnapshot =
          await clientsCollection.doc(userId).get();
      if (docClientSnapshot.exists) {
        final CollectionReference chatsCollection =
            FirebaseFirestore.instance.collection("chats");
        DocumentSnapshot docChatsSnapshot = await chatsCollection
            .doc(chatId)
            .collection('messages')
            .orderBy('time', descending: true)
            .limit(1)
            .get()
            .then((querySnapshot) => querySnapshot.docs.first);
        if (docChatsSnapshot.exists) {
          bool isPresentInList = false;
          for (int i = 0; i < _chatClientList.length; i++) {
            if (_chatClientList[i].chatId == chatId) {
              isPresentInList = true;
              _chatClientList[i].message = docChatsSnapshot.get('message');
              _chatClientList[i].time =
                  convertTimeStampToDate(docChatsSnapshot.get('time'));
              _chatClientList[i].isRead = docChatsSnapshot.get('read');
              break;
            }
          }
          if (isPresentInList == false) {
            _chatClientList.add(
              ChatArchitectsListModel(
                clientsName: docClientSnapshot.get('name'),
                message: docChatsSnapshot.get('message'),
                clientsEmail: docClientSnapshot.get('email'),
                imageURL: docClientSnapshot.get('imageUrl'),
                // imageURL: "assets/Male.png",
                time: convertTimeStampToDate(docChatsSnapshot.get('time')),
                isRead: docChatsSnapshot.get('read'),
                unreadCount: 1,
                chatId: chatId,
                architectsName: await getArchitectsName(),
              ),
            );
          }
        }
      }
      // print("Hello ${docArchitectSnapshot.get('architectName')}");
    }).toList();
    await Future.wait(futures);
    return [..._chatClientList];
  }

  Future<String> getArchitectsName() async {
    final User? user = Auth().currentUser;
    var architectId = user!.uid;
    final CollectionReference architectsCollection =
        FirebaseFirestore.instance.collection("architects");
    DocumentSnapshot documentSnapshot =
        await architectsCollection.doc(architectId).get();
    if (documentSnapshot.exists) {
      return documentSnapshot.get("architectName");
    } else {
      print('Document does not exists on the Database');
      return "Unknown";
    }
  }

  String convertTimeStampToDate(timestamp) {
    return timeago.format(timestamp.toDate(), locale: 'en_short');
  }

  Stream<QuerySnapshot> getChatStream(String uniqueId) {
    return FirebaseFirestore.instance
        .collection("chats")
        .doc(uniqueId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  void sendMessage(String message, bool read, Sender sender, String clientId) {
    try {
      //Get the Users Id
      final User? architect = Auth().currentUser;
      var architectId = architect!.uid;

      // //Add to the hiredArchitects array
      // FirebaseFirestore.instance
      //     .collection("architects")
      //     .doc(architectId)
      //     .update({
      //   "architectClientsId": FieldValue.arrayUnion([clientId])
      // }).then(
      //   (value) => print("Connection Established Sucessfully."),
      //   onError: (e) => print("Cant Establish Connection"),
      // );

      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("chats")
          .doc(clientId + architectId)
          .collection('messages')
          .doc(DateTime.now().microsecondsSinceEpoch.toString());

      ChatsModel chatsModel = ChatsModel(
        message: message,
        time: DateTime.now(),
        read: read,
        sender: sender,
      );

      FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          transaction.set(documentReference, chatsModel.toJson());
        },
      );
    } on FirebaseException catch (e) {
      print("Error ${e}");
    }
  }

  Future<void> sendNotification(String archId, String message) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(archId)
        .get()
        .then((value) async {
      var tokens = value["token"] as List<dynamic>;
      var name = value["name"];
      print("tokens  $tokens");
      for (var token in tokens) {
        await sendPushMessage(message, name, token);
      }
    });
  }

  Future<void> sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA9sLsQ3Y:APA91bGYm4n0q1JJKyqqi3S8ZmUy2_3MocabrZlSbmDCq3LM18ax3cFuF-TlI3aKcYgi_sYOyS7qQZZsp6XWNkS7js_McRRVDNAk_iDudFiYGTOUEr_VIMRQSItKQ6JQ-GHJeGJ6f_4k',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }
}
