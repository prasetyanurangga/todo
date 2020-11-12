import 'package:flutter/material.dart';
import 'package:todo/constant.dart';
import 'package:todo/models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key key,
    @required this.size,
    @required this.task,
    @required this.press,
    @required this.swipe,
  }) : super(key: key);

  final Size size;
  final Task task;
  final Function press, swipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      onPanUpdate: swipe,
      child: Container(
        margin: EdgeInsets.only(
          right: kDefaultPaddin,
          top: kDefaultPaddin,
          bottom: kDefaultPaddin,
        ),
        child: SizedBox(
          width: size.width * 0.8,
          child: Container(
            padding: EdgeInsets.all(kDefaultPaddin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[900].withOpacity(0.30),
                  offset: Offset(0, 10),
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "${task.id}-icon",
                      child: task.icon,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: task.colors[1],
                    ),
                  ],
                ),
                SizedBox(height: 200),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: kDefaultPaddin / 4),
                      child: Hero(
                        tag: "${task.id}-count",
                        child: Text(
                          task.countTask.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey[700]),
                        ),
                      ),
                    ),
                    Hero(
                      tag: "${task.id}-task",
                      child: Text(
                        "Task",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
                Hero(
                  tag: "${task.id}-name",
                  child: Text(
                    task.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.grey[700]),
                  ),
                ),
                Hero(
                  tag: "${task.id}-bar",
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: task.progress,
                          backgroundColor: Colors.grey[400],
                          valueColor:
                              AlwaysStoppedAnimation<Color>(task.colors[1]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: kDefaultPaddin),
                        child: Text(
                          "${task.percen}%",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
