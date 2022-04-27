import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_promoter/models/promoted_ad.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/ad.dart';
import '/models/failure.dart';
import '/repositories/ads/ads_repository.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  final AdsRepository _adRepository;
  final AuthBloc _authBloc;
  AdsCubit({required AdsRepository adsRepository, required AuthBloc authBloc})
      : _adRepository = adsRepository,
        _authBloc = authBloc,
        super(AdsState.initial());

  void fetchLiveAds() async {
    try {
      emit(state.copyWith(status: AdsStatus.loading));

      final ads = await _adRepository.getLiveAds();
      emit(state.copyWith(
          liveAds: await Future.wait(ads), status: AdsStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(status: AdsStatus.error, failure: failure));
    }
  }

  void promoteAd({required Ad? ad, required PromotedAd? promotedAd}) async {
    try {
      emit(state.copyWith(status: AdsStatus.loading));

      await _adRepository.promoteAd(
        promotedAd: promotedAd,
      );
      emit(state.copyWith(status: AdsStatus.adShared));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: AdsStatus.error));
    }
  }
}
