part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, succuss, error, imgUploaded }

class ProfileState extends Equatable {
  final Promoter? promoter;
  final ProfileStatus status;
  final Failure failure;
  final File? imageFile;
  final String? name;
  final String? stateName;
  final String? cityName;

  const ProfileState({
    required this.promoter,
    required this.status,
    required this.failure,
    this.stateName,
    this.name,
    this.cityName,
    this.imageFile,
  });

  factory ProfileState.initial() => const ProfileState(
      promoter: null, status: ProfileStatus.initial, failure: Failure());

  @override
  List<Object?> get props =>
      [promoter, failure, status, imageFile, name, cityName, stateName];

  ProfileState copyWith({
    Promoter? promoter,
    ProfileStatus? status,
    Failure? failure,
    File? imageFile,
    String? name,
    String? cityName,
    String? stateName,
  }) {
    return ProfileState(
      promoter: promoter ?? this.promoter,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      imageFile: imageFile ?? this.imageFile,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      name: name ?? this.name,
    );
  }

  @override
  String toString() =>
      'ProfileState(promoter: $promoter, status: $status, failure: $failure, imageFile: $imageFile, city: $cityName)';
}
