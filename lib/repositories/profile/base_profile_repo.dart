import '/models/promoter.dart';

abstract class BaseProfileRepository {
  Future<void> registerPromoter({required Promoter promoter});

  Future<Promoter?> getPromoterProfile({
    required String? promoterId,
  });
}
