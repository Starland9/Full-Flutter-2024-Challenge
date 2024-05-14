part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {}

final class ChangeThemeState extends ThemeState {
  final bool light;
  const ChangeThemeState({required this.light});
}
