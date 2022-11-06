import 'package:flutter/material.dart';

import '../model/task.dart';

class ListTilePage extends StatelessWidget {
  Task task;
  ListTilePage({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.star),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title),
                Text(
                  '20 Apr 2022',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: task.isDone,
                  onChanged: (value) {},
                ),
                IconButton(
                  onPressed: () {}, 
                  icon: const Icon(
                    Icons.more_vert_rounded,
                  ),
                ),
                
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.expand_more,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
