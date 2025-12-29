class ProjectDb {
  String id;
  String title;
  String description;
  List<String> technologies;
  String projectUrl;
  String? galleryUrl;
  String? appDistributionUrl;
  List<String> featureImagePaths;
  DateTime dateAdded;
  DateTime dateModified;
  String? localImagePath;

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
