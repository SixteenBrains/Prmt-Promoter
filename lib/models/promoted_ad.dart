import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '/config/paths.dart';
import '/models/ad.dart';

class PromotedAd extends Equatable {
  final Ad? ad;
  final String? affiliateUrl;
  final int? clickCount;
  final int? conversion;
  final String? authorId;
  final List<String?> clicks;

  final List<String?> promoters;

  const PromotedAd({
    this.ad,
    this.affiliateUrl,
    this.clickCount,
    this.conversion,
    this.authorId,
    this.promoters = const [],
    this.clicks = const [],
  });

  PromotedAd copyWith({
    Ad? ad,
    String? affiliateUrl,
    int? clickCount,
    int? conversion,
    String? authorId,
    List<String?>? promoters,
    List<String?>? clicks,
  }) {
    return PromotedAd(
      ad: ad ?? this.ad,
      affiliateUrl: affiliateUrl ?? this.affiliateUrl,
      clickCount: clickCount ?? this.clickCount,
      conversion: conversion ?? this.conversion,
      authorId: authorId ?? this.authorId,
      promoters: promoters ?? this.promoters,
      clicks: clicks ?? this.clicks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ad': FirebaseFirestore.instance.collection(Paths.ads).doc(ad?.adId),
      'affiliateUrl': affiliateUrl,
      'clickCount': clickCount,
      'conversion': conversion,
      'authorId': authorId,
      'promoters': promoters,
      'clicks': clicks,
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
      promoters:
          data?['promoters'] != null ? List.from(data?['promoters']) : [],
      clicks: data?['clicks'] != null ? List.from(data?['clicks']) : [],
    );
  }

  @override
  String toString() {
    return 'PromotedAd(ad: $ad, adUrl: $affiliateUrl, clickCount: $clickCount, conversion: $conversion, authorId: $authorId, clicks: $clicks)';
  }

  @override
  List<Object?> get props {
    return [
      ad,
      affiliateUrl,
      clickCount,
      conversion,
      authorId,
      promoters,
      clicks,
    ];
  }
}
