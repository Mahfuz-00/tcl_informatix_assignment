// ------------------------------------------------------------
// Application Entry Point
//
// - Initializes Flutter bindings
// - Sets up dependency injection
// - Provides global BLoC instances
// - Manages app-wide theme (light / dark)
// - Configures GoRouter-based navigation
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'Core/Dependency_Injection/injector.dart';
import 'Core/Config/Theme/app_theme.dart';
import 'Core/Navigation/app_router.dart';
import 'Common/Services/theme_service.dart';
import 'Presentation/Bloc/company_bloc.dart';
import 'Presentation/Bloc/project_bloc.dart';
import 'Presentation/Bloc/project_details_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeService(),
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<CompanyBloc>(create: (_) => injector<CompanyBloc>()),
              BlocProvider<ProjectsBloc>(create: (_) => injector<ProjectsBloc>()),
              BlocProvider<ProjectDetailsBloc>(create: (_) => injector<ProjectDetailsBloc>()),
            ],
            child: MaterialApp.router(
              title: 'ABC Construction Ltd',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}