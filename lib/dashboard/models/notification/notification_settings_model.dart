// To parse this JSON data, do
//
//     final notificationsSettingsModel = notificationsSettingsModelFromJson(jsonString);

import 'dart:convert';

NotificationsSettingsModel notificationsSettingsModelFromJson(String str) =>
    NotificationsSettingsModel.fromJson(json.decode(str));

String notificationsSettingsModelToJson(NotificationsSettingsModel data) =>
    json.encode(data.toJson());

class NotificationsSettingsModel {
  NotificationsSettingsModel({
    this.data,
    this.notifications,
  });

  List<NotificationDatum>? data;
  List<NotificationItem>? notifications;

  factory NotificationsSettingsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsSettingsModel(
        data: json["data"] == null
            ? null
            : List<NotificationDatum>.from(
                json["data"].map((x) => NotificationDatum.fromJson(x))),
        notifications: json["notifications"] == null
            ? null
            : List<NotificationItem>.from(
                json["notifications"].map((x) => NotificationItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "notifications": notifications == null
            ? null
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class NotificationDatum {
  NotificationDatum({
    this.id,
    this.insertedAt,
    this.notification,
    this.notificationId,
    this.patientId,
    this.state,
    this.status,
    this.updatedAt,
  });

  int? id;
  DateTime? insertedAt;
  NotificationItem? notification;
  int? notificationId;
  int? patientId;
  String? state;
  int? status;
  DateTime? updatedAt;

  factory NotificationDatum.fromJson(Map<String, dynamic> json) =>
      NotificationDatum(
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        notification: json["notification"] == null
            ? null
            : NotificationItem.fromJson(json["notification"]),
        notificationId:
            json["notification_id"] == null ? null : json["notification_id"],
        patientId: json["patient_id"] == null ? null : json["patient_id"],
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "notification": notification == null ? null : notification!.toJson(),
        "notification_id": notificationId == null ? null : notificationId,
        "patient_id": patientId == null ? null : patientId,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class NotificationItem {
  NotificationItem({
    this.description,
    this.id,
    this.insertedAt,
    this.name,
    this.state,
    this.status,
    this.title,
    this.updatedAt,
  });

  String? description;
  int? id;
  DateTime? insertedAt;
  String? name;
  String? state;
  int? status;
  String? title;
  DateTime? updatedAt;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      NotificationItem(
        description: json["description"] == null ? null : json["description"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        name: json["name"] == null ? null : json["name"],
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        title: json["title"] == null ? null : json["title"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description == null ? null : description,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "name": name == null ? null : name,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "title": title == null ? null : title,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
