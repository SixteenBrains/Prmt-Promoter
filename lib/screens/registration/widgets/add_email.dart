import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/registration/cubit/registration_cubit.dart';
import '/widgets/custom_textfield.dart';
import '/widgets/bottom_nav_button.dart';

class AddEmail extends StatefulWidget {
  const AddEmail({Key? key}) : super(key: key);

  @override
  State<AddEmail> createState() => _AddEmailState();
}

class _AddEmailState extends State<AddEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your Email ID',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Enter your email address to get your\nupdates on your email.',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                initialValue: state.email,
                hintText: 'Eg - abc@gmail.com',
                onchanged: (value) =>
                    context.read<RegistrationCubit>().emailChanged(value),
                validator: (value) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);
                  if (!emailValid) {
                    return 'Email Invalid';
                  }
                  return null;
                },
                inputType: TextInputType.emailAddress,
              ),
              const Spacer(),
              BottomNavButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<RegistrationCubit>()
                        .changePage(RegistrationCurrentPage.targetGroup);
                  }
                },
                label: 'CONTINUE',
                isEnabled: state.email.isNotEmpty,
              ),
            ],
          ),
        );
      },
    );
  }
}
