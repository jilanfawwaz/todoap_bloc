import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';

import '../model/task.dart';

class ListTilePage extends StatelessWidget {
  final Task task;

  const ListTilePage({required this.task, super.key});

  _deleteOption(BuildContext context) {
    task.isDeleted
        ? context.read<TaskBloc>().add(DeletePermanentTask(task: task))
        : context.read<TaskBloc>().add(DeleteTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<TaskBloc>();
    return Column(
      children: [
        //! widget card dihapus karena kedouble sama expansionpanellist

        ListTile(
          onLongPress: () => _deleteOption(context),
          leading: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  bloc.add(FavoriteTask(task: task));
                },
                icon: Icon(Icons.star,
                    color: task.isFavorite
                        ? Colors.yellow.shade900
                        : Theme.of(context).iconTheme.color),
              );
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: TextStyle(
                    decoration: !task.isDone
                        ? TextDecoration.none
                        : TextDecoration.lineThrough),
              ),
              Text(
                '${DateFormat.yMd().format(
                  DateTime.parse(
                    task.date,
                  ),
                )} ${DateFormat.Hms().format(
                  DateTime.parse(
                    task.date,
                  ),
                )}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: !task.isDeleted
                    ? (value) {
                        bloc.add(UpdateTask(task: task));
                      }
                    : null,
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert_rounded),
                itemBuilder: task.isDeleted
                    ? (context) => [
                          PopupMenuItem(
                            child: TextButton.icon(
                              icon: const Icon(Icons.delete_forever_outlined),
                              label: const Text('Delete Permanent'),
                              onPressed: () {
                                bloc.add(DeletePermanentTask(task: task));
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: TextButton.icon(
                              icon: const Icon(Icons.repeat),
                              label: const Text('Recover'),
                              onPressed: () {
                                bloc.add(RecoverTask(task: task));
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ]
                    : (context) => [
                          PopupMenuItem(
                            child: TextButton.icon(
                              icon: const Icon(Icons.edit),
                              label: const Text('Edit'),
                              onPressed: () {},
                            ),
                          ),
                          PopupMenuItem(
                            child: TextButton.icon(
                              icon: const Icon(Icons.delete),
                              label: const Text('Delete'),
                              onPressed: () {
                                bloc.add(DeleteTask(task: task));
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
              ),
            ],
          ),
        ),
      ],
    );

    //? expansiontile ditaroh langsung di tile nya, bukan di listview
    /*return Column(
      children: [
        Card(
          child: ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            // onLongPress: () => _deleteOption(context),
            leading: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(FavoriteTask(task: task));
                  },
                  icon: Icon(Icons.star,
                      color: task.isFavorite
                          ? Colors.yellow.shade900
                          : Theme.of(context).iconTheme.color),
                );
              },
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                      decoration: !task.isDone
                          ? TextDecoration.none
                          : TextDecoration.lineThrough),
                ),
                Text(
                  '${DateFormat.yMd().format(
                    DateTime.parse(
                      task.date,
                    ),
                  )} ${DateFormat.Hms().format(
                    DateTime.parse(
                      task.date,
                    ),
                  )}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: task.isDone,
                  onChanged: !task.isDeleted
                      ? (value) {
                          context.read<TaskBloc>().add(UpdateTask(task: task));
                        }
                      : null,
                ),
                IconButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(DeleteTask(task: task));
                  },
                  icon: const Icon(
                    Icons.more_vert_rounded,
                  ),
                ),
              ],
            ),
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Title:'),
                    Text(task.title),
                    const Divider(),
                    const Text('Description:'),
                    Text(task.desc),
                    const Divider(),
                    const Text('Dibuat pada:'),
                    Text(
                      DateFormat.yMd().format(
                        DateTime.parse(task.date),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );*/
  }
}
