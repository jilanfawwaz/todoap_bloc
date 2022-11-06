import 'package:flutter/material.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/pages/homepages.dart';

void main() {
  //! tambahkan bloc oberver supaya bisa melihat perubahan yang terjadi pada bloc state
  Bloc.observer = MyBlocObserver();
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TaskBloc(),
          ),
        ],
        child: MaterialApp(
          home: HomePages(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
