part of 'dashboard_bloc.dart';

enum DashBoardStatus { initial, loading, succuss, error }

class DashboardState extends Equatable {
  final List<PromotedAd?> promotedAds;
  final Failure failure;
  final DashBoardStatus status;

  const DashboardState({
    required this.promotedAds,
    required this.failure,
    required this.status,
  });

  factory DashboardState.initial() => const DashboardState(
      failure: Failure(), promotedAds: [], status: DashBoardStatus.error);

  @override
  List<Object> get props => [promotedAds, failure, status];

  @override
  String toString() =>
      'DashboardState(promotedAds: $promotedAds, failure: $failure, status: $status)';

  DashboardState copyWith({
    List<PromotedAd?>? promotedAds,
    Failure? failure,
    DashBoardStatus? status,
  }) {
    return DashboardState(
      promotedAds: promotedAds ?? this.promotedAds,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
