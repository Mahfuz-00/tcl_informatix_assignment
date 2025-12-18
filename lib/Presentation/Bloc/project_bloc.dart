// ------------------------------------------------------------
// ProjectsBloc
//
// - Handles loading of all projects using GetProjects use case
// - Emits states: ProjectsInitial, ProjectsLoading, ProjectsLoaded, ProjectsError
// - Uses BLoC event LoadProjects
// ------------------------------------------------------------


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/Usecases/get_projects.dart';
import 'project_event.dart';
import 'project_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetProjects getProjects;

  ProjectsBloc(this.getProjects) : super(ProjectsInitial()) {
    on<LoadProjects>(_onLoadProjects);
  }

  Future<void> _onLoadProjects(
      LoadProjects event,
      Emitter<ProjectsState> emit,
      ) async {
    debugPrint('ProjectsBloc: Received LoadProjects event');
    emit(ProjectsLoading());
    final result = await getProjects();
    result.fold(
          (failure) {
        debugPrint('ProjectsBloc: Error - $failure');
        emit(ProjectsError('Failed to load projects'));
      },
          (projects) {
        debugPrint('ProjectsBloc: Success - Loaded ${projects.length} projects');
        emit(ProjectsLoaded(projects));
      },
    );
  }
}