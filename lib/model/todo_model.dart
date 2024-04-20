class TodoModel{
  String? id;
  String title;
  String description;
  String email;
  TodoModel({this.id,required this.email,required this.description,required this.title});
  factory TodoModel.fromJson(Map<String,dynamic>json){
    return TodoModel(
        email: json["email"],
        description: json['description'],
        title: json['title']);
  }
}