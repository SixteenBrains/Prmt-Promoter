import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';
import '/models/ad.dart';
import '/models/failure.dart';
import 'base_ads_repo.dart';

class AdsRepository extends BaseAdRepostory {
  final FirebaseFirestore _firestore;

  AdsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Future<Ad?>>> getLiveAds() async {
    try {
      final today = Timestamp.fromDate(DateTime.now());
      final adsSnaps = await _firestore
          .collection(Paths.ads)
          .where('endDate', isGreaterThanOrEqualTo: today)
          .get();

      return adsSnaps.docs.map((doc) => Ad.fromDocument(doc)).toList();
    } catch (error) {
      print('Error in getting live ads ${error.toString()}');
      throw const Failure(message: 'Error in getting live ads');
    }
  }

  Future<void> promoteAd(
      {required String? userId, required String? adId}) async {
    try {
      if (userId != null && adId != null) {
        _firestore
            .collection(Paths.promotedAds)
            .doc(userId)
            .collection(Paths.ads)
            .doc(adId)
            .set({'ad': _firestore.collection(Paths.ads).doc(adId)});
      }
    } catch (error) {
      print('Error in promoting ad ${error.toString()}');
      throw const Failure(message: 'Error in promoting');
    }
  }

  Future<List<Ad?>> getUserPromotedAds({required String? promoterId}) async {
    try {
      if (promoterId == null) {
        return [];
      }
      List<Ad?> promotedAds = [];
      final adsSnaps = await _firestore
          .collection(Paths.promotedAds)
          .doc(promoterId)
          .collection(Paths.ads)
          .get();

      for (var element in adsSnaps.docs) {
        final adRef = element.data()['ad'] as DocumentReference?;
        final adData = await adRef?.get();
        if (adData != null) {
          promotedAds.add(await Ad.fromDocument(adData));
        }
      }
      return promotedAds;
    } catch (error) {
      print('Error in getting promoted ads ${error.toString()}');
      throw const Failure(message: 'Error in getting promoted ads');
    }
  }
}
