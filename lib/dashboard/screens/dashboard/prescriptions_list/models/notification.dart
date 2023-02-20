class PrescriptionModel {
  final String name;
  final String profilePic;
  final String content;
  final String postImage;
  final String timeAgo;
  final bool hasStory;

  PrescriptionModel(
    this.name, 
    this.profilePic, 
    this.content, 
    this.postImage, 
    this.timeAgo, 
    this.hasStory
  );

  factory PrescriptionModel .fromJson(Map<String, dynamic> json) {
    return PrescriptionModel (
      json['name'],
      json['profilePic'],
      json['content'],
      json['postImage'],
      json['timeAgo'],
      json['hasStory']
    );
  }
}
