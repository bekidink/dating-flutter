import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String content;
  final String type;
  final String senderId;
  final bool seen;
  final Timestamp timestamp;
  final String duration; // Assume you are using Firebase Timestamp for time

  Message(
      {required this.id,
      required this.content,
      required this.seen,
      required this.type,
      required this.senderId,
      required this.timestamp,
      required this.duration});

  // Convert Message object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'type': type,
      'seen': seen,
      'senderId': senderId,
      'timestamp': timestamp,
      'duration': duration
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'type': type,
      'seen': seen,
      'senderId': senderId,
      'timestamp': timestamp,
      'duration': duration
    };
  }

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Message(
        id: doc.id,
        content: data['content'] ?? '',
        type: data['type'] ?? '',
        seen: data['seen'] ?? false,
        senderId: data['senderId'] ?? '',
        timestamp: data['timestamp'] ?? Timestamp.now(),
        duration: data['duration']);
  }
  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(
        id: data['id'],
        content: data['content'],
        senderId: data['senderId'],
        seen: data['seen'],
        type: data['type'],
        timestamp: data['timestamp'],
        duration: data['duration']);
  }
  // Create a Message object from a JSON object
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        content: json['content'],
        type: json['type'],
        seen: json['seen'],
        senderId: json['senderId'],
        timestamp: json['timestamp'],
        duration: json[
            'duration'] // Ensure that the timestamp is correctly converted from Firebase Timestamp if required
        );
  }
}
