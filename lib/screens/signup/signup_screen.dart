import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prmt_promoter/repositories/profile/profile_repository.dart';
import '/screens/signup/otp_screen.dart';
import '/widgets/error_dialog.dart';
import '/widgets/loading_indicator.dart';
import '/screens/signup/cubit/signup_cubit.dart';
import '/widgets/bottom_nav_button.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/signup';
  SignUpScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => SignUpCubit(
          profileRepository: context.read<ProfileRepository>(),
        ),
        child: SignUpScreen(),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate() && !isSubmitting) {
      final _signupCubit = context.read<SignUpCubit>();
      if (_signupCubit.state.phNoIsEmpty) {
        _signupCubit.checkAlreadyRegistered();

        if (_signupCubit.state.noAlreadyUsed) {
          _signupCubit.verifyPhoneNumber();
        }
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) async {
              print('Verification id ----${state.verificationId}');
              if (state.status == SignUpStatus.error) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ErrorDialog(content: state.failure?.message);
                    });
              } else if (state.otpSent &&
                  state.status == SignUpStatus.initial) {
                //  else if (state.verificationId != null &&
                //     state.verificationId!.isNotEmpty) {

                final result = await Navigator.of(context).pushNamed(
                  OtpScreen.routeName,
                  arguments: OtpScreenArgs(
                    verificationId: state.verificationId!,
                    phoNo: state.phNo,
                    resentToken: state.resendToken,
                  ),
                );
                context.read<SignUpCubit>().verificationIdChanged();
                if (result == true) {
                  context.read<SignUpCubit>().verificationIdChanged();
                }
              }
            },
            builder: (context, state) {
              if (state.status == SignUpStatus.submitting) {
                return const LoadingIndicator();
              }
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 25.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 25.0),
                          // Align(
                          //   alignment: Alignment.topLeft,
                          //   child: GestureDetector(
                          //     onTap: () => Navigator.of(context).pop(),
                          //     child: const CircleAvatar(
                          //       backgroundColor: Color(0xffF4F4F9),
                          //       radius: 25.0,
                          //       child: Icon(
                          //         Icons.arrow_back,
                          //         color: Color(0xff999999),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Your Mobile Number',
                            style: GoogleFonts.openSans(
                              color: Colors.grey.shade800,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            'To start the app, we need your mobile number linked',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  '+91',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: TextFormField(
                                  initialValue: state.phNo,
                                  maxLength: 10,
                                  style: const TextStyle(fontSize: 20.0),
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) => context
                                      .read<SignUpCubit>()
                                      .phoneNoChanged(value),
                                  decoration: InputDecoration(
                                    hintText: 'Eg - 1234567890',
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // const Spacer(),
                          SizedBox(height: _canvas.height * 0.61),
                          BottomNavButton(
                            onTap: () => _submitForm(context,
                                state.status == SignUpStatus.submitting),
                            label: 'CONTINUE',
                            isEnabled: state.phNoIsEmpty,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
