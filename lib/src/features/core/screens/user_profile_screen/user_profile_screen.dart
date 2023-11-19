import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/user_profile_screen/widgets/user_profile_image_section.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/global_functions.dart';
import '../../../auth/controllers/user_provider.dart';
import '../../models/address_model.dart';
import '../../models/user_model.dart';
import 'otp_verification_page.dart';

class UserProfileScreen extends StatefulWidget {
  static const String routeName = '/user_profile';

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout,color: Colors.white,),
          )
        ],
      ),
      body: userProvider.userModel == null
          ? const Center(child: Text('Failed to load user Data!'))
          : ListView(
        children: [
          UserProfileImageSection(userProvider: userProvider),
          //_headerSection(context, userProvider),
          ListTile(
            leading: const Icon(Icons.call,color: Colors.white,),
            title: Text(userProvider.userModel!.phone ?? 'Not Set Yet',style: const TextStyle(color: Colors.white,),),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Mobile Number',
                  onSubmit: (value) {
                    Navigator.pushNamed(
                        context, OtpVerificationPage.routeName,
                        arguments: value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.white,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month,color: Colors.white,),
            title: Text(userProvider.userModel!.age ?? 'Not Set Yet',style: const TextStyle(color: Colors.white,),),
            subtitle: const Text('Date of Birth',style: TextStyle(color: Colors.white,),),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit,color: Colors.white,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person,color: Colors.white,),
            title: Text(userProvider.userModel!.gender ?? 'Not Set Yet',style: const TextStyle(color: Colors.white,),),
            subtitle: const Text('Gender',style: TextStyle(color: Colors.white,),),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit,color: Colors.white,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_city,color: Colors.white,),
            title: Text(
                userProvider.userModel!.addressModel?.addressLine1 ??
                    'Not Set Yet',style: const TextStyle(color: Colors.white,),),
            subtitle: const Text('Address Line 1',style: TextStyle(color: Colors.white,),),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Address Line 1',
                  onSubmit: (value) {
                    userProvider.updateUserProfileField(
                        '$userFieldAddressModel.$addressFieldAddressLine1',
                        value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.white,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_city,color: Colors.white,),
            title: Text(
                userProvider.userModel!.addressModel?.addressLine2 ??
                    'Not Set Yet',style: const TextStyle(color: Colors.white,),),
            subtitle: const Text('Address Line 2',style: TextStyle(color: Colors.white,),),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Address Line 2',
                  onSubmit: (value) {
                    userProvider.updateUserProfileField(
                        '$userFieldAddressModel.$addressFieldAddressLine2',
                        value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.white,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_city,color: Colors.white,),
            title: Text(userProvider.userModel!.addressModel?.city ??
                'Not Set Yet',style: const TextStyle(color: Colors.white,),),
            subtitle: const Text('City',style: TextStyle(color: Colors.white,),),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'City',
                  onSubmit: (value) {
                    userProvider.updateUserProfileField(
                        '$userFieldAddressModel.$addressFieldCity',
                        value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.white,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_city,color: Colors.white,),
            title: Text(userProvider.userModel!.addressModel?.zipcode ??
                'Not Set Yet',style: const TextStyle(color: Colors.white,),),
            subtitle: const Text('Zip Code',style: TextStyle(color: Colors.white,),),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Zip Code',
                  onSubmit: (value) {
                    userProvider.updateUserProfileField(
                        '$userFieldAddressModel.$addressFieldZipcode',
                        value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}