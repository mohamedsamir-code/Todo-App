import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/My_Theme_Data.dart';
import 'package:todo_app/Provider/AppConfigProvider.dart';
import 'package:todo_app/data/FireStoreUtils.dart';
import 'package:todo_app/data/Todo.dart';

class Edit_List_Widget extends StatefulWidget {
  static const String routeName = 'Edit';

  const Edit_List_Widget({super.key});

  @override
  State<Edit_List_Widget> createState() => _Edit_List_WidgetState();
}

class _Edit_List_WidgetState extends State<Edit_List_Widget> {
  DateTime selectedDate = DateTime.now();

  late Todo item;

  @override
  Widget build(BuildContext context) {
    item = ModalRoute.of(context)!.settings.arguments as Todo;
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(AppLocalizations.of(context)!.appbarlist),
      ),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
                color: provider.isDarkMode()
                    ? MyThemeData.darkContairnerBackground
                    : Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      AppLocalizations.of(context)!.edit,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      initialValue: item.title,
                      onChanged: (text) {
                        item.title = text;
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
                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      initialValue: item.description,
                      onChanged: (text) {
                        item.description = text;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: provider.isDarkMode()
                            ? MyThemeData.darkScaffildBackground
                            : Colors.white,
                        labelText: AppLocalizations.of(context)!.description,
                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: provider.isDarkMode()
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      maxLines: 4,
                      minLines: 4,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      AppLocalizations.of(context)!.selectTime,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  InkWell(
                    onTap: () => showUpdateDateDialge(),
                    child: Padding(
                      padding: const EdgeInsets.all(11),
                      child: Text(
                        '${item.dateTime.day} / ${item.dateTime.month} / ${item.dateTime.year}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: provider.isDarkMode()
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(50, 50),
                      ),
                      onPressed: () {
                        editTask(item);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void editTask(Todo item) {
    editTaskItem(item).then((value) {
      Navigator.pop(context);
    });
  }

  void showUpdateDateDialge() async {
    var newselected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (newselected != null) {
      selectedDate = newselected;
      item.dateTime = newselected;
      setState(() {});
    }
  }
}
