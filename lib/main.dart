import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/bloc/bottompage/bottompage_bloc.dart';
import 'package:todoapp_bloc/model/task.dart';
import 'package:todoapp_bloc/pages/homepages.dart';

//! Hydrated_bloc 2 : tambahkan async dan Future, karena nanti kita mau menggunakan await
Future<void> main() async {
  //! tambahkan bloc oberver supaya bisa melihat perubahan yang terjadi pada bloc state
  Bloc.observer = MyBlocObserver();

//! Hydrated_bloc 1 : panggil widgetsflutterbinding buat berkomunikasi dengan native
  WidgetsFlutterBinding.ensureInitialized();

  //! Hydrated_bloc 3 : bikin variabel untuk storage dari hydratedbloc
  final storage = await HydratedStorage.build(
    //! Hydrated_bloc 4 : alamat storage menggunakan method dari package path_provider
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TaskBloc()
              ..add(
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
              ),
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
