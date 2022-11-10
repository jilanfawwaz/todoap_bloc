import 'package:flutter/material.dart';
import '../model/task.dart';
import '../pages/listtile.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';

class PendingPages extends StatelessWidget {
  PendingPages({super.key});

  // List<Task> _listTask = [];

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<TaskBloc>();
    // _listTask = bloc.state.allTask;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    print('masukkk');
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.shade300,
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '4 Pendings | 0 Completed',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        BlocBuilder<TaskBloc, TaskState>(
          
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.allTask.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTilePage(task: state.allTask[index]);
              },
            );
          },
        )
      ],
    );
  }
}
