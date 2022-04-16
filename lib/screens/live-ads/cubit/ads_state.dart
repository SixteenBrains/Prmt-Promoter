part of 'ads_cubit.dart';

enum AdsStatus { initial, loading, succuss, error }

class AdsState extends Equatable {
  final List<Ad?> liveAds;
  final Failure failure;
  final AdsStatus status;

  const AdsState({
    required this.liveAds,
    required this.failure,
    required this.status,
  });

  factory AdsState.initial() => const AdsState(
      liveAds: [], failure: Failure(), status: AdsStatus.initial);
  @override
  List<Object> get props => [liveAds, failure, status];

  AdsState copyWith({
    List<Ad?>? liveAds,
    Failure? failure,
    AdsStatus? status,
  }) {
    return AdsState(
      liveAds: liveAds ?? this.liveAds,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'AdsState(liveAds: $liveAds, failure: $failure, status: $status)';
}
