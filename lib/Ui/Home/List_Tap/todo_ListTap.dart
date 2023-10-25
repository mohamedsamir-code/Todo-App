import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/data/FireStoreUtils.dart';
import 'package:todo_app/data/Todo.dart';

import 'Todo_Widget.dart';

class TodoListApp extends StatefulWidget {
  @override
  State<TodoListApp> createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            child: TableCalendar(
              selectedDayPredicate: (day) {
                return isSameDay(day, selectedDay);
              },
              onDaySelected: (sDay, fDay) {
                setState(() {
                  selectedDay = sDay;
                  focusedDay = fDay; // update `_focusedDay` here as well
                });
              },
              calendarFormat: CalendarFormat.week,
              firstDay: DateTime.now().subtract(Duration(days: 365)),
              lastDay: DateTime.now().add(Duration(days: 365)),
              focusedDay: focusedDay,
              calendarStyle: CalendarStyle(
                selectedTextStyle: TextStyle(color: Colors.white),
                selectedDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                todayTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(8)),
                defaultDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                defaultTextStyle: TextStyle(color: Colors.black),
              ),
              headerStyle: HeaderStyle(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ))),
              weekendDays: [],
              daysOfWeekStyle: DaysOfWeekStyle(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )),
                weekdayStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<Todo>>(
            stream: getTodosCollectionWithConverter()
                .where('dateTime',
                    isEqualTo: selectedDay.getDateOnly().millisecondsSinceEpoch)
                .snapshots(),
            builder: (BuildContext buildContext,
                AsyncSnapshot<QuerySnapshot<Todo>> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                // loading
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<Todo> items =
                  snapshot.data!.docs.map((doc) => doc.data()).toList();
              return ListView.builder(
                itemBuilder: (buildContext, index) {
                  return Todo_Widget(items[index]);
                },
                itemCount: items.length,
              );
            },
          ))
        ],
      ),
    );
  }
}
