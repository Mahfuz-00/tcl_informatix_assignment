import 'package:equatable/equatable.dart';

abstract class CompanyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCompanyInfo extends CompanyEvent {}