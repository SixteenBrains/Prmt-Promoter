part of 'signup_cubit.dart';

enum SignUpStatus { initial, submitting, succuss, error, otpVerified }

class SignUpState extends Equatable {
  final String phNo;
  final SignUpStatus status;
  final Failure? failure;
  final String? verificationId;
  final String otp;
  final bool errorOtp;
  final bool otpSent;
  final int? resendToken;
  final Timer? timer;
  final int countDown;
  final bool noAlreadyUsed;

  const SignUpState({
    required this.phNo,
    required this.status,
    this.failure,
    this.verificationId,
    this.otp = '',
    this.otpSent = false,
    this.errorOtp = false,
    this.resendToken,
    this.timer,
    this.countDown = 30,
    this.noAlreadyUsed = false,
  });

  factory SignUpState.initial() =>
      const SignUpState(phNo: '', status: SignUpStatus.initial);

  bool get phNoIsEmpty => phNo.length == 10;

  bool get otpIsEmpty => otp.length == 6;

  @override
  List<Object?> get props => [
        phNo,
        status,
        failure,
        otp,
        verificationId,
        errorOtp,
        otpSent,
        resendToken,
        timer,
        countDown,
        noAlreadyUsed,
      ];

  SignUpState copyWith({
    String? phNo,
    SignUpStatus? status,
    Failure? failure,
    String? otp,
    String? verificationId,
    bool? errorOtp,
    bool? otpSent,
    int? resendToken,
    Timer? timer,
    int? countDown,
    bool? noAlreadyUsed,
  }) {
    return SignUpState(
      phNo: phNo ?? this.phNo,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      otp: otp ?? this.otp,
      verificationId: verificationId ?? this.verificationId,
      errorOtp: errorOtp ?? this.errorOtp,
      otpSent: otpSent ?? this.otpSent,
      resendToken: resendToken ?? this.resendToken,
      timer: timer ?? this.timer,
      countDown: countDown ?? this.countDown,
      noAlreadyUsed: noAlreadyUsed ?? this.noAlreadyUsed,
    );
  }
}
