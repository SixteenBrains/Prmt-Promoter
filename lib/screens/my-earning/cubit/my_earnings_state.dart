part of 'my_earnings_cubit.dart';

enum MyEarningsStatus { initial, loading, succuss, error }

class MyEarningsState extends Equatable {
  final int? clickCount;
  final int? conversion;
  final MyEarningsStatus status;
  final Failure failure;

  const MyEarningsState({
    required this.clickCount,
    required this.conversion,
    required this.status,
    required this.failure,
  });

  factory MyEarningsState.initial() => const MyEarningsState(
      clickCount: null,
      conversion: null,
      status: MyEarningsStatus.initial,
      failure: Failure());

  @override
  List<Object?> get props => [clickCount, conversion, status, failure];

  MyEarningsState copyWith({
    int? clickCount,
    int? conversion,
    MyEarningsStatus? status,
    Failure? failure,
  }) {
    return MyEarningsState(
      clickCount: clickCount ?? this.clickCount,
      conversion: conversion ?? this.conversion,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() {
    return 'MyEarningsState(clickCount: $clickCount, conversion: $conversion, status: $status, failure: $failure)';
  }
}
