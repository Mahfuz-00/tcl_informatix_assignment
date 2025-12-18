import 'package:equatable/equatable.dart';

abstract class ProjectDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProjectDetails extends ProjectDetailsEvent {
  final String projectId;
  LoadProjectDetails(this.projectId);

  @override
  List<Object> get props => [projectId];
}