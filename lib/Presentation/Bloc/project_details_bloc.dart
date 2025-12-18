// ------------------------------------------------------------
// ProjectDetailsBloc
//
// - Handles fetching detailed information for a single project using GetProjectDetails use case
// - Emits states: ProjectDetailsInitial, ProjectDetailsLoading, ProjectDetailsLoaded, ProjectDetailsError
// - Uses BLoC event LoadProjectDetails
// ------------------------------------------------------------


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/Usecases/get_project_details.dart';
import 'project_details_event.dart';
import 'project_details_state.dart';

class ProjectDetailsBloc extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final GetProjectDetails getProjectDetails;

  ProjectDetailsBloc(this.getProjectDetails) : super(ProjectDetailsInitial()) {
    on<LoadProjectDetails>(_onLoadProjectDetails);
  }

  Future<void> _onLoadProjectDetails(
      LoadProjectDetails event,
      Emitter<ProjectDetailsState> emit,
      ) async {
    emit(ProjectDetailsLoading());
    final result = await getProjectDetails(event.projectId);
    result.fold(
          (failure) => emit(ProjectDetailsError('Failed to load project details')),
          (project) => emit(ProjectDetailsLoaded(project)),
    );
  }
}