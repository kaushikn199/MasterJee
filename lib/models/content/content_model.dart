class ContentModel {
  final String id;
  final String? classId;
  final String? sectionId;
  final String? subjectId;
  final String? lessonId;
  final String realName;
  final String fileType;
  final String? fileUrl;
  final String? vidUrl;
  final String? frameUrl;
  final String? thumbPath;
  final String? thumbName;
  final String? imgName;

  ContentModel({
    required this.id,
    required this.realName,
    required this.fileType,
    this.classId,
    this.sectionId,
    this.subjectId,
    this.lessonId,
    this.fileUrl,
    this.vidUrl,
    this.frameUrl,
    this.thumbPath,
    this.thumbName,
    this.imgName,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'],
      classId: json['class_id'],
      sectionId: json['section_id'],
      subjectId: json['subject_id'],
      lessonId: json['lesson_id'],
      realName: json['real_name'] ?? '',
      fileType: json['file_type'] ?? '',
      fileUrl: json['fileUrl'],
      vidUrl: json['vid_url'],
      frameUrl: json['frameUrl'],
      thumbPath: json['thumb_path'],
      thumbName: json['thumb_name'],
      imgName: json['img_name'],
    );
  }
}
