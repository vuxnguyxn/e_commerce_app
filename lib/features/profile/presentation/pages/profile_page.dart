import 'package:e_commerce_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:e_commerce_app/core/constants.dart';
import 'package:e_commerce_app/core/size_config.dart';
import 'package:e_commerce_app/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:e_commerce_app/features/profile/presentation/pages/notification_page.dart';
import 'package:e_commerce_app/features/profile/presentation/widgets/dark_mode_item.dart';
import 'package:e_commerce_app/widgets/horizon_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/auth_repository.dart';
import 'address_page.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  static const String route = '/profile';

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    final user = AuthRepository().currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenWidth(kDefaultPadding)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                avatarWithEditIcon(isDarkMode: isDarkMode, user: user!),
                SizedBox(
                  height: getProportionateScreenWidth(kDefaultPadding / 2),
                ),
                Text(
                  user.displayName ?? "Peter Parker",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(kDefaultPadding / 4),
                ),
                const Text(
                  '+84 824 727 772',
                  style: TextStyle(fontSize: 14),
                ),
                const HorizonLine(),
                profileItem(
                    press: () =>
                        Navigator.pushNamed(context, EditProfilePage.route),
                    title: 'Edit profile',
                    icon: Icons.person_outline),
                profileItem(
                    press: () =>
                        Navigator.pushNamed(context, AddressPage.route),
                    title: 'Address',
                    icon: Icons.location_on_outlined),
                profileItem(
                    press: () =>
                        Navigator.pushNamed(context, NotificationPage.route),
                    title: 'Notification',
                    icon: Icons.notifications_outlined),
                profileItem(
                    press: () {}, title: 'Payment', icon: Icons.payment),
                profileItem(
                    press: () {},
                    title: 'Security',
                    icon: Icons.security_outlined),
                profileItem(
                    press: () {},
                    title: 'Security',
                    language: "English (US)",
                    icon: Icons.language_outlined),
                const DarkModeItem(),
                profileItem(
                    press: () {},
                    title: 'Privacy Policy',
                    icon: Icons.privacy_tip_outlined),
                profileItem(
                    press: () {},
                    title: 'Help Center',
                    icon: Icons.help_center_outlined),
                profileItem(
                    press: () {},
                    title: 'Invite Friend',
                    icon: Icons.supervisor_account_outlined),
                logoutItem(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack avatarWithEditIcon({required bool isDarkMode, required User user}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: user.photoURL == null
                  ? Image.asset("assets/images/profile_image.png")
                  : Image.network(user.photoURL!)),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: getProportionateScreenWidth(32),
            height: getProportionateScreenWidth(32),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isDarkMode ? Colors.white : Colors.black),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: isDarkMode ? Colors.black : Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  InkWell logoutItem(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SignInBloc>().add(const SignOut());
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(kDefaultPadding / 2),
          horizontal: getProportionateScreenWidth(kDefaultPadding),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.logout_outlined,
              color: Colors.red,
            ),
            SizedBox(
              width: getProportionateScreenWidth(kDefaultPadding / 2),
            ),
            const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }

  InkWell profileItem(
      {required VoidCallback press,
      required IconData icon,
      String? language,
      required String title}) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(kDefaultPadding / 2)),
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(kDefaultPadding)),
        width: double.infinity,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: getProportionateScreenWidth(kDefaultPadding / 2),
            ),
            Expanded(child: Text(title)),
            if (language != null) Text(language),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
