import 'package:equatable/equatable.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/model/task.dart';

export '';
part 'task_event.dart';
part 'task_state.dart';

//! hydrated_bloc 7 : ubah Bloc jadi HydratedBloc
//! hydrated_bloc 8 : create 2 missing override
class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskInitial()) {
    on<AddTask>(_onAddTask);

    on<UpdateTask>(_onUpdateTask);

    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    //! karena function ini diluar on<>, sebaiknya menggunakan this untuk memanggil state di ruang lingkup class
    // TaskState state = this.state;
    print(state.allTask);

    List<Task> task = state.allTask;
    List<Task> deletedTask = state.deletedTask;

    emit(
      TaskState(
        //! pake list.from karena kalau langsung dari task bakal eror
        //! harus bikin object baru karena equatable akan menyamakan object, sehingga tidak teremit dan halaman tidak terefresh
        allTask: List.from(task)..add(event.task),
        deletedTask: deletedTask,
      ),
    );
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    //! from tutorial
    final state = this.state;
    final task = event.task;
    final index = state.allTask.indexOf(task);

    //! perlu bikin object task baru, karena kalau edit dari object task yang lama, state ga ke trigger
    List<Task> allTask = List.from(state.allTask)..remove(task);
    List<Task> deletedTask = state.deletedTask;

    task.isDone
        ? allTask.insert(
            index,
            task.copyWith(isDone: false),
          )
        : allTask.insert(
            index,
            task.copyWith(isDone: true),
          );
    emit(TaskState(allTask: allTask, deletedTask: deletedTask));

    /*List<Task> allTask = state.allTask;
    final task = event.task;
    int index = allTask.indexOf(event.task);

    allTask[index].isDone = !allTask[index].isDone;
    print(allTask);

    emit(
      TaskState(
        allTask: List.from(allTask),
      ),
    );*/
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final List<Task> allTask = List.from(state.allTask)..remove(event.task);
    final List<Task> deletedTask = List.from(state.deletedTask)
      ..add(event.task.copyWith(isDeleted: true));

    emit(TaskState(
      allTask: allTask,
      deletedTask: deletedTask,
    ));
  }

  //! hydrated_bloc 12 : tambah return TaskState.fromMap(json);
  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  //! hydrated_bloc 13 : tambah return state.toMap();
  @override
  Map<String, dynamic>? toJson(TaskState state) {
    // TODO: implement toJson
    return state.toMap();
  }
}
