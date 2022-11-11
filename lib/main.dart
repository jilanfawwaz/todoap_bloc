import 'package:flutter/material.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/bloc/bottompage/bottompage_bloc.dart';
import 'package:todoapp_bloc/pages/homepages.dart';

//! hydrated_bloc 1 : install package hydrated_bloc dan path_provider
//! hydrated_bloc 2 : tambahkan Future<> dan async karena kita akan menggunakan await
Future<void> main() async {
  Bloc.observer = MyBlocObserver();

  //! hydrated_bloc 4 : tambahkan WidgetsFlutterBinding, dan bikin variabel HydratedStorage.build() tambahkan parameter storageDirectory: getApplicationDocumentDirectory()
  //! hydrated_bloc 5 : tambahkan await biar gaerror
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  //! hydrated_bloc 6 : masukkan variabel storage tadi ke HydratedBloc.storage
  HydratedBloc.storage = storage;

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
