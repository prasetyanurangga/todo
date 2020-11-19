import 'package:flutter/material.dart';
import 'package:todo/constant.dart';
import 'package:todo/models/task.dart';
import 'package:get/get.dart';
import 'package:todo/controller/checktask_controller.dart';


class AddScreen extends StatefulWidget {
  AddScreen({
    Key key
  }) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool check = false;
  Task task;

  final CheckTaskController  checkTaskController = Get.find<CheckTaskController>();

  @override
  void initState() {
    super.initState();
    task = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "New Task",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.grey[700]),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.clear, color: Colors.grey),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What task are you planning to perform?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey[700]),
                  ),
                  TextField(
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.grey[700],
                        ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    autofocus: true,  
                    controller:  checkTaskController.contentTextController,  
                  
                  ),
                  SizedBox(height: kDefaultPaddin * 2),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: kDefaultPaddin / 4),
                        child: task.icon,
                      ),
                      Text(
                        task.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPaddin),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: kDefaultPaddin / 4),
                        child: Icon(Icons.calendar_today,
                            color: task.colors[1]),
                      ),
                      Text(
                        "Today",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Hero(
            tag: "${task.id}-fab",
            child: SizedBox(
              height: 80,
              child: Container(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      await checkTaskController.addCheckTask(task.id);
                      checkTaskController.getCheckTask(task.id);
                      Get.back();
                    },
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      task.colors[0],
                      task.colors[1],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
