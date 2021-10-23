import 'package:flutter/material.dart';
import 'package:todo_list/data/list_items.dart';
import 'package:todo_list/model/list_item.dart';
import 'package:todo_list/widget/list_item_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Newaz's Todo List",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Newaz's Todo List"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final listKey = GlobalKey<AnimatedListState>();
  final List<ListItem> items = List.from(listItems);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: AnimatedList(
          key: listKey,
          initialItemCount: items.length,
          itemBuilder: (context, index, animation) => ListItemWidget(
            item: items[index],
            animation: animation,
            onClicked: () => removeItem(index),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => insertItem(),
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      );

  insertItem() {
    const newIndex = 0;
    final newItem = (List.of(listItems)..shuffle()).first;
    items.insert(newIndex, newItem);
    listKey.currentState!.insertItem(
      newIndex,
      duration: const Duration(milliseconds: 600),
    );
  }

  void removeItem(int index) {
    final removedItem = items[index];

    items.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => ListItemWidget(
        item: removedItem,
        animation: animation,
        onClicked: () {},
      ),
      duration: const Duration(milliseconds: 600),
    );
  }
}
