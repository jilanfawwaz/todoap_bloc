import 'package:equatable/equatable.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/model/task.dart';

part 'task_event.dart';
part 'task_state.dart';

//! hydrated_bloc 7 : ubah Bloc jadi HydratedBloc
//! hydrated_bloc 8 : create 2 missing override
class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskInitial()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<DeletePermanentTask>(_onDeletePermanentTask);
    on<FavoriteTask>(_onFavoriteTask);
    on<RecoverTask>(_onRevocerTask);
    on<EditTask>(_onEditTask);
    on<DeleteAllTrashBinTask>(_onDeleteAllTrashBinTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    //! karena function ini diluar on<>, sebaiknya menggunakan this untuk memanggil state di ruang lingkup class
    // TaskState state = this.state;

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

  void _onEditTask(EditTask event, Emitter<TaskState> emit) {
    //! from tutorial
    final state = this.state;
    final newTask = event.newTask;
    final index = state.allTask.indexOf(event.oldTask);

    //! perlu bikin object task baru, karena kalau edit dari object task yang lama, state ga ke trigger
    List<Task> allTask = List.from(state.allTask)..remove(event.oldTask);
    List<Task> deletedTask = state.deletedTask;

    allTask.insert(index, newTask);
    emit(TaskState(allTask: allTask, deletedTask: deletedTask));
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

  void _onFavoriteTask(FavoriteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    final index = state.allTask.indexOf(task);

    //! perlu bikin object task baru, karena kalau edit dari object task yang lama, state ga ke trigger
    List<Task> allTask = List.from(state.allTask)..remove(task);
    List<Task> deletedTask = state.deletedTask;

    task.isFavorite
        ? allTask.insert(
            index,
            task.copyWith(isFavorite: false),
          )
        : allTask.insert(
            index,
            task.copyWith(isFavorite: true),
          );
    emit(TaskState(allTask: allTask, deletedTask: deletedTask));
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

  void _onDeleteAllTrashBinTask(
      DeleteAllTrashBinTask event, Emitter<TaskState> emit) {
    emit(TaskState(
      allTask: state.allTask,
      deletedTask: [],
    ));
  }

  void _onRevocerTask(RecoverTask event, Emitter<TaskState> emit) {
    final List<Task> deletedTask = List.from(state.deletedTask)
      ..remove(event.task);
    final List<Task> allTask = List.from(state.allTask)
      ..add(event.task.copyWith(isDeleted: false));

    emit(TaskState(
      allTask: allTask,
      deletedTask: deletedTask,
    ));
  }

  void _onDeletePermanentTask(
      DeletePermanentTask event, Emitter<TaskState> emit) {
    final state = this.state;
    /*final List<Task> deletedTask = List.from(state.deletedTask)
      ..remove(event.task);
    final List<Task> allTask = List.from(state.allTask)
      ..add(event.task.copyWith(isDeleted: false));*/

    emit(TaskState(
      allTask: state.allTask,
      deletedTask: List.from(state.deletedTask)..remove(event.task),
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
    return state.toMap();
  }
}
