import 'package:flutter/material.dart';
import 'package:todo/constant.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/component/task_card.dart';
import 'package:todo/screens/detail_screen.dart';
import 'package:get/get.dart';
import 'package:todo/controller/checktask_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageScroll =
      PageController(viewportFraction: 0.85, keepPage: true);
  List<Color> currentColor = backColor[0];

  final checkTaskController = Get.put(CheckTaskController());
  String greeting(){
    var hour  = DateTime.now().hour;
    print(hour);
    if(hour < 12){
      return "Morning";
    }else if(hour < 17){
      return "Afternoon";
    }else{
      return "Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: currentColor
        ),
      ),
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text("TODO"),
          ),
          body: SingleChildScrollView( 
            child :Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPaddin * 2,
                    vertical: kDefaultPaddin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPaddin),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.35),
                                  offset: Offset(0, 5),
                                  blurRadius: 15.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/images/avatar.jpg"),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Good ${greeting()}, Sofi",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPaddin),
                        child: Text(
                          "You like feel good\nYou have ${checkTaskController.countTodoToday} tasks to do today",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w100),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: kDefaultPaddin),
                        child: Obx(() => Text(
                            "Today, ${checkTaskController.dateNow}",
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.white, fontWeight: FontWeight.w100),
                          ))
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Obx((){
                        return PageView.builder(
                          allowImplicitScrolling: true,
                          controller: _pageScroll,
                          itemCount: checkTaskController.taskModelList.length,
                          onPageChanged: (index){
                            setState(() {
                              currentColor = backColor[index];
                            });
                          },
                          itemBuilder: (context, index) {
                            return TaskCard(
                              size: size,
                              task: checkTaskController.taskModelList[index],
                              press: () {
                                checkTaskController.getCheckTask(checkTaskController.taskModelList[index].id);
                                checkTaskController.getTaskById(checkTaskController.taskModelList[index].id);
                                Get.toNamed("/detailScreen", arguments: checkTaskController.taskModelList[index]);
                              },
                            );
                          },
                        );
                    })
                  ),
                )
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}
