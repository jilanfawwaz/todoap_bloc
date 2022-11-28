part of 'task_bloc.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

//! state paling umum adalah initial, loading, loaded, dan error

//! seluruh list Task yang nanti akan mengalami perubahan akan disimpan di TaskState ini
//! abstract dihapus biar bisa di instansiasi saat emit di file bloc
//! hydrated_bloc 9 : generate JSONserialization
//! hydrated_bloc 10 : hapus fromJson dan toJson karena kita cuma butuh fromMap dan toMap, hapus juga import 'dart:convert'
class TaskState extends Equatable {
  final List<Task> allTask;
  
  final List<Task> deletedTask;

  const TaskState({
    this.allTask = const [],
    this.deletedTask = const [],
  });

//! contoh manfaat equatable, coba hapus sebuah tile di halaman bin
  @override
  List<Object> get props => [allTask, deletedTask];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allTask': allTask.map((x) => x.toMap()).toList(),
      'deletedTask': deletedTask.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      //! hydrated_bloc 11 : hapus as List<int>
      allTask: List<Task>.from(
        map['allTask'].map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      deletedTask: List<Task>.from(
        map['deletedTask'].map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

//! state pertama (initial) isinya list kosong yang di pass langsung ke parent menggunakan super
class TaskInitial extends TaskState {
  const TaskInitial({
    super.allTask = const [],
  });
}
