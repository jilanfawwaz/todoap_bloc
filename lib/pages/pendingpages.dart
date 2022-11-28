import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/task.dart';
import '../pages/listtile.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';

class PendingPages extends StatelessWidget {
  const PendingPages({super.key});

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
            padding: const EdgeInsets.all(8.0),
            child: BlocSelector<TaskBloc, TaskState, List<Task>>(
              selector: (state) {
                return state.allTask
                    .where((element) => !element.isDone)
                    .toList();
              },
              builder: (context, state) {
                return Text(
                  '${state.length} Pendings | ${getIsDone()} Completed',
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
            return Expanded(
              child: SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  children: state
                      .map(
                        (e) => ExpansionPanelRadio(
                          value: e.id,
                          headerBuilder: (context, isOpen) {
                            return ListTilePage(task: e);
                          },
                          body: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Title:'),
                                Text(e.title),
                                const Divider(),
                                const Text('Description:'),
                                Text(e.desc),
                                const Divider(),
                                const Text('Dibuat pada:'),
                                Text(
                                  DateFormat.yMd().format(
                                    DateTime.parse(e.date),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            );
            //! kalau make expansion langsung di tilenya bisa menggunakan listview.builder aja
            /*return ListView.builder(
              shrinkWrap: true,
              itemCount: state.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTilePage(task: state[index]);
              },
            );*/
          },
        ),
      ],
    );
  }
}
