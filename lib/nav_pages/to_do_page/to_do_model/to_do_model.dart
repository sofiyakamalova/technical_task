class ToDoModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  ToDoModel(this.userId, this.id, this.title, this.completed);

  ToDoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }
}
