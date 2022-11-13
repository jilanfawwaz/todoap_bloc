import 'package:flutter/material.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/pages/listtile.dart';

class TrashBinPage extends StatelessWidget {
  const TrashBinPage({super.key});

  static const nameRoute = '/trashbinpage';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return state.deletedTask.length == 0
            ? const Center(
                child: Text('Kosong'),
              )
            : ListView.builder(
                itemCount: state.deletedTask.length,
                itemBuilder: (context, index) {
                  return ListTilePage(task: state.deletedTask[index]);
                },
              );
      },
    );
  }
}
