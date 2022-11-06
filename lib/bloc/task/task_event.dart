part of 'task_bloc.dart';

//! tambahkan equatable
abstract class TaskEvent extends Equatable {}

//! masing masing di event, tambahkan equatable untuk menyimpan variabel task
//! task dari masing2 perubahan ditaroh sementara di TaskEvent ini sebelum akhirnya akan diemit
class AddTask extends TaskEvent {
  final Task task;
  AddTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask({required this.task});

  @override
  List<Object?> get props => [task];
}


class DeleteTask extends TaskEvent {
  final Task task;
  DeleteTask({required this.task});

  @override
  List<Object?> get props => [task];
}
