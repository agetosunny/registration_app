class Student{
  String name;
  String course;
  Student(this.name,this.course);

  Map<String,dynamic> toJson(){
    return {
      "name": name,
      "course": course,
    };
  }

  factory Student.fromJson(Map<String,dynamic> json){
    return Student(
      json["name"], 
      json["course"]);
  }
}