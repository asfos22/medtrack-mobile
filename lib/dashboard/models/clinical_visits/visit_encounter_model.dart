import 'dart:convert';

VisitEncounterModel visitEncounterModelFromJson(String str) =>
    VisitEncounterModel.fromJson(json.decode(str));

String visitEncounterModelToJson(VisitEncounterModel data) =>
    json.encode(data.toJson());

class VisitEncounterModel {
  VisitEncounterModel({
    this.data,
  });

  VisitEncounterData? data;

  factory VisitEncounterModel.fromJson(Map<String, dynamic> json) =>
      VisitEncounterModel(
        data: json["data"] == null
            ? null
            : VisitEncounterData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class VisitEncounterData {
  VisitEncounterData({
    this.attachments,
    this.clinicalSummary,
    this.dataHash,
    this.diagnosis,
    this.doctor,
    this.doctorId,
    this.globalId,
    this.id,
    this.insertedAt,
    this.investigations,
    this.patientId,
    this.prescriptions,
    this.rating,
    this.state,
    this.status,
    this.title,
    this.updatedAt,
    this.visitDate,
  });

  List<VisitAttachment>? attachments;
  String? clinicalSummary;
  dynamic dataHash;
  VisitDiagnosis? diagnosis;
  Doctor? doctor;
  int? doctorId;
  String? globalId;
  int? id;
  DateTime? insertedAt;
  List<dynamic>? investigations;
  int? patientId;
  List<VisitPrescription>? prescriptions;
  int? rating;
  String? state;
  int? status;
  String? title;
  DateTime? updatedAt;
  DateTime? visitDate;

  factory VisitEncounterData.fromJson(Map<String, dynamic> json) =>
      VisitEncounterData(
        attachments: json["attachments"] == null
            ? null
            : List<VisitAttachment>.from(
                json["attachments"].map((x) => VisitAttachment.fromJson(x))),
        clinicalSummary:
            json["clinical_summary"] == null ? null : json["clinical_summary"],
        dataHash: json["data_hash"],
        diagnosis: json["diagnosis"] == null
            ? null
            : VisitDiagnosis.fromJson(json["diagnosis"]),
        doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        globalId: json["global_id"] == null ? null : json["global_id"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        investigations: json["investigations"] == null
            ? null
            : List<dynamic>.from(json["investigations"].map((x) => x)),
        patientId: json["patient_id"] == null ? null : json["patient_id"],
        prescriptions: json["prescriptions"] == null
            ? null
            : List<VisitPrescription>.from(json["prescriptions"]
                .map((x) => VisitPrescription.fromJson(x))),
        rating: json["rating"] == null ? null : json["rating"],
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        title: json["title"] == null ? null : json["title"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        visitDate: json["visit_date"] == null
            ? null
            : DateTime.parse(json["visit_date"]),
      );

  Map<String, dynamic> toJson() => {
        "attachments": attachments == null
            ? null
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "clinical_summary": clinicalSummary == null ? null : clinicalSummary,
        "data_hash": dataHash,
        "diagnosis": diagnosis == null ? null : diagnosis!.toJson(),
        "doctor": doctor == null ? null : doctor!.toJson(),
        "doctor_id": doctorId == null ? null : doctorId,
        "global_id": globalId == null ? null : globalId,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "investigations": investigations == null
            ? null
            : List<dynamic>.from(investigations!.map((x) => x)),
        "patient_id": patientId == null ? null : patientId,
        "prescriptions": prescriptions == null
            ? null
            : List<dynamic>.from(prescriptions!.map((x) => x.toJson())),
        "rating": rating == null ? null : rating,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "title": title == null ? null : title,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "visit_date": visitDate == null ? null : visitDate!.toIso8601String(),
      };
}

class VisitAttachment {
  VisitAttachment({
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

  factory VisitAttachment.fromJson(Map<String, dynamic> json) =>
      VisitAttachment(
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

class VisitDiagnosis {
  VisitDiagnosis({
    this.items,
  });

  List<DiagnosisItem>? items;

  factory VisitDiagnosis.fromJson(Map<String, dynamic> json) => VisitDiagnosis(
        items: json["items"] == null
            ? null
            : List<DiagnosisItem>.from(
                json["items"].map((x) => DiagnosisItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class DiagnosisItem {
  DiagnosisItem({
    this.date,
    this.doctorId,
    this.fullCode,
    this.fullName,
    this.notes,
  });

  DateTime? date;
  int? doctorId;
  String? fullCode;
  String? fullName;
  String? notes;

  factory DiagnosisItem.fromJson(Map<String, dynamic> json) => DiagnosisItem(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        fullCode: json["full_code"] == null ? null : json["full_code"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        notes: json["notes"] == null ? null : json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date!.toIso8601String(),
        "doctor_id": doctorId == null ? null : doctorId,
        "full_code": fullCode == null ? null : fullCode,
        "full_name": fullName == null ? null : fullName,
        "notes": notes == null ? null : notes,
      };
}

class Doctor {
  Doctor({
    this.email,
    this.facilityName,
    this.gender,
    this.globalId,
    this.id,
    this.insertedAt,
    this.location,
    this.mapLocation,
    this.name,
    this.phone,
    this.picture,
    this.region,
    this.specialty,
    this.state,
    this.status,
    this.title,
    this.updatedAt,
    this.isHeadBranch,
    this.parentBrandId,
  });

  String? email;
  String? facilityName;
  String? gender;
  String? globalId;
  int? id;
  DateTime? insertedAt;
  String? location;
  MapLocation? mapLocation;
  String? name;
  String? phone;
  String? picture;
  String? region;
  String? specialty;
  String? state;
  int? status;
  String? title;
  DateTime? updatedAt;
  dynamic isHeadBranch;
  int? parentBrandId;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        email: json["email"] == null ? null : json["email"],
        facilityName:
            json["facility_name"] == null ? null : json["facility_name"],
        gender: json["gender"] == null ? null : json["gender"],
        globalId: json["global_id"] == null ? null : json["global_id"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        location: json["location"] == null ? null : json["location"],
        mapLocation: json["map_location"] == null
            ? null
            : MapLocation.fromJson(json["map_location"]),
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        picture: json["picture"] == null ? null : json["picture"],
        region: json["region"] == null ? null : json["region"],
        specialty: json["specialty"] == null ? null : json["specialty"],
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        title: json["title"] == null ? null : json["title"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isHeadBranch: json["is_head_branch"],
        parentBrandId:
            json["parent_brand_id"] == null ? null : json["parent_brand_id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "facility_name": facilityName == null ? null : facilityName,
        "gender": gender == null ? null : gender,
        "global_id": globalId == null ? null : globalId,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "location": location == null ? null : location,
        "map_location": mapLocation == null ? null : mapLocation!.toJson(),
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "picture": picture == null ? null : picture,
        "region": region == null ? null : region,
        "specialty": specialty == null ? null : specialty,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "title": title == null ? null : title,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "is_head_branch": isHeadBranch,
        "parent_brand_id": parentBrandId == null ? null : parentBrandId,
      };
}

class MapLocation {
  MapLocation({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.types,
  });

  List<AddressComponent>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;
  List<String>? types;

  factory MapLocation.fromJson(Map<String, dynamic> json) => MapLocation(
        addressComponents: json["address_components"] == null
            ? null
            : List<AddressComponent>.from(json["address_components"]
                .map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"] == null
            ? null
            : json["formatted_address"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        placeId: json["place_id"] == null ? null : json["place_id"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address_components": addressComponents == null
            ? null
            : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
        "formatted_address": formattedAddress == null ? null : formattedAddress,
        "geometry": geometry == null ? null : geometry!.toJson(),
        "place_id": placeId == null ? null : placeId,
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
      };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String? longName;
  String? shortName;
  List<String>? types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"] == null ? null : json["long_name"],
        shortName: json["short_name"] == null ? null : json["short_name"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName == null ? null : longName,
        "short_name": shortName == null ? null : shortName,
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    this.bounds,
    this.location,
    this.locationType,
    this.viewport,
  });

  Bounds? bounds;
  Location? location;
  String? locationType;
  Bounds? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        bounds: json["bounds"] == null ? null : Bounds.fromJson(json["bounds"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        locationType:
            json["location_type"] == null ? null : json["location_type"],
        viewport:
            json["viewport"] == null ? null : Bounds.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "bounds": bounds == null ? null : bounds!.toJson(),
        "location": location == null ? null : location!.toJson(),
        "location_type": locationType == null ? null : locationType,
        "viewport": viewport == null ? null : viewport!.toJson(),
      };
}

class Bounds {
  Bounds({
    this.east,
    this.north,
    this.south,
    this.west,
  });

  double? east;
  double? north;
  double? south;
  double? west;

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
        east: json["east"] == null ? null : json["east"].toDouble(),
        north: json["north"] == null ? null : json["north"].toDouble(),
        south: json["south"] == null ? null : json["south"].toDouble(),
        west: json["west"] == null ? null : json["west"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "east": east == null ? null : east,
        "north": north == null ? null : north,
        "south": south == null ? null : south,
        "west": west == null ? null : west,
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}

class VisitPrescription {
  VisitPrescription({
    this.assignedPharmacy,
    this.assignedPharmacyId,
    this.cost,
    this.fulfilledPharmacyId,
    this.id,
    this.insertedAt,
    this.items,
    this.notes,
    this.state,
    this.status,
    this.title,
    this.updatedAt,
    this.visitId,
  });

  Doctor? assignedPharmacy;
  int? assignedPharmacyId;
  dynamic cost;
  dynamic fulfilledPharmacyId;
  int? id;
  DateTime? insertedAt;
  List<PrescriptionItem>? items;
  String? notes;
  String? state;
  int? status;
  String? title;
  DateTime? updatedAt;
  int? visitId;

  factory VisitPrescription.fromJson(Map<String, dynamic> json) =>
      VisitPrescription(
        assignedPharmacy: json["assigned_pharmacy"] == null
            ? null
            : Doctor.fromJson(json["assigned_pharmacy"]),
        assignedPharmacyId: json["assigned_pharmacy_id"] == null
            ? null
            : json["assigned_pharmacy_id"],
        cost: json["cost"],
        fulfilledPharmacyId: json["fulfilled_pharmacy_id"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        items: json["items"] == null
            ? null
            : List<PrescriptionItem>.from(
                json["items"].map((x) => PrescriptionItem.fromJson(x))),
        notes: json["notes"] == null ? null : json["notes"],
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        title: json["title"] == null ? null : json["title"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        visitId: json["visit_id"] == null ? null : json["visit_id"],
      );

  Map<String, dynamic> toJson() => {
        "assigned_pharmacy":
            assignedPharmacy == null ? null : assignedPharmacy!.toJson(),
        "assigned_pharmacy_id":
            assignedPharmacyId == null ? null : assignedPharmacyId,
        "cost": cost,
        "fulfilled_pharmacy_id": fulfilledPharmacyId,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "notes": notes == null ? null : notes,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "title": title == null ? null : title,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "visit_id": visitId == null ? null : visitId,
      };
}

class PrescriptionItem {
  PrescriptionItem({
    this.cost,
    this.dosage,
    this.drug,
    this.drugId,
    this.id,
    this.insertedAt,
    this.name,
    this.notes,
    this.prescriptionId,
    this.state,
    this.status,
    this.updatedAt,
    this.visitId,
  });

  dynamic cost;
  String? dosage;
  Drug? drug;
  int? drugId;
  int? id;
  DateTime? insertedAt;
  String? name;
  dynamic? notes;
  int? prescriptionId;
  String? state;
  int? status;
  DateTime? updatedAt;
  int? visitId;

  factory PrescriptionItem.fromJson(Map<String, dynamic> json) =>
      PrescriptionItem(
        cost: json["cost"],
        dosage: json["dosage"] == null ? null : json["dosage"],
        drug: json["drug"] == null ? null : Drug.fromJson(json["drug"]),
        drugId: json["drug_id"] == null ? null : json["drug_id"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        name: json["name"] == null ? null : json["name"],
        notes: json["notes"],
        prescriptionId:
            json["prescription_id"] == null ? null : json["prescription_id"],
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        visitId: json["visit_id"] == null ? null : json["visit_id"],
      );

  Map<String, dynamic> toJson() => {
        "cost": cost,
        "dosage": dosage == null ? null : dosage,
        "drug": drug == null ? null : drug!.toJson(),
        "drug_id": drugId == null ? null : drugId,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "name": name == null ? null : name,
        "notes": notes,
        "prescription_id": prescriptionId == null ? null : prescriptionId,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "visit_id": visitId == null ? null : visitId,
      };
}

class Drug {
  Drug({
    this.code,
    this.description,
    this.dosage,
    this.id,
    this.insertedAt,
    this.name,
    this.picture,
    this.state,
    this.status,
    this.updatedAt,
  });

  String? code;
  String? description;
  String? dosage;
  int? id;
  DateTime? insertedAt;
  String? name;
  dynamic? picture;
  String? state;
  int? status;
  DateTime? updatedAt;

  factory Drug.fromJson(Map<String, dynamic> json) => Drug(
        code: json["code"] == null ? null : json["code"],
        description: json["description"] == null ? null : json["description"],
        dosage: json["dosage"] == null ? null : json["dosage"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        name: json["name"] == null ? null : json["name"],
        picture: json["picture"],
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "description": description == null ? null : description,
        "dosage": dosage == null ? null : dosage,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "name": name == null ? null : name,
        "picture": picture,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
