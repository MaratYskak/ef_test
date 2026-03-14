part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final bool isDarkMode;
  const SettingsState({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}
