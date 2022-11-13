// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String date;
  bool isDone;
  bool isSelected;

  Task({
    required this.id,
    required this.title,
    required this.date,
    this.isDone = false,
    this.isSelected = false,
  });

  //! mengambil data dari variabel, dan mengkonversi ke map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date': date,
      'isDone': isDone,
      'isSelected': isSelected,
    };
  }

  //! menerima map dari luar, memparsingnya, lalu memasukkan ke variabel
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      date: map['date'] as String,
      isDone: map['isDone'] as bool,
      isSelected: map['isSelected'] as bool,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        title,
        isDone,
        isSelected,
      ];

  //! generate copyWith, perlu karena equatable akan mereturn true dua object saat emit, sehingga ketika emit layar tidak direfresh dengan ini maka bisa mengatasi itu
  //! membuat task baru dengan mengcopy task yang sudah ada
  Task copyWith({
    String? id,
    String? title,
    String? date,
    bool? isDone,
    bool? isSelected,
  }) {
    return Task(
      id: id ?? this.id,
      date: date  ?? this.date,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
