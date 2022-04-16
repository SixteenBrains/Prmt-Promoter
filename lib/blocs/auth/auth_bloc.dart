import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/models/promoter.dart';
import '/repositories/profile/profile_repository.dart';
import '/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late StreamSubscription<Promoter?> _promoterSubscription;
  final ProfileRepository _profileRepository;

  AuthBloc({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  })  : _authRepository = authRepository,
        _profileRepository = profileRepository,
        super(AuthState.unknown()) {
    _promoterSubscription = _authRepository.onAuthChanges.listen(
      (user) async {
        final promoter = await _profileRepository.getPromoterProfile(
            promoterId: user?.promoterId);
        add(
          AuthUserChanged(
            promoter: user?.copyWith(
              profileImg: promoter?.profileImg,
              createdAt: promoter?.createdAt,
              state: promoter?.state,
              cities: promoter?.cities,
              name: promoter?.name,
              email: promoter?.email,
              ageRange: promoter?.ageRange,
              incomeRange: promoter?.incomeRange,
              interest: promoter?.interest,
            ),
          ),
        );
      },
    );
    on<AuthEvent>((event, emit) async {
      if (event is AuthUserChanged) {
        emit(
          event.promoter != null
              ? AuthState.authenticated(promoter: event.promoter)
              : AuthState.unAuthenticated(),
        );
      } else if (event is AuthLogoutRequested) {
        await _authRepository.signOut();
      } else if (event is UserProfileImageChanged) {
        emit(state.copyWith(
            promoter: state.promoter?.copyWith(profileImg: event.imgUrl)));
      }
    });
  }

  @override
  Future<void> close() {
    _promoterSubscription.cancel();
    return super.close();
  }
}
