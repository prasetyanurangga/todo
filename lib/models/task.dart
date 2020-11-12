import 'package:flutter/material.dart';
import 'package:todo/constant.dart';

class Task {
  final int id, countTask, percen;
  final String name;
  final Icon icon;
  final List<Color> colors;
  final double progress;
  final List<CheckTask> today, tomorrow;

  Task({
    this.today,
    this.tomorrow,
    this.id,
    this.name,
    this.icon,
    this.colors,
    this.progress,
    this.countTask,
    this.percen,
  });
}

class CheckTask {
  final int id;
  final String name;
  final bool check;

  CheckTask({
    this.id,
    this.name,
    this.check,
  });
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
      tomorrow: [
        CheckTask(
          id: 1,
          name: "Meet Client",
          check: true,
        ),
        CheckTask(
          id: 2,
          name: "Meet Boyfriend",
          check: false,
        ),
        CheckTask(
          id: 3,
          name: "Watch Anime",
          check: true,
        ),
        CheckTask(
          id: 4,
          name: "Watch Drakor",
          check: true,
        ),
      ],
      today: [
        CheckTask(
          id: 1,
          name: "Meet Client",
          check: true,
        ),
        CheckTask(
          id: 2,
          name: "Meet Boyfriend",
          check: false,
        ),
        CheckTask(
          id: 3,
          name: "Watch Anime",
          check: true,
        ),
        CheckTask(
          id: 4,
          name: "Watch Drakor",
          check: true,
        ),
      ]),
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
      tomorrow: [
        CheckTask(
          id: 1,
          name: "Meet Client",
          check: true,
        ),
        CheckTask(
          id: 2,
          name: "Meet Boyfriend",
          check: false,
        ),
        CheckTask(
          id: 3,
          name: "Watch Anime",
          check: true,
        ),
        CheckTask(
          id: 4,
          name: "Watch Drakor",
          check: true,
        ),
      ],
      today: [
        CheckTask(
          id: 1,
          name: "Meet Client",
          check: true,
        ),
        CheckTask(
          id: 2,
          name: "Meet Boyfriend",
          check: false,
        ),
        CheckTask(
          id: 3,
          name: "Watch Anime",
          check: true,
        ),
        CheckTask(
          id: 4,
          name: "Watch Drakor",
          check: true,
        ),
      ]),
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
      tomorrow: [
        CheckTask(
          id: 1,
          name: "Meet Client",
          check: true,
        ),
        CheckTask(
          id: 2,
          name: "Meet Boyfriend",
          check: false,
        ),
        CheckTask(
          id: 3,
          name: "Watch Anime",
          check: true,
        ),
        CheckTask(
          id: 4,
          name: "Watch Drakor",
          check: true,
        ),
      ],
      today: [
        CheckTask(
          id: 1,
          name: "Meet Client",
          check: true,
        ),
        CheckTask(
          id: 2,
          name: "Meet Boyfriend",
          check: false,
        ),
        CheckTask(
          id: 3,
          name: "Watch Anime",
          check: true,
        ),
        CheckTask(
          id: 4,
          name: "Watch Drakor",
          check: true,
        ),
      ]),
];
