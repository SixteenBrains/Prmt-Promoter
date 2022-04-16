import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_promoter/models/bussiness_user.dart';
import '/models/ad_stats.dart';
import '/enums/enums.dart';
import '/config/config.dart';

class Ad extends Equatable {
  final String? title;
  final String? adId;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? budget;
  final String? state;
  final List<String?> cities;
  final String? targetLink;
  final File? mediaFile;
  final MediaType? adType;
  final BussinessUser? author;
  final String? mediaUrl;
  final AdStats? stats;

  const Ad({
    this.title,
    this.adId,
    this.description,
    this.startDate,
    this.endDate,
    this.budget,
    this.state,
    this.cities = const [],
    this.targetLink,
    this.mediaFile,
    required this.adType,
    this.author,
    this.mediaUrl,
    this.stats,
  });

  Ad copyWith({
    String? title,
    String? adId,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? budget,
    String? state,
    List<String?>? cities,
    String? targetLink,
    File? mediaFile,
    MediaType? adType,
    BussinessUser? author,
    String? mediaUrl,
    AdStats? stats,
  }) {
    return Ad(
      title: title ?? this.title,
      adId: adId ?? this.adId,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      budget: budget ?? this.budget,
      state: state ?? this.state,
      cities: cities ?? this.cities,
      targetLink: targetLink ?? this.targetLink,
      mediaFile: mediaFile ?? this.mediaFile,
      adType: adType ?? this.adType,
      author: author ?? this.author,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      stats: stats ?? this.stats,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      // 'adId': adId,
      'description': description,
      'startDate': startDate != null ? Timestamp.fromDate(startDate!) : null,
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'budget': budget,
      'state': state,
      'cities': cities,
      'targetLink': targetLink,
      //'mediaFile': mediaFile?.toMap(),
      'adType': EnumToString.convertToString(adType),
      'author': FirebaseFirestore.instance
          .collection(Paths.promoters)
          .doc(author?.uid),
      'mediaUrl': mediaUrl,
    };
  }

  static Future<Ad?> fromDocument(DocumentSnapshot? doc) async {
    final data = doc?.data() as Map?;
    print('Ad data $data');
    if (data != null) {
      final userRef = data['author'] as DocumentReference?;
      final userSnap = await userRef?.get();

      final statsSnaps = await FirebaseFirestore.instance
          .collection(Paths.stats)
          .doc(doc?.id)
          .get();

      final statsData = statsSnaps.data();

      print('Stats data --- $statsData');

      return Ad(
        title: data['title'],
        adId: doc?.id,
        description: data['description'],
        stats: statsData != null ? AdStats.fromMap(statsData) : null,
        // ageGroup:
        //     data['ageGroup'] != null ? List<String>.from(data['ageGroup']) : [],
        // incomeRange: data['incomeRange'] != null
        //     ? List<String>.from(data['incomeRange'])
        //     : [],
        // interests: data['interests'] != null
        //     ? List<String>.from(data['interests'])
        //     : [],
        budget: data['budget'],
        state: data['state'],
        cities: data['cities'] != null ? List<String>.from(data['cities']) : [],
        startDate: data['startDate'] != null
            ? (data['startDate'] as Timestamp).toDate()
            : null,
        endDate: data['endDate'] != null
            ? (data['endDate'] as Timestamp).toDate()
            : null,
        targetLink: data['targetLink'],
        author: userSnap != null ? BussinessUser.fromDocument(userSnap) : null,
        mediaUrl: data['mediaUrl'],
        adType: EnumToString.fromString(
          MediaType.values,
          data['adType'],
        ),
      );
    }
    return null;
  }

  @override
  String toString() {
    return 'AdMo(title: $title, adId: $adId, description: $description, startDate: $startDate, endDate: $endDate, budget: $budget, state: $state, city: $cities, targetLink: $targetLink, mediaFile: $mediaFile, adType: $adType, author: $author, mediaUrl: $mediaUrl, stats: $stats)';
  }

  @override
  List<Object?> get props {
    return [
      title,
      adId,
      description,
      startDate,
      endDate,
      budget,
      state,
      cities,
      targetLink,
      mediaFile,
      adType,
      author,
      mediaUrl,
      stats,
    ];
  }
}
