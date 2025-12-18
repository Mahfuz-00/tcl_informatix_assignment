import 'package:equatable/equatable.dart';

import '../../../Domain/Entities/company_entity.dart';

abstract class CompanyState extends Equatable {
  @override
  List<Object> get props => [];
}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanyLoaded extends CompanyState {
  final CompanyEntity company;
  CompanyLoaded(this.company);
  @override
  List<Object> get props => [company];
}

class CompanyError extends CompanyState {
  final String message;
  CompanyError(this.message);
  @override
  List<Object> get props => [message];
}