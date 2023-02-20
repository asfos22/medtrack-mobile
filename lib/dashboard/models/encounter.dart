

class Encounter {
  Encounter({
    this.name,
    this.title,
    this.description,
    this.date,
    this.time,
    this.contact,
    this.investigations,
    this.attachment,
    this.comments,
    this.prescriptions,
  });

  String? name;
  String? title;
  String? description;
  String? date;
  String? time;
  Contact? contact;
  Investigations? investigations;
  List<Attachment>? attachment;
  Comments? comments;
  List<Prescription>? prescriptions;

  factory Encounter.fromJson(Map<String, dynamic> json) =>
      Encounter(
        name: json["name"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        time: json["time"],
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        investigations: json["investigations"] == null
            ? null
            : Investigations.fromJson(json["investigations"]),
        attachment: json["attachment"] == null
            ? null
            : List<Attachment>.from(
                json["attachment"].map((x) => Attachment.fromJson(x))),
        comments: json["comments"] == null
            ? null
            : Comments.fromJson(json["comments"]),
        prescriptions: json["prescriptions"] == null
            ? null
            : List<Prescription>.from(
                json["prescriptions"].map((x) => Prescription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "description": description,
        "date": date,
        "time": time,
        "contact": contact == null ? null : contact!.toJson(),
        "investigations":
            investigations == null ? null : investigations!.toJson(),
        "attachment": attachment == null
            ? null
            : List<dynamic>.from(attachment!.map((x) => x.toJson())),
        "comments": comments == null ? null : comments!.toJson(),
        "prescriptions": prescriptions == null
            ? null
            : List<dynamic>.from(prescriptions!.map((x) => x.toJson())),
      };
}

class Attachment {
  Attachment({
    this.src,
  });

  String? src;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
      };
}

class Comments {
  Comments({
    this.title,
    this.description,
  });

  String? title;
  String? description;

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

class Contact {
  Contact({
    this.name,
    this.title,
  });

  String? name;
  String? title;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json["name"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
      };
}

class Investigations {
  Investigations({
    this.name,
    this.description,
    this.tags,
  });

  String? name;
  String? description;
  List<Tag>? tags;

  factory Investigations.fromJson(Map<String, dynamic> json) => Investigations(
        name: json["name"],
        description: json["description"],
        tags: json["tags"] == null
            ? null
            : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "tags": tags == null
            ? null
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}

class Tag {
  Tag({
    this.name,
  });

  String? name;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Prescription {
  Prescription({
    this.title,
    this.description,
    this.month,
    this.day,
    this.medications,
  });

  String? title;
  String? description;
  String? month;
  String? day;
  List<Medication>? medications;

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
        title: json["title"],
        description: json["description"],
        month: json["month"],
        day: json["day"],
        medications: json["medications"] == null
            ? null
            : List<Medication>.from(
                json["medications"].map((x) => Medication.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "month": month,
        "day": day,
        "medications": medications == null
            ? null
            : List<dynamic>.from(medications!.map((x) => x.toJson())),
      };
}

class Medication {
  Medication({
    this.name,
    this.dosage,
    this.description,
    this.category,
    this.createdAt,
  });

  String? name;
  String? dosage;
  String? description;
  String? category;
  String? createdAt;

  factory Medication.fromJson(Map<String, dynamic> json) => Medication(
        name: json["name"],
        dosage: json["dosage"],
        description: json["description"],
        category: json["category"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dosage": dosage,
        "description": description,
        "category": category,
        "created_at": createdAt,
      };
}
