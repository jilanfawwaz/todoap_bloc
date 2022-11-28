// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String desc;
  final String date;
  bool isDone;
  bool isDeleted;
  bool isFavorite;

  Task({
    required this.id,
    required this.title,
    this.desc = '',
    required this.date,
    this.isDone = false,
    this.isDeleted = false,
    this.isFavorite = false,
  });

  //! mengambil data dari variabel, dan mengkonversi ke map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'date': date,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  //! menerima map dari luar, memparsingnya, lalu memasukkan ke variabel
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      desc: map['desc'] as String,
      date: map['date'] as String,
      isDone: map['isDone'] as bool,
      isDeleted: map['isDeleted'] as bool,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        title,
        desc,
        isDone,
        isDeleted,
        isFavorite
      ];

  //! generate copyWith, perlu karena equatable akan mereturn true dua object saat emit, sehingga ketika emit layar tidak direfresh dengan ini maka bisa mengatasi itu
  //! membuat task baru dengan mengcopy task yang sudah ada
  Task copyWith({
    String? id,
    String? title,
    String? desc,
    String? date,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
