import 'package:flutter/material.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';

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
            onLongPress: () => context.read<TaskBloc>().add(
                  DeleteTask(task: task),
                ),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.star),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title),
                const Text(
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
                  onChanged: (value) {
                    print('1');
                    context.read<TaskBloc>().add(UpdateTask(task: task));
                  },
                ),
                IconButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(DeleteTask(task: task));
                  },
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
