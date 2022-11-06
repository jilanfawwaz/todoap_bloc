// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  bool isDone;
  bool isSelected;
  Task({
    required this.title,
    this.isDone = false,
    this.isSelected = false,
  });

  //! mengambil data dari variabel, dan mengkonversi ke map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'isDone': isDone,
      'isSelected': isSelected,
    };
  }

  //! menerima map dari luar, memparsingnya, lalu memasukkan ke variabel
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      isDone: map['isDone'] as bool,
      isSelected: map['isSelected'] as bool,
    );
  }

  @override
  List<Object?> get props => [
        title,
        isDone,
        isSelected,
      ];
}
