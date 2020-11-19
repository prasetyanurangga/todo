import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/constant.dart';
import 'package:todo/screens/component/custom_checkbox.dart';
import 'package:todo/screens/add_screen.dart';
import 'package:get/get.dart';
import 'package:todo/controller/checktask_controller.dart';

class DetailScreen extends StatelessWidget {
  final Task task1 = Get.arguments;
  final CheckTaskController  checkTaskController = Get.find<CheckTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.chevron_left, color: Colors.grey[700]),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey[700],
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "${task1.id}-fab",
        backgroundColor: task1.colors[1],
        onPressed: () {
          Get.toNamed("/addScreen", arguments: task1);
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: kDefaultPaddin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kDefaultPaddin),
                      child: Hero(
                        tag: "${task1.id}-icon",
                        child: task1.icon,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: kDefaultPaddin / 4),
                          child: Hero(
                            tag: "${task1.id}-count",
                            child: Text(
                              task1.countTask.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                        Hero(
                          tag: "${task1.id}-task",
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
                      tag: "${task1.id}-name",
                      child: Text(
                        task1.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.grey[700]),
                      ),
                    ),
                    Hero(
                      tag: "${task1.id}-bar",
                      child: Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: task1.progress,
                              backgroundColor: Colors.grey[400],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  task1.colors[1]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: kDefaultPaddin),
                            child: Text(
                              "${task1.percen}%",
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
              SizedBox(
                height: kDefaultPaddin,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultPaddin,
                  bottom: kDefaultPaddin / 2,
                  left: kDefaultPaddin * 2,
                  right: kDefaultPaddin * 2,
                ),
                child: Text(
                  "Today",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.grey[700]),
                ),
              ),
              Obx((){
                return Column(
                  children: [
                    for (var i in checkTaskController.checkTaskModelList)
                      CustomCheckbox(checkTask: i, color: task1.colors[1]),
                  ],
                );
              }),
              SizedBox(
                height: kDefaultPaddin,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: kDefaultPaddin,
              //     bottom: kDefaultPaddin / 2,
              //     left: kDefaultPaddin * 2,
              //     right: kDefaultPaddin * 2,
              //   ),
              //   child: Text(
              //     "Tomorrow",
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodyText1
              //         .copyWith(color: Colors.grey[700]),
              //   ),
              // ),
              // Column(
              //   children: [
              //     for (var i in task1.tomorrow)
              //       CustomCheckbox(checkTask: i, color: task1.colors[1]),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
