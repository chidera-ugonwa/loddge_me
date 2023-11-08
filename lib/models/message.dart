import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderDisplayName;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.senderID,
      required this.senderDisplayName,
      required this.message,
      required this.receiverID,
      required this.timestamp});

  //convert to a Map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderDisplayName': senderDisplayName,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp
    };
  }
}
