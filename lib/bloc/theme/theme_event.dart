part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeOn extends ThemeEvent {
  final bool themeSwitch;
  const ChangeThemeOn({required this.themeSwitch});
}

class ChangeThemeOff extends ThemeEvent {
  final bool themeSwitch;
  const ChangeThemeOff({required this.themeSwitch});
}
