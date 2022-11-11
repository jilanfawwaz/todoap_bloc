import 'package:flutter/material.dart';


import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/bloc/bottompage/bottompage_bloc.dart';
import 'package:todoapp_bloc/pages/homepages.dart';


void main() {
  
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TaskBloc()
              /* ..add(
                AddTask(
                  task: Task(
                    title: 'title 1',
                  ),
                ),
              )
              ..add(
                AddTask(
                  task: Task(
                    title: 'title 2',
                  ),
                ),
              ),*/
              ),
          BlocProvider(
            create: (context) => BottomPageBloc(),
          ),
        ],
        child: MaterialApp(
          home: HomePages(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
