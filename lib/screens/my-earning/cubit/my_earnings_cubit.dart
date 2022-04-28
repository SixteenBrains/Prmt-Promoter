import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/failure.dart';
import '/repositories/ads/ads_repository.dart';

part 'my_earnings_state.dart';

class MyEarningsCubit extends Cubit<MyEarningsState> {
  final AdsRepository _adsRepository;
  final AuthBloc _authBloc;
  MyEarningsCubit({
    required AdsRepository adsRepository,
    required AuthBloc authBloc,
  })  : _adsRepository = adsRepository,
        _authBloc = authBloc,
        super(MyEarningsState.initial());

  void loadStats() async {
    try {
      emit(state.copyWith(status: MyEarningsStatus.loading));
      final futureAds = await _adsRepository.getUserPromotedAds(
          promoterId: _authBloc.state.promoter?.promoterId);

      final promotedAds = await Future.wait(futureAds);

      int clickCount = 0;
      int conversion = 0;

      for (var element in promotedAds) {
        clickCount += element?.clickCount ?? 0;
        conversion += element?.conversion ?? 0;
      }
      emit(state.copyWith(
          status: MyEarningsStatus.succuss,
          clickCount: clickCount,
          conversion: conversion));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: MyEarningsStatus.error));
    }
  }
}
