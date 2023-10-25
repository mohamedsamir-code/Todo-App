import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/My_Theme_Data.dart';
import 'package:todo_app/Provider/AppConfigProvider.dart';
import 'package:todo_app/data/FireStoreUtils.dart';

class AddTodoWidget extends StatefulWidget {
  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  var formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title = '';
  String descreption = '';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.isDarkMode()
          ? MyThemeData.darkScaffildBackground
          : Colors.white,
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.addnewask,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (text) {
                      title = text;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: provider.isDarkMode()
                                  ? Colors.white
                                  : Colors.black)),
                      fillColor: provider.isDarkMode()
                          ? MyThemeData.darkScaffildBackground
                          : Colors.white,
                      labelText: AppLocalizations.of(context)!.title,
                      labelStyle: Theme.of(context).textTheme.displayMedium,
                    ),
                    validator: (textValue) {
                      if (textValue == null || textValue.isEmpty) {
                        return 'please enter todo title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (text) {
                      descreption = text;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: provider.isDarkMode()
                                    ? Colors.white
                                    : Colors.black)),
                        fillColor: provider.isDarkMode()
                            ? MyThemeData.darkScaffildBackground
                            : Colors.white,
                        labelText: AppLocalizations.of(context)!.description,
                        labelStyle: Theme.of(context).textTheme.displayMedium),
                    maxLines: 4,
                    minLines: 4,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter todo description';
                      }
                      return null;
                    },
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.date,
              style: TextStyle(
                color: provider.isDarkMode() ? Colors.white : Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: () => showDateDialge(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: provider.isDarkMode() ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              addTodo();
            },
            child: Text(
              AppLocalizations.of(context)!.add,
            ),
          )
        ],
      ),
    );
  }

  void addTodo() {
    //1-get title & discreption
    //2- select date
    //3- create todo and added to data base
    if (!formkey.currentState!.validate()) {
      return;
    }
    // if valid then insert new todo item
    addTodoToFirstore(title, descreption, selectedDate).then((value) {
      Fluttertoast.showToast(
          msg: "Task added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.green,
          fontSize: 16.0);
      //todo adeed successfully
      //add tost to show todo adedd successfully
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      print(error.toString());
    }).timeout(Duration(seconds: 10), onTimeout: () {
      print('timeout');

      //show dialog //can`t Connect to server
    });
  }

  void showDateDialge() async {
    var newnewSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (newnewSelectedDate != null) {
      selectedDate = newnewSelectedDate;
      setState(() {});
    }
  }
}
