class Physician {
  final String? name;
  final String? profilePic;
  final String? facilityName;

  final String? primary;
  final String? revoke;
  final bool? isRevoke;

  Physician(this.name, this.profilePic, this.facilityName, this.primary,
      this.revoke, this.isRevoke);

  factory Physician.fromJson(Map<String, dynamic> json) {
    return Physician(json['name'], json['profilePic'], json['facilityName'],
        json['primary'], json['revoke'], json['isRevoke']);
  }
}
