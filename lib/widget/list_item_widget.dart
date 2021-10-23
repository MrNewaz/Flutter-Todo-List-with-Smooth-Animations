import 'package:flutter/material.dart';
import 'package:todo_list/model/list_item.dart';

class ListItemWidget extends StatelessWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const ListItemWidget({
    Key? key,
    required this.item,
    required this.animation,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizeTransition(
        key: ValueKey(item.urlImage),
        sizeFactor: animation,
        child: buildItem(),
      );

  Widget buildItem() => Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue[400],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(item.urlImage),
          ),
          title: Text(
            item.title,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.white, size: 32),
            onPressed: onClicked,
          ),
        ),
      );
}
