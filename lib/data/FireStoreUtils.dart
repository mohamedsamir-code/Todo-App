// related functions to firstore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/Provider/AppConfigProvider.dart';
import 'package:todo_app/data/Todo.dart';

import '../My_Theme_Data.dart';

var provider = AppConfigProvider();
var formkey = GlobalKey<FormState>();

extension MyDateExtension on DateTime {
  DateTime getDateOnly() {
    return DateTime(this.year, this.month, this.day);
  }
}

CollectionReference<Todo> getTodosCollectionWithConverter() {
  return FirebaseFirestore.instance
      .collection(Todo.collectionName)
      .withConverter<Todo>(
          fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
          toFirestore: (item, _) => item.toJson());
}

Future<void> addTodoToFirstore(
    String title, String description, DateTime time) {
  CollectionReference<Todo> collectionReference =
      getTodosCollectionWithConverter();
  DocumentReference<Todo> docRef = collectionReference.doc();

  Todo item = Todo(
      id: docRef.id,
      title: title,
      description: description,
      dateTime: time.getDateOnly());
  return docRef.set(item);
}

Future<void> deleteTodo(Todo item) {
  CollectionReference<Todo> collectionReference =
      getTodosCollectionWithConverter();
  DocumentReference<Todo> itemDoc = collectionReference.doc(item.id);
  return itemDoc.delete();
}

Future updateTodo(
    Todo item, BuildContext context, String title, String description) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Form(
        key: formkey,
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.edit,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: 20,
            ),
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
                description = text;
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
            ElevatedButton(
              onPressed: () {
                deleteTodo(item);
                addTodoToFirstore(title, description, DateTime.now());
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.edit,
              ),
            ),
          ],
        ),
      );
    },
  );
}

void editDone(Todo item) {
  CollectionReference todoRef = getTodosCollectionWithConverter();
  todoRef.doc(item.id).update({'isDone': item.isDone ? false : true});
}

Future<void> editTaskItem(Todo item) async {
  CollectionReference todoRef = getTodosCollectionWithConverter();
  return todoRef.doc(item.id).update({
    'title': item.title,
    'description': item.description,
    'dateTime': item.dateTime.getDateOnly().millisecondsSinceEpoch
  });
}
