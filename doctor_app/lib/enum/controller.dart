class Task{
  int id;
  String title;
  String description;
  String duration;
  bool is_pinned;
  String date;
  String color;
  Task({
   required this.id,
   required this.title,
   required this.description,
   required this.duration,
   required this.is_pinned,
   required this.date,
   required this.color,
  });

factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        duration: json["duration"],
        is_pinned: json["is_pinned"],
        date: json["date"],
        color: json["color"],
      );







}