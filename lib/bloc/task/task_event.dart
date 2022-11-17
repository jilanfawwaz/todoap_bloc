part of 'task_bloc.dart';

//! tambahkan equatable
abstract class TaskEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//! masing masing di event, tambahkan equatable untuk menyimpan variabel task
//! task dari masing2 perubahan ditaroh sementara di TaskEvent ini sebelum akhirnya akan diemit
class AddTask extends TaskEvent {
  //! Task ini untuk menyimpan sementara object task dari halaman homepage, terus nanti diambil datanya di bloc
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

class FavoriteTask extends TaskEvent {
  final Task task;
  FavoriteTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;
  DeleteTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class DeletePermanentTask extends TaskEvent {
  final Task task;
  DeletePermanentTask({required this.task});

  @override
  List<Object?> get props => [task];
}
