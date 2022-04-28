import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '/repositories/profile/profile_repository.dart';
import '/blocs/auth/auth_bloc.dart';

import '/screens/profile/cubit/profile_cubit.dart';
import '/widgets/custom_textfield.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/bottom_nav_button.dart';

class EditProfile extends StatelessWidget {
  static const String routeName = '/editProfile';
  EditProfile({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<ProfileCubit>(
        create: (context) => ProfileCubit(
          authBloc: context.read<AuthBloc>(),
          profileRepository: context.read<ProfileRepository>(),
        )..loadProfile(),
        child: EditProfile(),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileCubit>().editProfile();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.grey,
          size: 25.0,
        ),
        title: const Text('Profile Details'),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return const LoadingIndicator();
          }
          final _user = state.promoter;
          return Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        CustomTextField(
                          initialValue: _user?.phoneNumber,
                          enabled: false,
                          labelText: 'Mobile Number',
                          hintText: 'Enter your mobile number',
                          onchanged: (value) {},
                          validator: (value) {
                            return null;
                          },
                          inputType: TextInputType.number,
                        ),
                        const SizedBox(height: 25.0),
                        CustomTextField(
                          initialValue: _user?.email,
                          enabled: false,
                          labelText: 'Email ID',
                          hintText: 'Enter your email id',
                          onchanged: (value) {},
                          validator: (value) {
                            return null;
                          },
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 25.0),
                        CustomTextField(
                          initialValue: state.promoter?.name,
                          labelText: 'Full Name',
                          hintText: 'Enter full name',
                          onchanged: (value) =>
                              context.read<ProfileCubit>().nameChanged(value),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name can\'t be empty';
                            }
                            return null;
                          },
                          inputType: TextInputType.name,
                        ),
                        const SizedBox(height: 25.0),
                        CustomTextField(
                          initialValue: state.promoter?.state,
                          labelText: 'State',
                          hintText: 'Enter your state',
                          onchanged: (value) => context
                              .read<ProfileCubit>()
                              .stateNameChaned(value),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'State name can\'t be empty';
                            }
                            return null;
                          },
                          inputType: TextInputType.name,
                        ),
                        const SizedBox(height: 25.0),
                        CustomTextField(
                          initialValue: state.promoter?.city,
                          labelText: 'City',
                          hintText: 'Enter your city name',
                          onchanged: (value) => context
                              .read<ProfileCubit>()
                              .cityNameChanged(value),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'City name can\'t be empty';
                            }
                            return null;
                          },
                          inputType: TextInputType.name,
                        ),
                        const SizedBox(height: 120.0)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 18.0,
                right: 15.0,
                left: 15.0,
                child: BottomNavButton(
                  label: 'SAVE DETAILS',
                  isEnabled: true,
                  onTap: () => _submit(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
