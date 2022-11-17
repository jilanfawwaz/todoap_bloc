//! part ditaroh di file parent
//! part of ditaruh di file children



part of 'theme_bloc.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ThemeState extends Equatable {
  final bool themeSwitch;
  const ThemeState({required this.themeSwitch});
  @override
  List<Object?> get props => [themeSwitch];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'themeSwitch': themeSwitch,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      themeSwitch: map['themeSwitch'] as bool,
    );
  }

  
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(themeSwitch) : super(themeSwitch: themeSwitch);
}
