const String todoTable = "todo_notes";

class TodoFields {
  static final List<String> values = [
    id,
    name,
    description,
    location,
    time,
    color,
  ];

  static const String id = "_id";
  static const String name = "name";
  static const String description = "description";
  static const String location = "location";
  static const String time = "time";
  static const String date = 'date';
  static const String color = 'color';
}

class TodoModel {
  final int? id;
  final String? name;
  final String? description;
  final String? location;
  final String? time;
  final String? date;
  final String? color;

  TodoModel({
    this.id,
    this.name,
    this.description,
    this.location,
    this.time,
    this.date,
    this.color,
  });

  TodoModel copyWith({
    int? id,
    String? name,
    String? description,
    String? location,
    String? color,
    String? time,
    String? date,
  }) =>
      TodoModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        location: location ?? this.location,
        time: time ?? this.time,
        date: date ?? this.date,
        color: color ?? this.color,
      );

  Map<String, Object?> toJson() => {
        TodoFields.name: name,
        TodoFields.description: description,
        TodoFields.location: location,
        TodoFields.time: time,
        TodoFields.date: date,
        TodoFields.color: color,
      };

  static TodoModel fromJson(Map<String, Object?> json) => TodoModel(
        id: json[TodoFields.id] as int?,
        name: json[TodoFields.name] as String?,
        description: json[TodoFields.description] as String?,
        location: json[TodoFields.location] as String?,
        time: json[TodoFields.time] as String?,
        date: json[TodoFields.date] as String?,
        color: json[TodoFields.color] as String?,
      );
}
