import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabbik_ui_clone/src/constants/colors.dart';
import 'package:kabbik_ui_clone/src/features/core/models/audio_book.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/dashboard/methods/media_item_creation.dart';
import '../features/core/screens/audio_book_details_page/details_page.dart';
import '../services/page_manager.dart';
import '../services/service_locator.dart';

class AudioBookCard extends StatelessWidget {
  const AudioBookCard({
    Key? key,
    required this.audioBook,
  }) : super(key: key);

  final AudioBookF audioBook;

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    final audioHandler = getIt<AudioHandler>();
    return InkWell(
      onTap: ()  {
        createAndAddMediaItem(
          audioBook: audioBook,
          pageManager: pageManager,
          audioHandler: audioHandler,
        );
        Navigator.of(context).pushNamed(DetailsPage.routeName,arguments: audioBook);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:  const Color(0xFFFFFFFF),
        ),

        padding: const EdgeInsets.all(2),
        margin:  EdgeInsets.only(right: 10.w),
        child: Stack(
          children: [
            Container(
              width:  0.45.sw ,
              height: 0.27.sh,
              decoration: BoxDecoration(
                color: kCardBgColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(

                  image: NetworkImage(
                    audioBook.thumbnailImageModel.audioBookImageDownloadUrl,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                height: 30.h,
                width:  0.2.sw,
                //margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0x22011C01).withOpacity(0.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    const Icon(
                      Icons.play_circle,
                      color: Colors.green,
                    ),
                    Text(
                      '10k+',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
