import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp_bloc/model/task.dart';

export '';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskInitial()) {
    on<AddTask>(_onAddTask);

    on<UpdateTask>(_onUpdateTask);

    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    //! karena function ini diluar on<>, sebaiknya menggunakan this untuk memanggil state di ruang lingkup class
    // TaskState state = this.state;
    print('masuk add');

    List<Task> task = state.allTask;

    emit(
      TaskState(
        //! pake list.from karena kalau langsung dari task bakal eror
        //! harus bikin object baru karena equatable akan menyamakan object, sehingga tidak teremit dan halaman tidak terefresh
        allTask: List.from(task)..add(event.task),
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

    task.isDone
        ? allTask.insert(
            index,
            task.copyWith(isDone: false),
          )
        : allTask.insert(
            index,
            task.copyWith(isDone: true),
          );
    emit(TaskState(allTask: allTask));

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

    emit(TaskState(allTask: allTask));
  }
}