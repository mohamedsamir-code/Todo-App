import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/AppConfigProvider.dart';
import 'package:todo_app/data/FireStoreUtils.dart';
import 'package:todo_app/data/Todo.dart';

import 'Edit_List_Widget.dart';

class Todo_Widget extends StatefulWidget {
  Todo item;
  var formKey = GlobalKey<FormState>();

  Todo_Widget(this.item, {super.key});

  @override
  State<Todo_Widget> createState() => _Todo_WidgetState();
}

class _Todo_WidgetState extends State<Todo_Widget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: [
        IconSlideAction(
          color: Colors.transparent,
          iconWidget: Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.delete,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          onTap: () {
            deleteTodo(widget.item)
                .then((value) {
                  Fluttertoast.showToast(
                      msg: "Task deleted successfully",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      backgroundColor: Colors.green,
                      fontSize: 16.0);
                })
                .onError((error, stackTrace) {})
                .timeout(Duration(seconds: 10), onTimeout: () {});
          },
        ),
        IconSlideAction(
          color: Colors.transparent,
          iconWidget: Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.edit,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          onTap: () {
            updateTodo(widget.item, context, widget.item.title,
                    widget.item.description)
                .then((value) {
                  Fluttertoast.showToast(
                      msg: "Task edited successfully",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      backgroundColor: Colors.green,
                      fontSize: 16.0);
                })
                .onError((error, stackTrace) {})
                .timeout(Duration(seconds: 10), onTimeout: () {});
          },
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: provider.isDarkMode()
                ? Color.fromARGB(255, 20, 25, 34)
                : Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            )),
        child: Row(
          children: [
            Container(
              width: 3,
              height: 70,
              margin: EdgeInsets.symmetric(vertical: 12),
              color: widget.item.isDone
                  ? Colors.green
                  : Theme.of(context).primaryColor,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Edit_List_Widget.routeName,
                          arguments: widget.item);
                    },
                    child: Text(
                      widget.item.title,
                      style: widget.item.isDone
                          ? Theme.of(context).textTheme.displaySmall
                          : Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  Text(
                    widget.item.description,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            )),
            InkWell(
                onTap: () => editDone(widget.item),
                child: widget.item.isDone
                    ? Text(
                        'Done!',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            color: widget.item.isDone
                                ? Colors.green
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Image.asset(
                          'assets/image/ic_check.png',
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
