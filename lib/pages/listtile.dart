import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';

import '../model/task.dart';

class ListTilePage extends StatelessWidget {
  final Task task;
  final Function()? onEdit;
  final BuildContext modalBottomContext;

  ListTilePage(
      {required this.task,
      this.onEdit,
      required this.modalBottomContext,
      super.key}) {
    _taskController.text = task.title;
    _descriptionController.text = task.desc;
  }
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  _deleteOption(BuildContext context) {
    task.isDeleted
        ? context.read<TaskBloc>().add(DeletePermanentTask(task: task))
        : context.read<TaskBloc>().add(DeleteTask(task: task));
  }

  Future _editText(BuildContext context) {
    return showModalBottomSheet(
      //! kalau rounded langsung ditaroh di child container, nanti pass discroll tampilannya balik jadi kotak, makanya atur di 'shape:' aja
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      backgroundColor: Colors.white,
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      clipBehavior: Clip.antiAlias,
      context: context,
      //! isScrollControlled, kalau childnya adalah singlechildscroll atau listview, kalau true maka akan mengaktifkan sifat draggableBottomSheet
      //! bisa juga untuk memanjangkan showModalBottom
      //! kalau ada keyboard, showModalBottom jadi gaketutup (wajib ditemani mediaquery.viewinsets)
      isScrollControlled: true,
      builder: (context) {
        //! bisa juga gapake singlechildscrollview, tapi lebih baik dipake biar gaada overlapping dalam sheet nya
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          //! mengambil ukuran padding yang disebabkan sama keyboard
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 50,
              top: 50,
              left: 20,
              right: 20,
            ),
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Add Data'),
                TextField(
                  autofocus: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  // maxLines: 1,
                  // expands: true,
                  controller: _taskController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    //! content padding untuk mengatur tinggi dari textfield
                    // contentPadding: const EdgeInsets.only(left: 50, top: 50, bottom: 50),
                    filled: true,
                    fillColor: Colors.amber,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Description'),
                TextField(
                  autofocus: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  maxLines: 3,
                  // expands: true,
                  controller: _descriptionController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    //! content padding untuk mengatur tinggi dari textfield
                    // contentPadding: const EdgeInsets.only(left: 50, top: 50, bottom: 50),
                    filled: true,
                    fillColor: Colors.amber,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          40,
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(
                          EditTask(
                            oldTask: task,
                            newTask: Task(
                              id: task.id,
                              title: _taskController.text,
                              desc: _descriptionController.text,
                              date: task.date,
                            ),
                          ),
                        );
                    Navigator.pop(context);
                    _taskController.clear();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                onSelected: (value) {
                  switch (value) {
                    case 'Delete Permanent':
                      return bloc.add(DeletePermanentTask(task: task));
                    case 'Recover':
                      return bloc.add(RecoverTask(task: task));
                    case 'Edit':
                      _editText(modalBottomContext);
                      break;
                    case 'Delete':
                      return bloc.add(DeleteTask(task: task));
                  }
                },
                icon: const Icon(Icons.more_vert_rounded),
                itemBuilder: task.isDeleted
                    ? (context) => [
                          PopupMenuItem(
                            value: 'Delete Permanent',
                            child: TextButton.icon(
                              icon: const Icon(Icons.delete_forever_outlined),
                              label: const Text('Delete Permanent'),
                              onPressed: () {},
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Recover',
                            child: TextButton.icon(
                              icon: const Icon(Icons.repeat),
                              label: const Text('Recover'),
                              onPressed: () {},
                            ),
                          ),
                        ]
                    : (context) => [
                          PopupMenuItem(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            value: 'Edit',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Edit'),
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Delete',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.delete,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Delete'),
                                  ],
                                ),
                                Divider()
                              ],
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
