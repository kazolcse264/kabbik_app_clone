
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/add_audio_screen/add_audio_book.dart';

class TopSearchSectionWidget extends StatelessWidget {
  const TopSearchSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout,size: 30,),
            color: Colors.white,

          ),
          SizedBox(
            width: 150.w,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.subscriptions,
              color: Colors.white,
            ),
            label: const Text(
              'Subscribe',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.redAccent, // Set the desired background color here
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AddAudioBookPage.routeName);
              },
              child: const Icon(
                Icons.add_box_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
