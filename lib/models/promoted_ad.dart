import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_promoter/config/paths.dart';

import 'package:prmt_promoter/models/ad.dart';

class PromotedAd extends Equatable {
  final Ad? ad;
  final String? affiliateUrl;
  final int? clickCount;
  final int? conversion;
  final String? authorId;
  // final List<Stirng?

  const PromotedAd({
    this.ad,
    this.affiliateUrl,
    this.clickCount,
    this.conversion,
    this.authorId,
  });

  PromotedAd copyWith({
    Ad? ad,
    String? affiliateUrl,
    int? clickCount,
    int? conversion,
    String? authorId,
  }) {
    return PromotedAd(
      ad: ad ?? this.ad,
      affiliateUrl: affiliateUrl ?? this.affiliateUrl,
      clickCount: clickCount ?? this.clickCount,
      conversion: conversion ?? this.conversion,
      authorId: authorId ?? this.authorId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ad': FirebaseFirestore.instance.collection(Paths.ads).doc(ad?.adId),
      'affiliateUrl': affiliateUrl,
      'clickCount': clickCount,
      'conversion': conversion,
      'authorId': authorId,
    };
  }

  static Future<PromotedAd?> fromDocument(DocumentSnapshot doc) async {
    final data = doc.data() as Map?;

    final adRef = data?['ad'] as DocumentReference?;
    final adSnap = await adRef?.get();
    return PromotedAd(
      ad: await Ad.fromDocument(adSnap),
      affiliateUrl: data?['affiliateUrl'],
      clickCount: data?['clickCount']?.toInt(),
      conversion: data?['conversion']?.toInt(),
      authorId: data?['authorId'],
    );
  }

  // factory PromotedAd.fromMap(Map<String, dynamic> map) {

  //   return PromotedAd(
  //     ad: map['ad'] != null ? Ad.fromMap(map['ad']) : null,
  //     adUrl: map['adUrl'],
  //     clickCount: map['clickCount']?.toInt(),
  //     conversion: map['conversion']?.toInt(),
  //     authorId: map['authorId'],
  //   );
  // }

  @override
  String toString() {
    return 'PromotedAd(ad: $ad, adUrl: $affiliateUrl, clickCount: $clickCount, conversion: $conversion, authorId: $authorId)';
  }

  @override
  List<Object?> get props {
    return [
      ad,
      affiliateUrl,
      clickCount,
      conversion,
      authorId,
    ];
  }
}
