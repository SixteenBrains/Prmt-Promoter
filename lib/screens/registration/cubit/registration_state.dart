part of 'registration_cubit.dart';

enum RegistrationStatus {
  initial,
  loading,
  submitting,
  succuss,
  error,
  congratulation
}

enum RegistrationCurrentPage { fName, email, targetGroup, demographics }

class RegistrationState extends Equatable {
  final String fName;
  final String email;
  final RegistrationStatus status;
  final Failure failure;
  final RegistrationCurrentPage currentPage;
  final Promoter? promoter;
  final int progress;
  final List<String> ageRange;
  final List<String> incomeRange;
  final List<String> interests;
  final String state;
  final List<String> stateCities;
  final List<String> selectedCities;

  const RegistrationState({
    required this.fName,
    required this.email,
    required this.status,
    required this.failure,
    required this.currentPage,
    required this.promoter,
    required this.progress,
    required this.ageRange,
    required this.incomeRange,
    required this.interests,
    required this.state,
    required this.stateCities,
    required this.selectedCities,
  });

  factory RegistrationState.initial() => const RegistrationState(
        fName: '',
        email: '',
        status: RegistrationStatus.initial,
        failure: Failure(),
        currentPage: RegistrationCurrentPage.fName,
        promoter: null,
        progress: 0,
        ageRange: [],
        incomeRange: [],
        interests: [],
        selectedCities: [],
        state: 'Maharashtra',
        stateCities: [],
      );

  @override
  List<Object?> get props {
    return [
      fName,
      email,
      status,
      failure,
      currentPage,
      promoter,
      progress,
      ageRange,
      incomeRange,
      interests,
      selectedCities,
      state,
      stateCities,
    ];
  }

  RegistrationState copyWith({
    String? fName,
    String? email,
    String? businessName,
    RegistrationStatus? status,
    Failure? failure,
    RegistrationCurrentPage? currentPage,
    Promoter? promoter,
    int? progress,
    List<String>? ageRange,
    List<String>? incomeRange,
    List<String>? interests,
    String? state,
    List<String>? stateCities,
    List<String>? selectedCities,
  }) {
    return RegistrationState(
      fName: fName ?? this.fName,
      email: email ?? this.email,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      currentPage: currentPage ?? this.currentPage,
      promoter: promoter ?? this.promoter,
      progress: progress ?? this.progress,
      ageRange: ageRange ?? this.ageRange,
      incomeRange: incomeRange ?? this.incomeRange,
      interests: interests ?? this.interests,
      selectedCities: selectedCities ?? this.selectedCities,
      state: state ?? this.state,
      stateCities: stateCities ?? this.stateCities,
    );
  }
}
