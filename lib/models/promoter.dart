import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Promoter extends Equatable {
  final String? email;
  final String? profileImg;
  final String? name;
  final String? phoneNumber;
  final String? promoterId;
  final DateTime? createdAt;
  final String? state;
  final List<String?> cities;
  final List<String?> ageRange;
  final List<String?> incomeRange;
  final List<String?> interest;
  final String? city;

  const Promoter({
    this.email,
    this.profileImg,
    this.name,
    this.phoneNumber,
    this.promoterId,
    this.createdAt,
    this.state,
    this.cities = const [],
    this.ageRange = const [],
    this.incomeRange = const [],
    this.interest = const [],
    this.city,
  });

  Promoter copyWith({
    String? email,
    String? profileImg,
    String? name,
    String? phoneNumber,
    String? promoterId,
    DateTime? createdAt,
    String? state,
    List<String?>? cities,
    List<String?>? ageRange,
    List<String?>? incomeRange,
    List<String?>? interest,
    String? city,
  }) {
    return Promoter(
      email: email ?? this.email,
      profileImg: profileImg ?? this.profileImg,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      promoterId: promoterId ?? this.promoterId,
      createdAt: createdAt ?? this.createdAt,
      state: state ?? this.state,
      cities: cities ?? this.cities,
      ageRange: ageRange ?? this.ageRange,
      incomeRange: incomeRange ?? this.incomeRange,
      interest: interest ?? this.interest,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'profileImg': profileImg,
      'name': name,
      'phoneNumber': phoneNumber,
      'promoterId': promoterId,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'state': state,
      'cities': cities,
      'ageRange': ageRange,
      'incomeRange': incomeRange,
      'interest': interest,
      'city': city,
    };
  }

  // factory Promoter.fromMap(Map<String, dynamic> map) {
  //   return Promoter(
  //     email: map['email'],
  //     profileImg: map['profileImg'],
  //     name: map['name'],
  //     phoneNumber: map['phoneNumber'],
  //     promoterId: map['promoterId'],
  //     createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt']) : null,
  //     state: map['state'],
  //     city: map['city'],
  //     ageRange: List<String?>.from(map['ageRange']),
  //     incomeRange: List<String?>.from(map['incomeRange']),
  //     interest: List<String?>.from(map['interest']),
  //   );
  // }

  static const empty = Promoter(
    email: '',
    name: '',
    promoterId: '',
    createdAt: null,
  );

  factory Promoter.fromDocument(DocumentSnapshot? doc) {
    /// if (doc == null) return null;
    final data = doc?.data() as Map?;

    return Promoter(
      profileImg: data?['profileImg'],
      email: data?['email'],
      name: data?['name'],
      promoterId: doc?.id,
      createdAt: data?['createdAt'] != null
          ? (data?['createdAt'] as Timestamp).toDate()
          : null,
      cities: data?['cities'] != null ? List.from(data?['cities']) : [],
      state: data?['state'],
      phoneNumber: data?['phoneNumber'],
      ageRange: data?['ageRange'] != null ? List.from(data?['ageRange']) : [],
      incomeRange:
          data?['incomeRange'] != null ? List.from(data?['incomeRange']) : [],
      interest: data?['interest'] != null ? List.from(data?['interest']) : [],
      city: data?['city'],
    );
  }

  @override
  String toString() {
    return 'Promoter(email: $email, profileImg: $profileImg, name: $name, phoneNumber: $phoneNumber, promoterId: $promoterId, createdAt: $createdAt, state: $state, cities: $cities, ageRange: $ageRange, incomeRange: $incomeRange, interest: $interest, city: $city)';
  }

  @override
  List<Object?> get props {
    return [
      email,
      profileImg,
      name,
      phoneNumber,
      promoterId,
      createdAt,
      state,
      cities,
      ageRange,
      incomeRange,
      interest,
      city
    ];
  }
}
