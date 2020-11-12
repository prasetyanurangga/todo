import 'package:flutter/material.dart';
import 'package:todo/constant.dart';
import 'package:todo/models/task.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({
    Key key,
    @required this.checkTask,
    @required this.color,
    @required this.press,
  }) : super(key: key);

  final CheckTask checkTask;
  final Color color;
  final Function press;

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool check = false;

  @override
  void initState() {
    super.initState();
    check = widget.checkTask.check;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPaddin * 2),
      child: FlatButton(
        padding: EdgeInsets.symmetric(
            vertical: kDefaultPaddin / 2, horizontal: kDefaultPaddin / 2),
        onPressed: () {
          setState(() {
            check = !check;
          });
        },
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: check,
                activeColor: widget.color,
                onChanged: (n) {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: kDefaultPaddin),
              child: Text(
                widget.checkTask.name,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.grey[700],
                    decoration: check
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
