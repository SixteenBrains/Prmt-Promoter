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
}
