import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/registration/widgets/demographics.dart';
import '/screens/registration/widgets/target_group.dart';
import '/repositories/profile/profile_repository.dart';
import '/blocs/auth/auth_bloc.dart';
import '/screens/registration/screens/profile_completed.dart';

import '/screens/registration/widgets/add_email.dart';
import '/screens/registration/cubit/registration_cubit.dart';
import '/screens/registration/widgets/add_name.dart';
import '/widgets/loading_indicator.dart';

class RegistrationScreen extends StatelessWidget {
  static const String routeName = '/registration';
  const RegistrationScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<RegistrationCubit>(
        create: (_) => RegistrationCubit(
          profileRepository: context.read<ProfileRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..getCurrentUser(),
        child: const RegistrationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  final _authBloc = context.read<AuthBloc>().state;
    final _regCubit = context.read<RegistrationCubit>();

    return BlocConsumer<RegistrationCubit, RegistrationState>(
      listener: (context, state) {
        if (state.status == RegistrationStatus.succuss) {
          //Navigator.of(context).pushNamed(DashBoard.routeName);
        }
      },
      builder: (context, state) {
        if (state.status == RegistrationStatus.submitting) {
          return const Scaffold(body: LoadingIndicator());
        } else if (state.status == RegistrationStatus.succuss) {
          return const ProfileCompleted();
        }

        return WillPopScope(
            onWillPop: () async {
              bool canPop = false;
              switch (state.currentPage) {
                // case RegistrationCurrentPage.fName:
                //   canPop = true;
                //   break;

                case RegistrationCurrentPage.email:
                  _regCubit.changePage(RegistrationCurrentPage.fName);
                  break;

                case RegistrationCurrentPage.targetGroup:
                  _regCubit.changePage(RegistrationCurrentPage.email);
                  break;

                case RegistrationCurrentPage.demographics:
                  _regCubit.changePage(RegistrationCurrentPage.targetGroup);

                  break;
                default:
              }
              return canPop;
            },
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              //fName, email, targetGroup, demographics

                              switch (state.currentPage) {
                                case RegistrationCurrentPage.email:
                                  _regCubit.changePage(
                                      RegistrationCurrentPage.fName);
                                  break;

                                case RegistrationCurrentPage.targetGroup:
                                  _regCubit.changePage(
                                      RegistrationCurrentPage.email);
                                  break;

                                case RegistrationCurrentPage.demographics:
                                  _regCubit.changePage(
                                      RegistrationCurrentPage.targetGroup);

                                  break;
                                default:
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: state.currentPage ==
                                      RegistrationCurrentPage.fName
                                  ? Colors.white
                                  : const Color(0xffF4F4F9),
                              radius: 25.0,
                              child: Icon(
                                Icons.arrow_back,
                                color: state.currentPage ==
                                        RegistrationCurrentPage.fName
                                    ? Colors.white
                                    : const Color(0xff999999),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CurrentRegScreen(state: state)
                              // _screens(state),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}

class CurrentRegScreen extends StatelessWidget {
  final RegistrationState state;
  const CurrentRegScreen({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state.currentPage) {
      case RegistrationCurrentPage.fName:
        return const AddName();

      case RegistrationCurrentPage.email:
        return const AddEmail();

      case RegistrationCurrentPage.targetGroup:
        return const TargetGroup();

      case RegistrationCurrentPage.demographics:
        return const DemoGraphics();

      default:
        return const Scaffold();
    }
  }
}
