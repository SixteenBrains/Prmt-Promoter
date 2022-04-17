import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import '/repositories/profile/profile_repository.dart';
import '/utils/media_util.dart';
import '/widgets/display_image.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/show_snackbar.dart';

import '/blocs/auth/auth_bloc.dart';
import 'cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<ProfileCubit>(
        create: (context) => ProfileCubit(
          profileRepository: context.read<ProfileRepository>(),
          authBloc: context.read<AuthBloc>(),
        ),
        //..loadProfile(),
        child: const ProfileScreen(),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final pickedImage = await MediaUtil.pickImageFromGallery(
      cropStyle: CropStyle.circle,
      context: context,
      imageQuality: 60,
      title: 'Crop and resize',
    );
    if (pickedImage != null) {
      // context.read<ProfileCubit>().imagePicked(pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.imgUploaded) {
            ShowSnackBar.showSnackBar(context, title: 'Pofile image updated');
          }
        },
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return const LoadingIndicator();
          }
          return Column(
            children: [
              Container(
                height: 310.0,
                width: double.infinity,
                color: const Color(0xffCAF0F8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.clear,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => context
                                .read<AuthBloc>()
                                .add(AuthLogoutRequested()),
                            icon: const Icon(Icons.logout),
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 70.0,
                            child: ClipOval(
                              child: state.imageFile == null
                                  ? DisplayImage(
                                      imageUrl: state.promoter?.profileImg,
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                    )
                                  : Image.file(
                                      state.imageFile!,
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _pickImage(context),
                            child: const CircleAvatar(
                              radius: 18.0,
                              backgroundColor: Colors.white,
                              child: Icon(
                                FontAwesomeIcons.penToSquare,
                                size: 16.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 22.0),
                      SizedBox(
                        height: 30.0,
                        child: Text(
                          'Welcome to PRMT, ${state.promoter?.name ?? ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          // onTap: () => Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) => const MyAds(),
                          //   ),
                          // ),
                          child: Container(
                            // height: 90.0,
                            width: _canvas.width * 0.43,
                            decoration: BoxDecoration(
                              color: const Color(0xffF4F4F9),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 20.0,
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      FontAwesomeIcons.bullhorn,
                                      size: 20.0,
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        '4',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Text(
                                        'My Ads',
                                        style: TextStyle(fontSize: 16.0),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          // onTap: () => Navigator.of(context)
                          //     .pushNamed(EditProfile.routeName),
                          child: Container(
                            // height: 90.0,
                            width: _canvas.width * 0.43,
                            decoration: BoxDecoration(
                              color: const Color(0xffF4F4F9),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 20.0,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22.0,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: DisplayImage(
                                        imageUrl: state.promoter?.profileImg,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'My',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        'Profile',
                                        style: TextStyle(fontSize: 16.0),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          // onTap: () => Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (_) => const MyNotifications())),
                          child: Container(
                            // height: 90.0,
                            width: _canvas.width * 0.43,
                            decoration: BoxDecoration(
                              color: const Color(0xffF4F4F9),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 20.0,
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.notifications),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'My',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        'Notificaton',
                                        style: TextStyle(fontSize: 16.0),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        ProfileTile(
                          width: _canvas.width * 0.43,
                          label: 'Withdrawal History',
                          icon: FontAwesomeIcons.timeline,
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        ProfileTile(
                          width: _canvas.width * 0.43,
                          label: 'Withdrawal History',
                          icon: FontAwesomeIcons.timeline,
                        )
                      ],
                    )
                    //const Spacer(),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text('Logout'),
                    // ),
                    // const SizedBox(height: 20.0),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final double width;
  final String label;
  final IconData icon;

  const ProfileTile({
    Key? key,
    required this.width,
    required this.label,
    required this.icon,
  }) : super(key: key);

  //

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90.0,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xffF4F4F9),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20.0,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                //FontAwesomeIcons.timeline,
                //FontAwesomeIcons.question,
                size: 20.0,
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Help &',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Support',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
