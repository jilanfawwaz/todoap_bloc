import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp_bloc/model/task.dart';

export '';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskInitial()) {
    on<AddTask>(_onAddTask);

    on<UpdateTask>((event, emit) {});

    on<DeleteTask>((event, emit) {});
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    //! karena function ini diluar on<>, sebaiknya menggunakan this untuk memanggil state di ruang lingkup class
    // TaskState state = this.state;

    List<Task> task = state.allTask;

    emit(
      TaskState(
        //! pake list.from karena kalau langsung dari task bakal eror
        allTask: List.from(task)..remove(event.task),
      ),
    );
  }
}
