import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:prmt_promoter/repositories/profile/profile_repository.dart';
import '/widgets/show_snackbar.dart';
import '/widgets/loading_indicator.dart';
import '/screens/signup/cubit/signup_cubit.dart';
import '/widgets/bottom_nav_button.dart';

class OtpScreenArgs {
  final String verificationId;
  final String phoNo;
  final int? resentToken;

  OtpScreenArgs({
    required this.verificationId,
    required this.phoNo,
    required this.resentToken,
  });
}

class OtpScreen extends StatefulWidget {
  static const routeName = '/otp';
  final String verificationId;
  final String phonNo;
  final int? resendToken;
  const OtpScreen({
    Key? key,
    required this.verificationId,
    required this.phonNo,
    required this.resendToken,
  }) : super(key: key);

  static Route route({required OtpScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) =>
            SignUpCubit(profileRepository: context.read<ProfileRepository>())
              ..initTimer(),
        child: OtpScreen(
          verificationId: args.verificationId,
          phonNo: args.phoNo,
          resendToken: args.resentToken,
        ),
      ),
    );
  }

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  void _submitOtp(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      final _signupCubit = context.read<SignUpCubit>();
      if (_signupCubit.state.otpIsEmpty) {
        _signupCubit.verifyOtp(verificationId: widget.verificationId);
      } else {
        ShowSnackBar.showSnackBar(context,
            title: 'Please enter otp to continue');
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  // ignore: close_sinks
  // StreamController<ErrorAnimationType>? _errorController;

  @override
  void initState() {
    //_errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    //_errorController!.close();
    context.read<SignUpCubit>().close();
    _formKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            // if (state.status == SignUpStatus.otpVerified) {
            //   ShowSnackBar.showSnackBar(context, title: 'Login succussfull');
            // }
            // if (state.status == SignUpStatus.error) {
            //   //ShowSnackBar.showSnackBar(context, title: state.failure?.message);
            //   showDialog(
            //       context: context,
            //       builder: (context) {
            //         return ErrorDialog(content: state.failure?.message);
            //       });
            // } else if (state.status == SignUpStatus.succuss) {
            //   ShowSnackBar.showSnackBar(context, title: 'Login succussfull');
            // }
          },
          builder: (context, state) {
            if (state.status == SignUpStatus.submitting) {
              return const LoadingIndicator();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 25.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 25.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(true),
                        child: const CircleAvatar(
                          backgroundColor: Color(0xffF4F4F9),
                          radius: 25.0,
                          child: Icon(
                            Icons.arrow_back,
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'We have sent you\nan OTP',
                      style: GoogleFonts.openSans(
                        color: Colors.grey.shade800,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      'Enter the 6 digit OTP sent on ${widget.phonNo} to proceed',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    PinCodeTextField(
                      // errorAnimationController: _errorController,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        errorBorderColor: Colors.red,
                        inactiveColor: Colors.grey.shade500,
                        selectedFillColor: Colors.white,
                        disabledColor: Colors.white,
                        ////  shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        // fieldHeight: 50,
                        // fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (state.errorOtp) {
                          // _errorController!.add(ErrorAnimationType.shake);
                          return 'Invalid OTP';
                        } else {
                          return null;
                        }
                      },
                      appContext: context,
                      length: 6,
                      onChanged: (value) =>
                          context.read<SignUpCubit>().otpChanged(value),
                    ),
                    const SizedBox(height: 22.0),
                    if (!state.otpSent)
                      Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.blue),
                          const SizedBox(width: 7.0),
                          Text(
                            'Resend OTP in ${state.countDown}s',
                            style: const TextStyle(
                              color: Color(0xff666666),
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                    if (state.otpSent)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Didn\'t Receive OTP?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.refresh,
                                    color: Colors.blue,
                                  ),
                                  TextButton(
                                    onPressed: () => context
                                        .read<SignUpCubit>()
                                        .verifyPhoneNumber(
                                          phNo: widget.phonNo,
                                          resendToken: widget.resendToken,
                                          startTimer: true,
                                        ),
                                    child: const Text(
                                      'Resend OTP',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text(
                                  'Change Number',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    const Spacer(),
                    BottomNavButton(
                      onTap: () => _submitOtp(context),
                      label: 'CONTINUE',
                      isEnabled: state.otp.length == 6,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
