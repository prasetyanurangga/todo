import 'package:flutter/material.dart';
import 'package:todo/constant.dart';

class Task {
  final int id, countAll, countChecked, countUnchecked, icon, colors;
  final String name;

  Task({
    this.id,
    this.name,
    this.icon,
    this.colors,
    this.countAll,
    this.countChecked,
    this.countUnchecked,
  });

  CheckTask.fromJson(Map<String, dynamic> json){
    id                = json['id'];
    name              = json['name'];
    countAll          = json['count_all'];
    countChecked      = json['count_checked'];
    countUnchecked    = json['count_unchecked'];
    color             = json['color_task'];
    icon              = json['icon_task'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['count_all'] = this.countAll;
    data['count_checked'] = this.countChecked;
    data['count_unchecked'] = this.countUnchecked;
    data['color_task'] = this.color;
    data['icon_task'] = this.icon;
    return data;
  }

}

class CheckTask {
  int idTask;
  int id;
  String name;
  int checked;

  CheckTask({
    this.id,
    this.idTask,
    this.name,
    this.checked,
  });

  CheckTask.fromJson(Map<String, dynamic> json){
    id       = json['id'];
    idTask   = json['id_task'];
    name     = json['name'];
    checked    = json['checked'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']      = this.id;
    data['id_task'] = this.idTask;
    data['name']    = this.name;
    data['checked']   = this.checked;
    return data;
  }

}

List<Task> tasks = [
  Task(
    id: 1,
    countTask: 9,
    name: "Personal",
    icon: Icon(
      Icons.person,
      color: backColor[0][1],
    ),
    colors: backColor[0],
    progress: 0.9,
    percen: 90,
  ),
  Task(
    id: 2,
    countTask: 10,
    name: "Work",
    icon: Icon(
      Icons.mail,
      color: backColor[1][1],
    ),
    colors: backColor[1],
    progress: 0.8,
    percen: 80,
  ),
  Task(
    id: 3,
    countTask: 19,
    name: "Home",
    icon: Icon(
      Icons.home,
      color: backColor[2][1],
    ),
    colors: backColor[2],
    progress: 0.5,
    percen: 50,
  ),
];
