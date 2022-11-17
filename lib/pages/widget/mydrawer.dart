import 'package:flutter/material.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/bloc/theme/theme_bloc.dart';

import '../../bloc/bottompage/bottompage_bloc.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  bool themeSwitch = false;

  Color drawerColor(int index, int state, BuildContext context) {
    if (index == state) {
      return Theme.of(context).primaryColor;
    }
    return Theme.of(context).disabledColor;
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
                    tileColor: drawerColor(1, state, context),
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
                    tileColor: drawerColor(4, state, context),
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
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return Switch.adaptive(
                        value: state.themeSwitch,
                        onChanged: (value) {
                          value
                              ? context.read<ThemeBloc>().add(
                                    ChangeThemeOn(
                                      themeSwitch: value,
                                    ),
                                  )
                              : context.read<ThemeBloc>().add(
                                    ChangeThemeOff(
                                      themeSwitch: value,
                                    ),
                                  );
                        },
                      );
                    },
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
