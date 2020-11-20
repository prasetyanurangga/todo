import 'package:flutter/material.dart';
import 'package:todo/constant.dart';
import 'package:todo/models/task.dart';
import 'package:todo/controller/checktask_controller.dart';
import 'package:get/get.dart';

class CustomCheckbox extends StatelessWidget {
  CustomCheckbox({
    Key key,
    @required this.checkTask,
    @required this.color,
  }) : super(key: key);

  
  final CheckTask checkTask;
  final Color color;

  CheckTaskController  checkTaskController = Get.find<CheckTaskController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPaddin * 2),
      child: FlatButton(
        padding: EdgeInsets.symmetric(
            vertical: kDefaultPaddin / 2, horizontal: kDefaultPaddin / 2),
        onPressed: () async {
           await checkTaskController.updateCheckTask(
              CheckTask(
                idTask: checkTask.idTask,
                id:checkTask.id,
                name: checkTask.name,
                checked: checkTask.checked == 0 ? 1 : 0,
                createdAt: checkTask.createdAt,
              )
           );
           checkTaskController.getTaskById(checkTask.idTask);
           checkTaskController.getTaskAll();
        },
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: checkTask.checked == 0 ? false : true,
                activeColor: color,
                onChanged:  (n) async {
                  print(checkTask.createdAt);
                   await checkTaskController.updateCheckTask(
                      CheckTask(
                        idTask: checkTask.idTask,
                        id:checkTask.id,
                        name: checkTask.name,
                        checked: checkTask.checked == 0 ? 1 : 0,
                        createdAt: checkTask.createdAt,
                      )
                   );
                   checkTaskController.getTaskById(checkTask.idTask);
                    checkTaskController.getTaskAll();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: kDefaultPaddin),
              child: Text(
                checkTask.name,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.grey[700],
                    decoration: checkTask.checked == 1
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
