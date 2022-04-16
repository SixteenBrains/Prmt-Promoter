import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/registration/cubit/registration_cubit.dart';
import '/widgets/custom_textfield.dart';
import '/widgets/bottom_nav_button.dart';

class AddName extends StatefulWidget {
  const AddName({Key? key}) : super(key: key);

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                'Awesome!',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Now tell us your Full Name',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Enter your full name here.',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                initialValue: state.fName,
                onchanged: (value) =>
                    context.read<RegistrationCubit>().fNameChanged(value),
                hintText: 'Eg -John Doe',
                validator: (value) {
                  if (value!.length < 4) {
                    return 'Name too short';
                  }
                  return null;
                },
                inputType: TextInputType.name,
              ),
              const Spacer(),
              BottomNavButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<RegistrationCubit>()
                        .changePage(RegistrationCurrentPage.email);
                  }
                },
                label: 'CONTINUE',
                isEnabled: state.fName.isNotEmpty,
              ),
            ],
          ),
        );
      },
    );
  }
}
