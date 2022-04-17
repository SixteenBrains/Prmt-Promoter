import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/ad.dart';
import '/models/failure.dart';
import '/repositories/ads/ads_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AdsRepository _adsRepository;
  final AuthBloc _authBloc;

  DashboardBloc({
    required AdsRepository adsRepository,
    required AuthBloc authBloc,
  })  : _adsRepository = adsRepository,
        _authBloc = authBloc,
        super(DashboardState.initial()) {
    on<LoadUserPromotedAds>((event, emit) async {
      try {
        emit(state.copyWith(status: DashBoardStatus.loading));

        final ads = await _adsRepository.getUserPromotedAds(
            promoterId: _authBloc.state.promoter?.promoterId);

        emit(state.copyWith(status: DashBoardStatus.succuss, promotedAds: ads));
      } on Failure catch (failure) {
        emit(state.copyWith(status: DashBoardStatus.error, failure: failure));
      }
    });
  }
}
