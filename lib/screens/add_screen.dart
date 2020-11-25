import 'package:flutter/material.dart';
import 'package:todo/constant.dart';
import 'package:todo/models/task.dart';
import 'package:get/get.dart';
import 'package:todo/controller/checktask_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
  String choose = "Today";

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
                        child: icons[task.icon],
                      ),
                      SizedBox(width: 20),
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
                            color: backColor[task.color][1]),
                      ),
                      // Text(
                      //   "Today",
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .bodyText1
                      //       .copyWith(color: Colors.grey[700]),
                      // ),
                      SizedBox(width: 20),
                      Expanded(
                          child : DropdownButton(
                            isExpanded: true,
                            underline: SizedBox(),
                            // icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                            value: choose,
                            items: [
                              'Today',
                              'Tomorrow'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value, 
                                  style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.grey[700])),
                              );
                            }).toList(),
                            onChanged: (value) {
                                setState((){
                                    choose = value;
                                });
                            },
                          ),
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
                      await checkTaskController.addCheckTask(task.id, choose);
                      checkTaskController.getCheckTask(task.id);
                      checkTaskController.getTaskById(task.id);
                      checkTaskController.getCountTodoToday();
                      checkTaskController.getTaskAll();
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
                      backColor[task.color][0],
                      backColor[task.color][1],
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
