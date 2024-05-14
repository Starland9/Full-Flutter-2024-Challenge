import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool isDark = false;
  ThemeBloc() : super(ThemeInitial()) {
    on<ChangeThemeEvent>(_changeTheme);
  }

  FutureOr<void> _changeTheme(
      ChangeThemeEvent event, Emitter<ThemeState> emit) {
    isDark = event.light;
    emit(ChangeThemeState(light: isDark));
    emit(ThemeInitial());
  }
}
