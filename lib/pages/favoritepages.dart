import 'package:flutter/material.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/model/task.dart';
import 'package:todoapp_bloc/pages/listtile.dart';

class FavoritePages extends StatelessWidget {
  const FavoritePages({super.key});

  @override
  Widget build(BuildContext context) {
    int getIsDone() {
      int num = 0;
      var bloc = context.read<TaskBloc>().state.allTask;
      for (var i = 0; i < bloc.length; i++) {
        if (bloc[i].isFavorite) {
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
                print(getIsDone());
                return Text(
                  '${getIsDone()} Favorite Task',
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
        ),
        BlocSelector<TaskBloc, TaskState, List<Task>>(
          selector: (state) {
            return state.allTask
                .where((element) => element.isFavorite == true)
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
