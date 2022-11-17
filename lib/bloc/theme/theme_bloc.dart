import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial(false)) {
    on<ChangeThemeOn>(
      (event, emit) {
        emit(ThemeState(themeSwitch: event.themeSwitch));
      },
    );

    on<ChangeThemeOff>(
      (event, emit) {
        emit(ThemeState(themeSwitch: event.themeSwitch));
      },
    );
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
