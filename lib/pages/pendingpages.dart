import 'package:flutter/material.dart';
import '../model/task.dart';
import '../pages/listtile.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';

class PendingPages extends StatelessWidget {
  PendingPages({super.key});

  // List<Task> _listTask = [];

  @override
  Widget build(BuildContext context) {

    //? ngga kepake
    // var bloc = context.read<TaskBloc>();
    // _listTask = bloc.state.allTask;
    // final w = MediaQuery.of(context).size.width;
    // final h = MediaQuery.of(context).size.height;

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
            return state.allTask
                .where((element) => element.isDone == false)
                .toList();
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
