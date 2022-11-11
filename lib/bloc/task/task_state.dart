part of 'task_bloc.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first




//! state paling umum adalah initial, loading, loaded, dan error

//! seluruh list Task yang nanti akan mengalami perubahan akan disimpan di TaskState ini
//! abstract dihapus biar bisa di instansiasi saat emit di file bloc
class TaskState extends Equatable {
  final List<Task> allTask;

  const TaskState({
     this.allTask = const [],
  });

  @override
  List<Object> get props => [allTask];


  Map<String, dynamic> toMap() {
    return {
      'allTask': allTask.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      allTask: List<Task>.from(map['allTask'].map<Task>((x) => Task.fromMap(x ),),),
    );
  }

  

  
}

//! state pertama (initial) isinya list kosong yang di pass langsung ke parent menggunakan super
class TaskInitial extends TaskState {
  const TaskInitial({
    super.allTask = const [],
  });
}
