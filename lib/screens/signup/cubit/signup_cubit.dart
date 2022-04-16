import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prmt_promoter/repositories/profile/profile_repository.dart';
import '/models/failure.dart';
part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final _auth = FirebaseAuth.instance;
  late Timer _timer;
  final ProfileRepository _profileRepository;
  SignUpCubit({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(SignUpState.initial());

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }

  // void startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_countDown == 0) {
  //         setState(() {
  //           timer.cancel();
  //           _resendCode = true;
  //         });
  //       } else {
  //         setState(() {
  //           _countDown--;
  //         });
  //       }
  //     },
  //   );
  // }

  void checkAlreadyRegistered() async {
    emit(state.copyWith(status: SignUpStatus.submitting));
    final result =
        await _profileRepository.checkNumberUsed(phNo: '+91${state.phNo}');
    if (result) {
      emit(
        state.copyWith(
          noAlreadyUsed: true,
          status: SignUpStatus.error,
          failure: const Failure(
              message: 'This number is already used by bussiness owner'),
        ),
      );
    } else {
      emit(state.copyWith(noAlreadyUsed: result, status: SignUpStatus.initial));
    }
  }

  void initTimer() async {
    emit(state.copyWith(countDown: 30, otpSent: false));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print('Timer tick cubit -- ${timer.tick}');
      if (state.countDown == 0) {
        print('Count down is 0');
        _timer.cancel();
        // _resendCode = true;
        emit(state.copyWith(otpSent: true));
      } else {
        // print('Count down ${state.countDown}');
        emit(state.copyWith(countDown: state.countDown - 1));
      }
    });
    emit(state.copyWith(
        timer: Timer.periodic(const Duration(seconds: 1), (timer) {})));
  }

  void phoneNoChanged(String phNo) {
    emit(state.copyWith(phNo: phNo, status: SignUpStatus.initial));
  }

  void otpChanged(String otp) {
    emit(state.copyWith(otp: otp, errorOtp: false));
  }

  void verificationIdChanged() {
    emit(
      state.copyWith(
        verificationId: null,
        otpSent: false,
        status: SignUpStatus.initial,
      ),
    );
  }

  void verifyPhoneNumber({
    String? phNo,
    int? resendToken,
    bool startTimer = false,
  }) async {
    try {
      emit(state.copyWith(status: SignUpStatus.submitting));

      await _auth.verifyPhoneNumber(
        phoneNumber: '+91 ${phNo ?? state.phNo}',
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
        verificationCompleted: (credential) {
          print('Verification completed $credential');
          emit(state.copyWith(status: SignUpStatus.succuss));
        },
        codeSent: (String verificationId, int? resendToken) async {
          emit(
            state.copyWith(
              verificationId: verificationId,
              status: SignUpStatus.initial,
              otpSent: true,
              resendToken: resendToken,
            ),
          );
          if (startTimer) {
            initTimer();
          }
        },
        forceResendingToken: resendToken ?? state.resendToken,
        verificationFailed: (error) {
          print('Error in auth ${error.message}');
          emit(state.copyWith(
              failure: Failure(
                  message:
                      error.message ?? 'Error in phone number verification'),
              status: SignUpStatus.error));
        },
      );
    } catch (error) {
      print('Error in phone veifation ${error.toString()}');
      emit(state.copyWith(
          failure: const Failure(message: 'Error in phone verification'),
          status: SignUpStatus.error));
    }
  }

  void verifyOtp({required String verificationId}) async {
    try {
      if (state.otpIsEmpty) {
        // emit(state.copyWith(status: SignUpStatus.submitting));
        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: state.otp,
        );

        print('Otp send --- ${credential.smsCode}');
        print('Otp entered by user ${state.otp}');
        await _auth.signInWithCredential(credential);
        emit(state.copyWith(status: SignUpStatus.otpVerified));
      }
    } catch (error) {
      print('Error in verify otp ${error.toString()}');
      emit(state.copyWith(
          failure: const Failure(message: 'Invalid Otp'),
          errorOtp: true,
          status: SignUpStatus.error));
    }
  }
}
