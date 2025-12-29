import 'package:hive/hive.dart';

part 'project_db_model.g.dart';

@HiveType(typeId: 0)
class ProjectDb {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late List<String> technologies;

  @HiveField(4)
  late String projectUrl;

  @HiveField(5)
  late String? galleryUrl;

  @HiveField(6)
  late String? appDistributionUrl;

  @HiveField(7)
  late List<String> featureImagePaths;

  @HiveField(8)
  late DateTime dateAdded;

  @HiveField(9)
  late DateTime dateModified;

  @HiveField(10)
  late String? localImagePath;

  ProjectDb({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    required this.projectUrl,
    this.galleryUrl,
    this.appDistributionUrl,
    required this.featureImagePaths,
    required this.dateAdded,
    required this.dateModified,
    this.localImagePath,
  });

  /// Convert ProjectDb to JSON for API compatibility
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'technologies': technologies,
        'projectUrl': projectUrl,
        'galleryUrl': galleryUrl,
        'appDistributionUrl': appDistributionUrl,
        'featureImagePaths': featureImagePaths,
        'dateAdded': dateAdded.toIso8601String(),
        'dateModified': dateModified.toIso8601String(),
        'localImagePath': localImagePath,
      };

  /// Create ProjectDb from JSON
  factory ProjectDb.fromJson(Map<String, dynamic> json) => ProjectDb(
        id: json['id'] as String? ?? '',
        title: json['title'] as String,
        description: json['description'] as String,
        technologies: List<String>.from(json['technologies'] as List),
        projectUrl: json['projectUrl'] as String,
        galleryUrl: json['galleryUrl'] as String?,
        appDistributionUrl: json['appDistributionUrl'] as String?,
        featureImagePaths:
            List<String>.from(json['featureImagePaths'] as List? ?? []),
        dateAdded: json['dateAdded'] is DateTime
            ? json['dateAdded'] as DateTime
            : DateTime.parse(json['dateAdded'] as String),
        dateModified: json['dateModified'] is DateTime
            ? json['dateModified'] as DateTime
            : DateTime.parse(json['dateModified'] as String),
        localImagePath: json['localImagePath'] as String?,
      );

  /// Create a copy with modifications
  ProjectDb copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? technologies,
    String? projectUrl,
    String? galleryUrl,
    String? appDistributionUrl,
    List<String>? featureImagePaths,
    DateTime? dateAdded,
    DateTime? dateModified,
    String? localImagePath,
  }) {
    return ProjectDb(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      technologies: technologies ?? this.technologies,
      projectUrl: projectUrl ?? this.projectUrl,
      galleryUrl: galleryUrl ?? this.galleryUrl,
      appDistributionUrl: appDistributionUrl ?? this.appDistributionUrl,
      featureImagePaths: featureImagePaths ?? this.featureImagePaths,
      dateAdded: dateAdded ?? this.dateAdded,
      dateModified: dateModified ?? this.dateModified,
      localImagePath: localImagePath ?? this.localImagePath,
    );
  }
}
