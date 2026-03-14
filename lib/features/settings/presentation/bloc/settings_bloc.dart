import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences sharedPreferences;

  SettingsBloc({required this.sharedPreferences})
      : super(SettingsState(isDarkMode: sharedPreferences.getBool('isDarkMode') ?? false)) {
    on<ToggleThemeEvent>((event, emit) async {
      final newMode = !state.isDarkMode;
      await sharedPreferences.setBool('isDarkMode', newMode);
      emit(SettingsState(isDarkMode: newMode));
    });
  }
}
