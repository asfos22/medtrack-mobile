import 'dart:convert';

ClinicalVisitsModel clinicalVisitsModelFromJson(String str) =>
    ClinicalVisitsModel.fromJson(json.decode(str));

String clinicalVisitsModelToJson(ClinicalVisitsModel data) =>
    json.encode(data.toJson());

class ClinicalVisitsModel {
  ClinicalVisitsModel({
    this.clinicalClinicalVisitsData,
  });

  List<ClinicalVisitsDatum>? clinicalClinicalVisitsData;

  factory ClinicalVisitsModel.fromJson(Map<String, dynamic> json) =>
      ClinicalVisitsModel(
        clinicalClinicalVisitsData: json["data"] == null
            ? null
            : List<ClinicalVisitsDatum>.from(
                json["data"].map((x) => ClinicalVisitsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": clinicalClinicalVisitsData == null
            ? null
            : List<dynamic>.from(
                clinicalClinicalVisitsData!.map((x) => x.toJson())),
      };
}

class ClinicalVisitsDatum {
  ClinicalVisitsDatum({
    this.clinicalSummary,
    this.doctor,
    this.doctorId,
    this.globalId,
    this.id,
    this.insertedAt,
    this.patientId,
    this.rating,
    this.state,
    this.status,
    this.title,
    this.updatedAt,
    this.visitDate,
  });

  dynamic clinicalSummary;
  Doctor? doctor;
  int? doctorId;
  String? globalId;
  int? id;
  DateTime? insertedAt;
  int? patientId;
  int? rating;
  String? state;
  int? status;
  String? title;
  DateTime? updatedAt;
  DateTime? visitDate;

  factory ClinicalVisitsDatum.fromJson(Map<String, dynamic> json) =>
      ClinicalVisitsDatum(
        clinicalSummary: json["clinical_summary"],
        doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        globalId: json["global_id"] == null ? null : json["global_id"],
        id: json["id"] == null ? null : json["id"],
        insertedAt: json["inserted_at"] == null
            ? null
            : DateTime.parse(json["inserted_at"]),
        patientId: json["patient_id"] == null ? null : json["patient_id"],
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
        "clinical_summary": clinicalSummary,
        "doctor": doctor == null ? null : doctor!.toJson(),
        "doctor_id": doctorId == null ? null : doctorId,
        "global_id": globalId == null ? null : globalId,
        "id": id == null ? null : id,
        "inserted_at":
            insertedAt == null ? null : insertedAt!.toIso8601String(),
        "patient_id": patientId == null ? null : patientId,
        "rating": rating == null ? null : rating,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "title": title == null ? null : title,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "visit_date": visitDate == null ? null : visitDate!.toIso8601String(),
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
  String? types;

  factory MapLocation.fromJson(Map<String, dynamic> json) => MapLocation(
      addressComponents: json["address_components"] == null
          ? null
          : List<AddressComponent>.from(json["address_components"]
              .map((x) => AddressComponent.fromJson(x))),
      formattedAddress:
          json["formatted_address"] == null ? null : json["formatted_address"],
      geometry:
          json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
      placeId: json["place_id"] == null ? null : json["place_id"],
      types: null //json["types"] == null ? null : json["types"],
      );

  Map<String, dynamic> toJson() => {
        "address_components": addressComponents == null
            ? null
            : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
        "formatted_address": formattedAddress == null ? null : formattedAddress,
        "geometry": geometry == null ? null : geometry!.toJson(),
        "place_id": placeId == null ? null : placeId,
        "types": types == null ? null : types,
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
  String? types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"] == null ? null : json["long_name"],
        shortName: json["short_name"] == null ? null : json["short_name"],
        types: null, // json["types"] == null ? null : json["types"],
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName == null ? null : longName,
        "short_name": shortName == null ? null : shortName,
        "types": types == null ? null : types,
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
