import 'package:flutter/material.dart';
import 'package:todo/constant.dart';
import 'package:todo/models/task.dart';
import 'package:todo/controller/checktask_controller.dart';
import 'package:get/get.dart';

class TaskCard extends StatelessWidget {
  TaskCard({
    Key key,
    @required this.size,
    @required this.task,
    @required this.press,
    @required this.swipe,
  }) : super(key: key);

  final Size size;
  final Task task;
  final Function press, swipe;

  CheckTaskController checkTaskController = Get.find<CheckTaskController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      onPanUpdate: swipe,
      child: Container(
        margin: EdgeInsets.only(
          right: kDefaultPaddin / 2,
          left: kDefaultPaddin / 2,
          top: kDefaultPaddin,
          bottom: kDefaultPaddin,
        ),
        child: Stack(
          children : [
            Hero(
              tag: "${task.id}-background",
              child: Container(
                width: size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      offset: Offset(0, 5),
                      blurRadius: 15.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                )
              )
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Container(
                padding: EdgeInsets.all(kDefaultPaddin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: "${task.id}-icon",
                          child: icons[task.icon],
                        ),
                        Container(),
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
                                  task.countAll.toString(),
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
                              value: (task.countAll == 0 || task.countChecked == 0) ? 0.0 : (task.countChecked / task.countAll),
                              backgroundColor: Colors.grey[400],
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(backColor[task.color][1]),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                                width: kDefaultPaddin * 1.8,
                            margin: EdgeInsets.only(left: kDefaultPaddin),
                            child: Text(
                              (task.countAll == 0 || task.countChecked == 0) ? "0 %" : "${((task.countChecked / task.countAll) * 100).toStringAsFixed(0)}%",
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
            )
          ]
        ),
      ),
    );
  }
}
