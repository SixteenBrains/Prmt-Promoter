import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/promoted_ad.dart';
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

  Future<void> promoteAd({
    // required String? userId,
    // required String? adId,
    required PromotedAd? promotedAd,
    required String shareId,
  }) async {
    /// Todo : change in promote ad repo
    /// add promote in ad collection rep

    try {
      if (promotedAd != null) {
        print('This runs');
        // add if ad already in database, we will only update affliate link

        await _firestore
            .collection(Paths.ads)
            .doc(promotedAd.ad?.adId)
            .collection(Paths.promoters)
            .doc(promotedAd.authorId)
            .set({});

        final adRef = _firestore
            .collection(Paths.promotedAds)
            .doc(promotedAd.authorId)
            .collection(Paths.ads)
            .doc(promotedAd.ad?.adId);

        print('Documetn ref --- $adRef');

        final DocumentSnapshot adSnap = await adRef.get();
        print('Documetn snap --- $adSnap');

        final adData = adSnap.data() as Map?;

        print('Ad Data $adData');

        final List clicks = adData?['clicks'] ?? [];

        print('clicks $clicks');

        if (adSnap.exists) {
          // update document
          print('Product exists ---');

          await adRef.update({
            'affiliateUrl': promotedAd.affiliateUrl,
            'clicks': List.from(clicks)..remove(shareId),
          });
        } else {
          print('Product donot exists ---');
          await adRef.set(promotedAd.toMap());
        }

        // _firestore
        //     .collection(Paths.promotedAds)
        //     .doc(promotedAd.authorId)
        //     .collection(Paths.ads)
        //     .doc(promotedAd.ad?.adId)
        //     .set(promotedAd.toMap());

        // _firestore
        //     .collection(Paths.promotedAds)
        //     .doc(promotedAd.authorId)
        //     .set({'id': promotedAd.authorId});
      }
    } catch (error) {
      print('Error in promoting ad ${error.toString()}');
      throw const Failure(message: 'Error in promoting');
    }
  }

  Future<List<Future<PromotedAd?>>> getUserPromotedAds(
      {required String? promoterId}) async {
    try {
      if (promoterId == null) {
        return [];
      }
      // List<Ad?> promotedAds = [];
      final adsSnaps = await _firestore
          .collection(Paths.promotedAds)
          .doc(promoterId)
          .collection(Paths.ads)
          .get();

      // return adsSnaps.docs.map((doc) => null).toList();

      return adsSnaps.docs
          .map((doc) async => PromotedAd.fromDocument(doc))
          .toList();

      // for (var element in adsSnaps.docs) {
      //   final adRef = element.data()['ad'] as DocumentReference?;
      //   final adData = await adRef?.get();
      //   if (adData != null) {
      //     promotedAds.add(await Ad.fromDocument(adData));
      //   }
      // }
      // return promotedAds;
    } catch (error) {
      print('Error in getting promoted ads ${error.toString()}');
      throw const Failure(message: 'Error in getting promoted ads');
    }
  }
}
