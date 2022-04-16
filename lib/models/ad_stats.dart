import 'dart:convert';

import 'package:equatable/equatable.dart';

class AdStats extends Equatable {
  final int? clicks;
  final int? converts;
  final int? spent;

  const AdStats({
    this.clicks,
    this.converts,
    this.spent,
  });

  AdStats copyWith({
    int? clicks,
    int? converts,
    int? spent,
  }) {
    return AdStats(
      clicks: clicks ?? this.clicks,
      converts: converts ?? this.converts,
      spent: spent ?? this.spent,
    );
  }

  factory AdStats.emptyStats() {
    return const AdStats(clicks: 0, converts: 0, spent: 0);
  }

  Map<String, dynamic> toMap() {
    return {
      'clicks': clicks,
      'converts': converts,
      'spent': spent,
    };
  }

  factory AdStats.fromMap(Map<String, dynamic> map) {
    return AdStats(
      clicks: map['clicks']?.toInt(),
      converts: map['converts']?.toInt(),
      spent: map['spent']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AdStats.fromJson(String source) =>
      AdStats.fromMap(json.decode(source));

  @override
  String toString() =>
      'AdStats(clicks: $clicks, converts: $converts, spents: $spent)';

  @override
  List<Object?> get props => [clicks, converts, spent];
}
