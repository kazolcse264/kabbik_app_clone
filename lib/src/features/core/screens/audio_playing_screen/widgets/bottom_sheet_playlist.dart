import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../services/page_manager.dart';
import '../../../../../services/service_locator.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<List<String>>(
      valueListenable: pageManager.playlistNotifier,
      builder: (context, playlistTitles, _) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: playlistTitles.length,
          itemBuilder: (context, index) {
            final title = playlistTitles[index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    //pageManager.skipToQueueItem(index,);
                  },
                  child: ListTile(
                    title: Text(
                      title,
                      style: const TextStyle(color: Colors.white,fontSize: 16),
                    ),
                    trailing:  Icon(Icons.play_circle_filled_outlined,color: Colors.pink,size: 30.r,),
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            );
          },
        );
      },
    );
  }
}