part of 'dashboard_bloc.dart';

enum DashBoardStatus { initial, loading, succuss, error }

class DashboardState extends Equatable {
  final List<PromotedAd?> promotedAds;
  final Failure failure;
  final DashBoardStatus status;
  final int? clickCount;
  final int? conversion;

  const DashboardState({
    required this.promotedAds,
    required this.failure,
    required this.clickCount,
    required this.conversion,
    required this.status,
  });

  factory DashboardState.initial() => const DashboardState(
        failure: Failure(),
        promotedAds: [],
        status: DashBoardStatus.error,
        clickCount: null,
        conversion: null,
      );

  @override
  List<Object?> get props =>
      [promotedAds, failure, status, clickCount, conversion];

  DashboardState copyWith({
    List<PromotedAd?>? promotedAds,
    Failure? failure,
    DashBoardStatus? status,
    int? clickCount,
    int? conversion,
  }) {
    return DashboardState(
      promotedAds: promotedAds ?? this.promotedAds,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      clickCount: clickCount ?? this.clickCount,
      conversion: conversion ?? this.conversion,
    );
  }

  @override
  String toString() {
    return 'DashboardState(promotedAds: $promotedAds, failure: $failure, status: $status, clickCount: $clickCount, conversion: $conversion)';
  }
}
