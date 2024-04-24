final String tableName = 'movies';

class MovieFields {
  static final List<String> values = [
    id, title, description, addedTime
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String addedTime = 'time';
}

class Movie {
  final int? id;
  final String title;
  final String description;
  final DateTime addedTime;

  Movie({
    this.id,
    required this.title,
    required this.description,
    required this.addedTime
  });

  static Movie fromJson(Map<String, Object?> json) => Movie(
    id: json[MovieFields.id] as int?,
    title: json[MovieFields.title] as String,
    description: json[MovieFields.description] as String,
    addedTime: DateTime.parse(json[MovieFields.addedTime] as String),
  );

  Map<String, Object?> toJson() => {
    MovieFields.id: id,
    MovieFields.title: title,
    MovieFields.description: description,
    MovieFields.addedTime: addedTime.toIso8601String()
  };

  Movie copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Movie(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        addedTime: createdTime ?? this.addedTime,
      );
}