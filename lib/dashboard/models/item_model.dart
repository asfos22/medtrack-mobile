class Item {
  Item({
    this.title,
    this.description,
    this.code,
    this.icon,
    this.prescription,
    this.clinicalVisits,
    this.visitsDetails,
    this.diagnosis,
    this.diagnosisReports,
  });

  String? title;
  String? description;
  String? code;
  String? icon;
  List<Prescription>? prescription;
  List<ClinicalVisit>? clinicalVisits;
  List<VisitsDetail>? visitsDetails;
  List<Diagnosis>? diagnosis;
  List<DiagnosisReport>? diagnosisReports;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        description: json["description"],
        code: json["code"],
        icon: json["icon"],
        prescription: json["prescription"] == null
            ? null
            : List<Prescription>.from(
                json["prescription"].map((x) => Prescription.fromJson(x))),
        clinicalVisits: json["clinical_visits"] == null
            ? null
            : List<ClinicalVisit>.from(
                json["clinical_visits"].map((x) => ClinicalVisit.fromJson(x))),
        visitsDetails: json["visits_details"] == null
            ? null
            : List<VisitsDetail>.from(
                json["visits_details"].map((x) => VisitsDetail.fromJson(x))),
        diagnosis: json["diagnosis"] == null
            ? null
            : List<Diagnosis>.from(
                json["diagnosis"].map((x) => Diagnosis.fromJson(x))),
        diagnosisReports: json["diagnosis_reports"] == null
            ? null
            : List<DiagnosisReport>.from(json["diagnosis_reports"]
                .map((x) => DiagnosisReport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "code": code,
        "icon": icon,
        "prescription": prescription == null
            ? null
            : List<dynamic>.from(prescription!.map((x) => x.toJson())),
        "clinical_visits": clinicalVisits == null
            ? null
            : List<dynamic>.from(clinicalVisits!.map((x) => x.toJson())),
        "visits_details": visitsDetails == null
            ? null
            : List<dynamic>.from(visitsDetails!.map((x) => x.toJson())),
        "diagnosis": diagnosis == null
            ? null
            : List<dynamic>.from(diagnosis!.map((x) => x.toJson())),
        "diagnosis_reports": diagnosisReports == null
            ? null
            : List<dynamic>.from(diagnosisReports!.map((x) => x.toJson())),
      };
}

class ClinicalVisit {
  ClinicalVisit({
    this.year,
    this.visits,
  });

  String? year;
  List<Visit>? visits;

  factory ClinicalVisit.fromJson(Map<String, dynamic> json) => ClinicalVisit(
        year: json["year"],
        visits: json["visits"] == null
            ? null
            : List<Visit>.from(json["visits"].map((x) => Visit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "visits": visits == null
            ? null
            : List<dynamic>.from(visits!.map((x) => x.toJson())),
      };
}

class Visit {
  Visit({
    this.name,
    this.date,
    this.diagnosis,
    this.prescriptions,
  });

  String? name;
  String? date;
  List<Diagnosis>? diagnosis;
  List<Prescription>? prescriptions;

  factory Visit.fromJson(Map<String, dynamic> json) => Visit(
        name: json["name"],
        date: json["date"],
        diagnosis: json["diagnosis"] == null
            ? null
            : List<Diagnosis>.from(
                json["diagnosis"].map((x) => Diagnosis.fromJson(x))),
        prescriptions: json["prescriptions"] == null
            ? null
            : List<Prescription>.from(
                json["prescriptions"].map((x) => Prescription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "diagnosis": diagnosis == null
            ? null
            : List<dynamic>.from(diagnosis!.map((x) => x.toJson())),
        "prescriptions": prescriptions == null
            ? null
            : List<dynamic>.from(prescriptions!.map((x) => x.toJson())),
      };
}

class Diagnosis {
  Diagnosis({
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
  DiagnosisContact? contact;
  Investigations? investigations;
  List<Attachment>? attachment;
  Comments? comments;
  List<Prescription>? prescriptions;

  factory Diagnosis.fromJson(Map<String, dynamic> json) => Diagnosis(
        name: json["name"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        time: json["time"],
        contact: json["contact"] == null
            ? null
            : DiagnosisContact.fromJson(json["contact"]),
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
        title: json["title"]!,
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

class DiagnosisContact {
  DiagnosisContact({
    this.name,
    this.title,
  });

  String? name;
  String? title;

  factory DiagnosisContact.fromJson(Map<String, dynamic> json) =>
      DiagnosisContact(
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

class DiagnosisReport {
  DiagnosisReport({
    this.year,
    this.diagnostics,
  });

  String? year;
  List<Diagnostic>? diagnostics;

  factory DiagnosisReport.fromJson(Map<String, dynamic> json) =>
      DiagnosisReport(
        year: json["year"],
        diagnostics: json["diagnostics"] == null
            ? null
            : List<Diagnostic>.from(
                json["diagnostics"].map((x) => Diagnostic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "diagnostics": diagnostics == null
            ? null
            : List<dynamic>.from(diagnostics!.map((x) => x.toJson())),
      };
}

class Diagnostic {
  Diagnostic({
    this.name,
    this.date,
  });

  String? name;
  String? date;

  factory Diagnostic.fromJson(Map<String, dynamic> json) => Diagnostic(
        name: json["name"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
      };
}

class VisitsDetail {
  VisitsDetail({
    this.name,
    this.title,
    this.description,
    this.date,
    this.time,
    this.contact,
    this.reports,
    this.accessControl,
  });

  String? name;
  String? title;
  String? description;
  String? date;
  String? time;
  VisitsDetailContact? contact;
  List<VisitsDetailReport>? reports;
  List<AccessControl>? accessControl;

  factory VisitsDetail.fromJson(Map<String, dynamic> json) => VisitsDetail(
        name: json["name"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        time: json["time"],
        contact: json["contact"] == null
            ? null
            : VisitsDetailContact.fromJson(json["contact"]),
        reports: json["reports"] == null
            ? null
            : List<VisitsDetailReport>.from(
                json["reports"].map((x) => VisitsDetailReport.fromJson(x))),
        accessControl: json["access_control"] == null
            ? null
            : List<AccessControl>.from(
                json["access_control"].map((x) => AccessControl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "description": description,
        "date": date,
        "time": time,
        "contact": contact == null ? null : contact!.toJson(),
        "reports": reports == null
            ? null
            : List<dynamic>.from(reports!.map((x) => x.toJson())),
        "access_control": accessControl == null
            ? null
            : List<dynamic>.from(accessControl!.map((x) => x.toJson())),
      };
}

class AccessControl {
  AccessControl({
    this.name,
    this.description,
    this.physicians,
  });

  String? name;
  String? description;
  List<Physician>? physicians;

  factory AccessControl.fromJson(Map<String, dynamic> json) => AccessControl(
        name: json["name"],
        description: json["description"],
        physicians: json["physicians"] == null
            ? null
            : List<Physician>.from(
                json["physicians"].map((x) => Physician.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "physicians": physicians == null
            ? null
            : List<dynamic>.from(physicians!.map((x) => x.toJson())),
      };
}

class Physician {
  Physician({
    this.name,
    this.profilePic,
    this.facilityName,
    this.primary,
    this.revoke,
    this.isRevoke,
    this.contact,
  });

  String? name;
  String? profilePic;
  String? facilityName;
  String? primary;
  String? revoke;
  bool? isRevoke;
  PhysicianContact? contact;

  factory Physician.fromJson(Map<String, dynamic> json) => Physician(
        name: json["name"],
        profilePic: json["profilePic"],
        facilityName: json["facilityName"],
        primary: json["primary"],
        revoke: json["revoke"],
        isRevoke: json["isRevoke"],
        contact: json["contact"] == null
            ? null
            : PhysicianContact.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePic": profilePic,
        "facilityName": facilityName,
        "primary": primary,
        "revoke": revoke,
        "isRevoke": isRevoke,
        "contact": contact == null ? null : contact!.toJson(),
      };
}

class PhysicianContact {
  PhysicianContact({
    this.name,
    this.facility,
    this.phoneNumber,
    this.email,
    this.location,
  });

  String? name;
  String? facility;
  String? phoneNumber;
  String? email;
  String? location;

  factory PhysicianContact.fromJson(Map<String, dynamic> json) =>
      PhysicianContact(
        name: json["name"],
        facility: json["facility"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "facility": facility,
        "phone_number": phoneNumber,
        "email": email,
        "location": location,
      };
}

class VisitsDetailContact {
  VisitsDetailContact({
    this.name,
    this.title,
    this.physician,
  });

  String? name;
  String? title;
  Physician? physician;

  factory VisitsDetailContact.fromJson(Map<String, dynamic> json) =>
      VisitsDetailContact(
        name: json["name"],
        title: json["title"],
        physician: json["physician"] == null
            ? null
            : Physician.fromJson(json["physician"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "physician": physician == null ? null : physician!.toJson(),
      };
}

class VisitsDetailReport {
  VisitsDetailReport({
    this.name,
    this.code,
    this.report,
  });

  String? name;
  String? code;
  List<ReportReport>? report;

  factory VisitsDetailReport.fromJson(Map<String, dynamic> json) =>
      VisitsDetailReport(
        name: json["name"],
        code: json["code"],
        report: json["report"] == null
            ? null
            : List<ReportReport>.from(
                json["report"].map((x) => ReportReport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "report": report == null
            ? null
            : List<dynamic>.from(report!.map((x) => x.toJson())),
      };
}

class ReportReport {
  ReportReport({
    this.name,
    this.createdAt,
    this.physician,
  });

  String? name;
  String? createdAt;
  Physician? physician;

  factory ReportReport.fromJson(Map<String, dynamic> json) => ReportReport(
        name: json["name"],
        createdAt: json["created_at"],
        physician: json["physician"] == null
            ? null
            : Physician.fromJson(json["physician"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "created_at": createdAt,
        "physician": physician == null ? null : physician!.toJson(),
      };
}
