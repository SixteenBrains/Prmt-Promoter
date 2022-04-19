import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/models/promoter.dart';
import '/repositories/profile/profile_repository.dart';
import '/blocs/auth/auth_bloc.dart';

import '/models/failure.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final ProfileRepository _profileRepository;
  final AuthBloc _authBloc;

  RegistrationCubit({
    required ProfileRepository profileRepository,
    required AuthBloc authBloc,
  })  : _profileRepository = profileRepository,
        _authBloc = authBloc,
        super(RegistrationState.initial());

  void fNameChanged(String value) {
    emit(state.copyWith(fName: value, status: RegistrationStatus.initial));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: RegistrationStatus.initial));
  }

  void businessNameChanged(String value) {
    emit(state.copyWith(
        businessName: value, status: RegistrationStatus.initial));
  }

  void changePage(RegistrationCurrentPage page) {
    emit(state.copyWith(currentPage: page, status: RegistrationStatus.initial));
  }

  void promoterProfileCreated() {
    emit(state.copyWith(status: RegistrationStatus.congratulation));
  }

  void getCurrentUser() async {
    try {
      emit(state.copyWith(status: RegistrationStatus.submitting));
      final promoter = await _profileRepository.getPromoterProfile(
          promoterId: _authBloc.state.promoter?.promoterId);

      print('Promoter -- $promoter');

      if (promoter != null) {
        emit(
          state.copyWith(
            promoter: promoter,
            status: RegistrationStatus.initial,
          ),
        );
      } else {
        emit(state.copyWith(status: RegistrationStatus.initial));
      }
    } on Failure catch (error) {
      emit(state.copyWith(status: RegistrationStatus.error, failure: error));
    }
  }

  void addAgeGroup(String value) {
    final List<String> ageGroupList = List.from(state.ageRange)..add(value);

    emit(state.copyWith(
        ageRange: ageGroupList,
        progress: 1,
        status: RegistrationStatus.initial));
  }

  void addProgress(int value) async {
    emit(state.copyWith(progress: value));
  }

  void addInterest(String value) {
    final List<String> interests = List.from(state.interests)..add(value);

    emit(
      state.copyWith(
        interests: interests,
        progress: 3,
        status: RegistrationStatus.initial,
      ),
    );
  }

  void addIncomeRange(String value) {
    final List<String> incomeRange = List.from(state.incomeRange)..add(value);
    emit(state.copyWith(
        incomeRange: incomeRange,
        progress: 2,
        status: RegistrationStatus.initial));
  }

  void removeAgeGroup(String value) {
    final List<String> ageGroupList = List.from(state.ageRange)..remove(value);

    print('lenght of removed age group - ${ageGroupList.length}');

    //int progress = state.progress;

    //  print('lenght of removed age group progress - $progress');

    // if (ageGroupList.isEmpty) {
    //   progress--;
    // }

    // print('lenght of removed age group progress - $progress');

    emit(state.copyWith(
        ageRange: ageGroupList,
        //  progress: progress,
        status: RegistrationStatus.initial));
  }

  void removeInterest(String value) {
    final List<String> interests = List.from(state.interests)..remove(value);
    // int progress = state.progress;

    // if (interests.isEmpty) {
    //   progress--;
    // }
    emit(state.copyWith(
        interests: interests,
        //progress: progress,
        status: RegistrationStatus.initial));
  }

  void removeIncomeRange(String value) {
    final List<String> incomeRange = List.from(state.incomeRange)
      ..remove(value);
    // int progress = state.progress;

    // if (incomeRange.isEmpty) {
    //   progress--;
    // }
    emit(state.copyWith(
        incomeRange: incomeRange,
        //progress: progress,
        status: RegistrationStatus.initial));
  }

  void loadCites() async {
    emit(state.copyWith(status: RegistrationStatus.loading));
    final cities = await _profileRepository.getStateCities(state: state.state);
    emit(state.copyWith(
        status: RegistrationStatus.initial, stateCities: cities));
  }

  void stateChanged(String value) {
    emit(state.copyWith(
        state: value, progress: 4, status: RegistrationStatus.initial));
    loadCites();
  }

  void addCity(String value) {
    List<String> cities = List<String>.from(state.selectedCities)..add(value);
    emit(state.copyWith(
        selectedCities: cities,
        progress: 5,
        status: RegistrationStatus.initial));
  }

  void removeCity(String value) {
    List<String> cities = List<String>.from(state.selectedCities)
      ..remove(value);
    emit(state.copyWith(
        selectedCities: cities, status: RegistrationStatus.initial));
  }

  void registerUser() async {
    try {
      emit(state.copyWith(status: RegistrationStatus.submitting));

      final promoter = Promoter(
        name: state.fName,
        email: state.email,
        createdAt: DateTime.now(),
        incomeRange: state.incomeRange,
        interest: state.interests,
        ageRange: state.ageRange,
        cities: state.selectedCities,
        state: state.state,
      );
      await _profileRepository.registerPromoter(
        promoter: promoter.copyWith(
          phoneNumber: _authBloc.state.promoter?.phoneNumber,
          promoterId: _authBloc.state.promoter?.promoterId,
        ),
      );

      emit(state.copyWith(status: RegistrationStatus.succuss));
    } on Failure catch (error) {
      emit(state.copyWith(status: RegistrationStatus.error, failure: error));
    }
  }
}
