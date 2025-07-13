// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

//* Chat model for one-to-one conversation
class ChatModel extends Equatable {
  final String chatId;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastUpdated;
  final String lastSender;
  final Map<String, int> unreadCount;

  const ChatModel({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    required this.lastUpdated,
    required this.lastSender,
    required this.unreadCount,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json, String docId) {
    return ChatModel(
      chatId: docId,
      participants: List<String>.from(json['participants'] as List<dynamic>),
      lastMessage: json['lastMessage'] as String? ?? '',
      lastUpdated: (json['lastUpdated'] as Timestamp).toDate(),
      unreadCount: Map<String, int>.from(
        (json['unreadCount'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as int)),
      ),
      lastSender: json['lastSender'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'participants': participants,
      'lastMessage': lastMessage,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
      'unreadCount': unreadCount,
      'lastSender': lastSender
    };
  }

  ChatModel copyWith({
    String? lastMessage,
    DateTime? lastUpdated,
    Map<String, int>? unreadCount,
  }) {
    return ChatModel(
      chatId: chatId,
      participants: participants,
      lastMessage: lastMessage ?? this.lastMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      unreadCount: unreadCount ?? this.unreadCount,
      lastSender: lastSender ,
    );
  }

  @override
  List<Object?> get props =>
      [chatId, participants, lastMessage, lastUpdated, unreadCount];
}

//* Message status
enum MessageStatus { pending, sent, delivered, read }

//* Message model for chat messages
class MessageModel extends Equatable {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String content;
  final String type;
  final String? mediaUrl;
  final DateTime timestamp;
  final MessageStatus status;
  final DateTime? readAt;

  const MessageModel({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    this.type = 'text',
    this.mediaUrl,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.readAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, String docId) {
    MessageStatus _parseStatus(String value) {
      return MessageStatus.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => MessageStatus.sent,
      );
    }

    return MessageModel(
      messageId: docId,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      content: json['content'] as String,
      type: json['type'] as String? ?? 'text',
      mediaUrl: json['mediaUrl'] as String?,
      timestamp: json['timestamp'] is DateTime
          ? json['timestamp']
          : DateTime.parse(json['timestamp'].toString()),
      status: _parseStatus(json['status'] as String? ?? 'sent'),
      readAt: json['readAt'] != null
          ? (json['readAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'type': type,
      'timestamp': Timestamp.fromDate(timestamp),
      'status': status.toString().split('.').last,
    };
    if (mediaUrl != null) data['mediaUrl'] = mediaUrl;
    if (readAt != null) data['readAt'] = Timestamp.fromDate(readAt!);
    return data;
  }

  MessageModel copyWith({
    MessageStatus? status,
    DateTime? readAt,
  }) {
    return MessageModel(
      messageId: messageId,
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      type: type,
      mediaUrl: mediaUrl,
      timestamp: timestamp,
      status: status ?? this.status,
      readAt: readAt ?? this.readAt,
    );
  }

  @override
  List<Object?> get props => [
        messageId,
        senderId,
        receiverId,
        content,
        type,
        mediaUrl,
        timestamp,
        status,
        readAt,
      ];
}
