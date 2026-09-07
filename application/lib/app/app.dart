import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/app_theme.dart';
import 'routes.dart';

class NeptunLottoApp extends StatelessWidget {
  const NeptunLottoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold generic MultiBlocProvider at the root.
    return MultiBlocProvider(
      providers: [
        // Add actual BLoCs here later
        BlocProvider<DummyBloc>(create: (context) => DummyBloc()),
      ],
      child: MaterialApp.router(
        title: 'NEPTUN LOTTO',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// Temporary dummy bloc until actual blocs are implemented
class DummyBloc extends Cubit<int> {
  DummyBloc() : super(0);
}
