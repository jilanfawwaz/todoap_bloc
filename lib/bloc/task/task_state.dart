part of 'task_bloc.dart';

//! state paling umum adalah initial, loading, loaded, dan error

//! seluruh list Task yang nanti akan mengalami perubahan akan disimpan di TaskState ini
//! abstract dihapus biar bisa di instansiasi saat emit di file bloc
class TaskState extends Equatable {
  final List<Task> allTask;

  const TaskState({
    required this.allTask,
  });

  @override
  List<Object> get props => [allTask];
}

//! state pertama (initial) isinya list kosong yang di pass langsung ke parent menggunakan super
class TaskInitial extends TaskState {
  const TaskInitial({
    super.allTask = const [],
  });
}
