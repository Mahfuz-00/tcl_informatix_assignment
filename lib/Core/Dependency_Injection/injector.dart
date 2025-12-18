// ------------------------------------------------------------
// Dependency Injection Setup (GetIt)
//
// - Centralized DI container for the app
// - Registers:
//   • Data sources (LocalDataSource)
//   • Repositories (CompanyRepositoryImpl, ProjectRepositoryImpl)
//   • Usecases (GetCompanyInfo, GetProjects, GetProjectDetails)
//   • Blocs (CompanyBloc, ProjectsBloc, ProjectDetailsBloc)
// - Lazy singletons for shared instances, factories for BLoCs
// ------------------------------------------------------------

import 'package:get_it/get_it.dart';

import '../../Data/Repositories/company_repository_impl.dart';
import '../../Data/Repositories/project_repository_impl.dart';
import '../../Data/Sources/Local/local_data_source.dart';
import '../../Domain/Repositories/company_repository.dart';
import '../../Domain/Repositories/project_repository.dart';
import '../../Domain/Usecases/get_company_info.dart';
import '../../Domain/Usecases/get_projects.dart';
import '../../Domain/Usecases/get_project_details.dart';
import '../../Presentation/Bloc/company_bloc.dart';
import '../../Presentation/Bloc/project_bloc.dart';
import '../../Presentation/Bloc/project_details_bloc.dart';

final injector = GetIt.instance;

Future<void> setupInjector() async {
  // Data sources
  injector.registerLazySingleton<LocalDataSource>(() => LocalDataSource());

  // Repositories
  injector.registerLazySingleton<CompanyRepository>(
        () => CompanyRepositoryImpl(localDataSource: injector<LocalDataSource>()),
  );
  injector.registerLazySingleton<ProjectRepository>(
        () => ProjectRepositoryImpl(localDataSource: injector<LocalDataSource>()),
  );

  // Usecases
  injector.registerLazySingleton<GetCompanyInfo>(() => GetCompanyInfo(injector<CompanyRepository>()));
  injector.registerLazySingleton<GetProjects>(() => GetProjects(injector<ProjectRepository>()));
  injector.registerLazySingleton<GetProjectDetails>(() => GetProjectDetails(injector<ProjectRepository>()));

  // Blocs
  injector.registerFactory<CompanyBloc>(() => CompanyBloc(injector<GetCompanyInfo>()));
  injector.registerFactory<ProjectsBloc>(() => ProjectsBloc(injector<GetProjects>()));
  injector.registerFactory<ProjectDetailsBloc>(() => ProjectDetailsBloc(injector<GetProjectDetails>()));
}