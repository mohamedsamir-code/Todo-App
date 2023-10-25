import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/AppConfigProvider.dart';
import 'package:todo_app/Ui/Home/List_Tap/todo_ListTap.dart';
import 'package:todo_app/Ui/Home/Settings_Tap/todo_SittingsTap.dart';

import '../../My_Theme_Data.dart';
import 'Add_Widget/AddTodoWidget.dart';

class HomeScrean extends StatefulWidget {
  static const String routeName = 'Home';

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(gett()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        shape: StadiumBorder(
            side: BorderSide(
                color: provider.isDarkMode()
                    ? MyThemeData.darkScaffildBackground
                    : Colors.white,
                width: 4)),
        onPressed: () {
          showAddTodoSheet();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: BottomNavigationBar(
          unselectedItemColor:
              provider.isDarkMode() ? Colors.white : Colors.grey,
          backgroundColor: provider.isDarkMode()
              ? MyThemeData.darkScaffildBackground
              : Colors.white,
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          elevation: 0.0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(label: '', icon: Icon(Icons.settings))
          ],
        ),
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
      ),
      body: Stack(children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
        ),
        tabs[currentIndex]
      ]),
    );
  }

  String gett() {
    if (currentIndex == 0) {
      return AppLocalizations.of(context)!.appbarlist;
    }
    return AppLocalizations.of(context)!.appbarset;
  }

  List<Widget> tabs = [
    TodoListApp(),
    TodoSettingsTpp(),
  ];

  void showAddTodoSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return AddTodoWidget();
        });
  }
}
