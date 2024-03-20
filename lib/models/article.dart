import 'dart:convert';

class Article {
  late String description;
  late String file;
  late bool isPDF;
  late String title;
  late String type;

  Article({
    required this.description,
    required this.file,
    required this.isPDF,
    required this.title,
    required this.type,
  });

  Article copyWith({
    String? description,
    String? file,
    bool? isPDF,
    String? title,
    String? type,
  }) {
    return Article(
      description: description ?? this.description,
      file: file ?? this.file,
      isPDF: isPDF ?? this.isPDF,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'file': file,
      'isPDF': isPDF,
      'title': title,
      'type': type,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      description: map['description'] as String,
      file: map['file'] as String,
      isPDF: map['isPDF'] as bool,
      title: map['title'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Article(description: $description, file: $file, isPDF: $isPDF, title: $title, type: $type)';
  }

  @override
  bool operator ==(covariant Article other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.file == file &&
        other.isPDF == isPDF &&
        other.title == title &&
        other.type == type;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        file.hashCode ^
        isPDF.hashCode ^
        title.hashCode ^
        type.hashCode;
  }
}
