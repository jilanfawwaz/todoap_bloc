import 'package:flutter/material.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/pages/listtile.dart';

import '../model/task.dart';

class CompletedPages extends StatelessWidget {
  const CompletedPages({super.key});

  @override
  Widget build(BuildContext context) {
    int getIsDone() {
      int num = 0;
      var bloc = context.read<TaskBloc>().state.allTask;
      for (var i = 0; i < bloc.length; i++) {
        if (bloc[i].isDone) {
          num++;
        }
      }

      return num;
    }

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return Text(
                  '${state.allTask.length} Pendings | ${getIsDone()} Completed',
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
        ),
        BlocSelector<TaskBloc, TaskState, List<Task>>(
          selector: (state) {
            return state.allTask.where((element) => element.isDone).toList();
          },
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTilePage(task: state[index]);
              },
            );
          },
        ),
      ],
    );
  }
}
