import 'package:flutter/material.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';

import '../../bloc/bottompage/bottompage_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  Color drawerColor(int index, int state) {
    if (index == state) {
      return Colors.grey;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BottomPageBloc>();
    final blocTask = context.read<TaskBloc>();
    return Drawer(
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, stateTask) {
          return BlocBuilder<BottomPageBloc, int>(
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  ListTile(
                    tileColor: drawerColor(1, state),
                    onTap: () {
                      bloc.add(ChangePage(page: 1));
                      Navigator.pop(context);
                    },
                    trailing: Text(stateTask.allTask.length.toString()),
                    title: const Text('My Task'),
                    leading: const Icon(
                      Icons.folder_copy,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    tileColor: drawerColor(4, state),
                    onTap: () {
                      bloc.add(ChangePage(page: 4));
                      Navigator.pop(context);
                    },
                    trailing: Text(stateTask.deletedTask.length.toString()),
                    title: const Text('Trash Bin'),
                    leading: const Icon(
                      Icons.auto_delete_rounded,
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
