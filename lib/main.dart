import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'core/router/app_router.dart';
import 'features/characters/presentation/bloc/characters_bloc.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CharactersBloc>()),
        BlocProvider(create: (_) => di.sl<FavoritesBloc>()),
        BlocProvider(create: (_) => di.sl<SettingsBloc>()),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Rick and Morty App',
            theme: ThemeData(
              brightness: state.isDarkMode ? Brightness.dark : Brightness.light,
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
