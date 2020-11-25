import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/constant.dart';
import 'package:todo/screens/component/custom_checkbox.dart';
import 'package:todo/screens/add_screen.dart';
import 'package:get/get.dart';
import 'package:todo/controller/checktask_controller.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:intl/intl.dart';


class DetailScreen extends StatelessWidget {
  final Task task1 = Get.arguments;
  final CheckTaskController  checkTaskController = Get.find<CheckTaskController>();
  final newFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Hero(
          tag: "${task1.id}-background",
          child: Container(
            color: Colors.white,
            height: size.height,
            width: size.width,
          )
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.chevron_left, color: Colors.grey[700]),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "${task1.id}-fab",
            backgroundColor: backColor[task1.color][1],
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
                            child: icons[task1.icon],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: kDefaultPaddin / 4),
                              child: Hero(
                                tag: "${task1.id}-count",
                                child: Obx((){
                                  return Text(
                                    checkTaskController.taskModel.value.countAll.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.grey[700]),
                                  );
                                }),
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
                                child: Obx(() { 
                                  return FAProgressBar(
                                    currentValue: (checkTaskController.taskModel.value.countChecked == 0) ? 0 : checkTaskController.taskModel.value.countChecked,
                                    animatedDuration :  const Duration(milliseconds: 300),
                                    direction : Axis.horizontal,
                                    borderRadius : 0,
                                    backgroundColor : Colors.grey[400],
                                    progressColor : backColor[task1.color][1],
                                    maxValue: (checkTaskController.taskModel.value.countAll == 0) ? 100 : checkTaskController.taskModel.value.countAll,
                                    size: 5,
                                  );
                                })
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: kDefaultPaddin * 1.8,
                                margin: EdgeInsets.only(left: kDefaultPaddin),
                                child: Obx((){
                                  return Text(
                                    (checkTaskController.taskModel.value.countAll == 0 || checkTaskController.taskModel.value.countChecked == 0) ? "0 %" : "${((checkTaskController.taskModel.value.countChecked / checkTaskController.taskModel.value.countAll) * 100).toStringAsFixed(0)}%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.grey[700]),
                                  );
                                })
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

                    var dateNow = newFormat.format(DateTime.now()); 
                    var checkList = checkTaskController.checkTaskModelList.where((i) => (i.createdAt == dateNow)).toList();
                    return Column(
                      children: [
                        for (var i in checkList)
                          CustomCheckbox(checkTask: i, color: backColor[task1.color][1]),
                      ],
                    );
                  }),
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
                      "Tomorrow",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey[700]),
                    ),
                  ),
                  Obx((){

                    var dateNow = newFormat.format(DateTime.now()); 
                    var checkList = checkTaskController.checkTaskModelList.where((i) => (i.createdAt != dateNow)).toList();
                    return Column(
                      children: [
                        for (var i in checkList)
                          CustomCheckbox(checkTask: i, color: backColor[task1.color][1]),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        )
      ]
    );
  }
}
