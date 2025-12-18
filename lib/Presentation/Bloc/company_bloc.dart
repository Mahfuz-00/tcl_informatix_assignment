import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/Usecases/get_company_info.dart';
import 'company_event.dart';
import 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final GetCompanyInfo getCompanyInfo;

  CompanyBloc(this.getCompanyInfo) : super(CompanyInitial()) {
    on<LoadCompanyInfo>(_onLoadCompanyInfo);
  }

  Future<void> _onLoadCompanyInfo(
      LoadCompanyInfo event,
      Emitter<CompanyState> emit,
      ) async {
    debugPrint('CompanyBloc: Received LoadCompanyInfo event');
    emit(CompanyLoading());
    final result = await getCompanyInfo();
    result.fold(
          (failure) {
        debugPrint('CompanyBloc: Error - $failure');
        emit(CompanyError('Failed to load company info'));
      },
          (company) {
        debugPrint('CompanyBloc: Success - Loaded company: ${company.name}');
        emit(CompanyLoaded(company));
      },
    );
  }
}