class PrescriptionDatum {
  PrescriptionDatum({
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

  AssignedPharmacy? assignedPharmacy;
  int? assignedPharmacyId;
  dynamic? cost;
  dynamic? fulfilledPharmacyId;
  int? id;
  DateTime? insertedAt;
  List<DrugItem>? items;
  String? notes;
  String? state;
  int? status;
  String? title;
  DateTime? updatedAt;
  int? visitId;

  factory PrescriptionDatum.fromJson(Map<String, dynamic> json) =>
      PrescriptionDatum(
        assignedPharmacy: json["assigned_pharmacy"] == null
            ? null
            : AssignedPharmacy.fromJson(json["assigned_pharmacy"]),
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
            : List<DrugItem>.from(json["items"].map((x) => DrugItem.fromJson(x))),
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

class AssignedPharmacy {
  AssignedPharmacy({
    this.email,
    this.facilityName,
    this.globalId,
    this.id,
    this.insertedAt,
    this.isHeadBranch,
    this.location,
    this.mapLocation,
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
  MapLocation? mapLocation;
  int? parentBrandId;
  String? phone;
  String? picture;
  String? region;
  String? state;
  int? status;
  DateTime? updatedAt;

  factory AssignedPharmacy.fromJson(Map<String, dynamic> json) =>
      AssignedPharmacy(
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
        mapLocation: json["map_location"] == null
            ? null
            : MapLocation.fromJson(json["map_location"]),
        parentBrandId:
        json["parent_brand_id"] == null ? null : json["parent_brand_id"],
        phone: json["phone"] == null ? null : json["phone"],
        picture: json["picture"] == null ? null : json["picture"],
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
    insertedAt == null ? null : insertedAt?.toIso8601String(),
    "is_head_branch": isHeadBranch,
    "location": location == null ? null : location,
    "map_location": mapLocation == null ? null : mapLocation?.toJson(),
    "parent_brand_id": parentBrandId == null ? null : parentBrandId,
    "phone": phone == null ? null : phone,
    "picture": picture == null ? null : picture,
    "region": region == null ? null : region,
    "state": state == null ? null : state,
    "status": status == null ? null : status,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
  };
}

class MapLocation {
  MapLocation({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    // this.types,
  });

  List<AddressComponent>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;
  //String? types;

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
    // types: json["types"] == null ? null : json["types"],
  );

  Map<String, dynamic> toJson() => {
    "address_components": addressComponents == null
        ? null
        : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
    "formatted_address": formattedAddress == null ? null : formattedAddress,
    "geometry": geometry == null ? null : geometry?.toJson(),
    "place_id": placeId == null ? null : placeId,
    //"types": types == null ? null : types,
  };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    // this.types,
  });

  String? longName;
  String? shortName;
//  String? types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"] == null ? null : json["long_name"],
        shortName: json["short_name"] == null ? null : json["short_name"],
        ///types: json["types"] == null ? null : json["types"],
      );

  Map<String, dynamic> toJson() => {
    "long_name": longName == null ? null : longName,
    "short_name": shortName == null ? null : shortName,
    //  "types": types == null ? null : types,
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

class DrugItem {
  DrugItem({
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
  dynamic notes;
  int? prescriptionId;
  String? state;
  int? status;
  DateTime? updatedAt;
  int? visitId;

  factory DrugItem.fromJson(Map<String, dynamic> json) => DrugItem(
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
  dynamic picture;
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
    insertedAt == null ? null : insertedAt?.toIso8601String(),
    "name": name == null ? null : name,
    "picture": picture,
    "state": state == null ? null : state,
    "status": status == null ? null : status,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
  };
}
