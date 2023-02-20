import 'dart:convert';

DiagnosisModel diagnosisModelFromJson(String str) =>
    DiagnosisModel.fromJson(json.decode(str));

String diagnosisModelToJson(DiagnosisModel data) => json.encode(data.toJson());

class DiagnosisModel {
  DiagnosisModel({
    this.data,
  });

  List<DiagnosisDatum>? data;

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) => DiagnosisModel(
        data: json["data"] == null
            ? null
            : List<DiagnosisDatum>.from(
                json["data"].map((x) => DiagnosisDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DiagnosisDatum {
  DiagnosisDatum({
    this.assignedCenterId,
    this.assignedFacility,
    this.attachments,
    this.clinicalSummary,
    this.fullfilledCenterId,
    this.id,
    this.insertedAt,
    this.items,
    this.state,
    this.status,
    this.updatedAt,
    this.visitId,
  });

  int? assignedCenterId;
  AssignedFacility? assignedFacility;
  List<Attachment>? attachments;
  String? clinicalSummary;
  dynamic fullfilledCenterId;
  int? id;
  DateTime? insertedAt;
  List<Item>? items;
  String? state;
  int? status;
  DateTime? updatedAt;
  int? visitId;

  factory DiagnosisDatum.fromJson(Map<String, dynamic> json) => DiagnosisDatum(
        assignedCenterId: json["assigned_center_id"] == null
            ? null
            : json["assigned_center_id"],
        assignedFacility: json["assigned_facility"] == null
            ? null
            : AssignedFacility.fromJson(json["assigned_facility"]),
        attachments: json["attachments"] == null
            ? null
            : List<Attachment>.from(
                json["attachments"].map((x) => Attachment.fromJson(x))),
        clinicalSummary:
            json["clinical_summary"] == null ? null : json["clinical_summary"],
        fullfilledCenterId: json["fullfilled_center_id"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        visitId: json["visit_id"] == null ? null : json["visit_id"],
      );

  Map<String, dynamic> toJson() => {
        "assigned_center_id":
            assignedCenterId == null ? null : assignedCenterId,
        "assigned_facility":
            assignedFacility == null ? null : assignedFacility!.toJson(),
        "attachments": attachments == null
            ? null
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "clinical_summary": clinicalSummary == null ? null : clinicalSummary,
        "fullfilled_center_id": fullfilledCenterId,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "visit_id": visitId == null ? null : visitId,
      };
}

class AssignedFacility {
  AssignedFacility({
    this.email,
    this.facilityName,
    this.globalId,
    this.id,
    this.insertedAt,
    this.isHeadBranch,
    this.location,
    this.mapLocation,
    this.notes,
    this.parentBrandId,
    this.phone,
    this.picture,
    this.region,
    this.state,
    this.status,
    this.updatedAt,
  });

  String? email;
  String? facilityName;
  String? globalId;
  int? id;
  DateTime? insertedAt;
  dynamic isHeadBranch;
  String? location;
  dynamic mapLocation;
  dynamic notes;
  dynamic parentBrandId;
  String? phone;
  dynamic picture;
  String? region;
  String? state;
  int? status;
  DateTime? updatedAt;

  factory AssignedFacility.fromJson(Map<String, dynamic> json) =>
      AssignedFacility(
        email: json["email"] == null ? null : json["email"],
        facilityName:
            json["facility_name"] == null ? null : json["facility_name"],
        globalId: json["global_id"] == null ? null : json["global_id"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        isHeadBranch: json["is_head_branch"],
        location: json["location"] == null ? null : json["location"],
        mapLocation: json["map_location"],
        notes: json["notes"],
        parentBrandId: json["parent_brand_id"],
        phone: json["phone"] == null ? null : json["phone"],
        picture: json["picture"],
        region: json["region"] == null ? null : json["region"],
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "facility_name": facilityName == null ? null : facilityName,
        "global_id": globalId == null ? null : globalId,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "is_head_branch": isHeadBranch,
        "location": location == null ? null : location,
        "map_location": mapLocation,
        "notes": notes,
        "parent_brand_id": parentBrandId,
        "phone": phone == null ? null : phone,
        "picture": picture,
        "region": region == null ? null : region,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class Attachment {
  Attachment({
    this.fileName,
    this.fileType,
    this.id,
    this.insertedAt,
    this.itemId,
    this.itemType,
    this.state,
    this.status,
    this.updatedAt,
  });

  String? fileName;
  String? fileType;
  int? id;
  DateTime? insertedAt;
  int? itemId;
  String? itemType;
  String? state;
  int? status;
  DateTime? updatedAt;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        fileName: json["file_name"] == null ? null : json["file_name"],
        fileType: json["file_type"] == null ? null : json["file_type"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        itemId: json["item_id"] == null ? null : json["item_id"],
        itemType: json["item_type"] == null ? null : json["item_type"],
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "file_name": fileName == null ? null : fileName,
        "file_type": fileType == null ? null : fileType,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "item_id": itemId == null ? null : itemId,
        "item_type": itemType == null ? null : itemType,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class Item {
  Item({
    this.category,
    this.categoryId,
    this.cost,
    this.id,
    this.insertedAt,
    this.itemId,
    this.name,
    this.requestId,
    this.state,
    this.status,
    this.updatedAt,
    this.visitId,
  });

  String? category;
  int? categoryId;
  double? cost;
  int? id;
  DateTime? insertedAt;
  int? itemId;
  String? name;
  int? requestId;
  dynamic state;
  dynamic status;
  DateTime? updatedAt;
  int? visitId;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        category: json["category"] == null ? null : json["category"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        cost: json["cost"] == null ? null : json["cost"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        itemId: json["item_id"] == null ? null : json["item_id"],
        name: json["name"] == null ? null : json["name"],
        requestId: json["request_id"] == null ? null : json["request_id"],
        state: json["state"],
        status: json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        visitId: json["visit_id"] == null ? null : json["visit_id"],
      );

  Map<String, dynamic> toJson() => {
        "category": category == null ? null : category,
        "category_id": categoryId == null ? null : categoryId,
        "cost": cost == null ? null : cost,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "item_id": itemId == null ? null : itemId,
        "name": name == null ? null : name,
        "request_id": requestId == null ? null : requestId,
        "state": state,
        "status": status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "visit_id": visitId == null ? null : visitId,
      };
}
