import 'package:equatable/equatable.dart';

import '../../../Domain/Entities/project_entity.dart';

abstract class ProjectDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProjectDetailsInitial extends ProjectDetailsState {}

class ProjectDetailsLoading extends ProjectDetailsState {}

class ProjectDetailsLoaded extends ProjectDetailsState {
  final ProjectEntity project;
  ProjectDetailsLoaded(this.project);

  @override
  List<Object> get props => [project];
}

class ProjectDetailsError extends ProjectDetailsState {
  final String message;
  ProjectDetailsError(this.message);
  @override
  List<Object> get props => [message];
}