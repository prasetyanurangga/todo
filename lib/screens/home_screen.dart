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
      PageController(viewportFraction: 0.8, keepPage: true, initialPage: 1);
  Color currentColor1 = backColor[0][0];
  Color currentColor2 = backColor[0][1];

  final checkTaskController = Get.put(CheckTaskController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            currentColor1,
            currentColor2,
          ],
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
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Container(
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
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  color: kShadowColor,
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
                        "Hello, Sofi",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPaddin),
                        child: Text(
                          "You like feel good\nYou have 3 tasks to do today",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w100),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: kDefaultPaddin),
                        child: Text(
                          "Today, 11 November 2020",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w100),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: NotificationListener(
                      onNotification: (notification) {
                        if (notification is ScrollUpdateNotification) {
                          print(_pageScroll.page);
                          if (_pageScroll.page <= 1.4 &&
                              _pageScroll.page > 0.5) {
                            setState(() {
                              currentColor1 = tasks[1].colors[0];
                              currentColor2 = tasks[1].colors[1];
                            });
                          } else if (_pageScroll.page <= 2.0 &&
                              _pageScroll.page > 1.5) {
                            setState(() {
                              currentColor1 = tasks[2].colors[0];
                              currentColor2 = tasks[2].colors[1];
                            });
                          } else {
                            setState(() {
                              currentColor1 = tasks[0].colors[0];
                              currentColor2 = tasks[0].colors[1];
                            });
                          }
                          // print("kedua-1 : ${(size.width * 0.8) - 30}");
                          // print("kedua-2 : ${(size.width * 0.8) + 30}");
                          // print("ketiga-1 : ${((size.width * 0.8)) + 31}");
                          // print("ketiga-2 : ${((size.width * 0.8) * 2) + 30}");
                        }
                        return true;
                      },
                      child: PageView.builder(
                        controller: _pageScroll,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            size: size,
                            task: tasks[index],
                            press: () {
                              checkTaskController.getCheckTask(tasks[index].id);
                              Get.toNamed("/detailScreen", arguments: tasks[index]);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
