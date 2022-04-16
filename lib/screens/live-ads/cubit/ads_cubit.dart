import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/models/ad.dart';
import '/models/failure.dart';
import '/repositories/ads/ads_repository.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  final AdsRepository _adRepository;
  AdsCubit({required AdsRepository adsRepository})
      : _adRepository = adsRepository,
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
}
