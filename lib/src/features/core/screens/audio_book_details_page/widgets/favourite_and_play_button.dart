
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabbik_ui_clone/src/features/core/models/audio_book.dart';

import '../../../../../common_widgets/text_with_icon_button.dart';
import '../../audio_playing_screen/playing_screen.dart';


class DetailsPageFavouriteAndPlayButtonWidget extends StatefulWidget {
   const DetailsPageFavouriteAndPlayButtonWidget({
    super.key,
    required this.audioBook,

  });

  final AudioBookF audioBook;


  @override
  State<DetailsPageFavouriteAndPlayButtonWidget> createState() => _DetailsPageFavouriteAndPlayButtonWidgetState();
}

class _DetailsPageFavouriteAndPlayButtonWidgetState extends State<DetailsPageFavouriteAndPlayButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWithIconButtonWidget(
            labelText: 'Favourite',
            icon: Icons.favorite_outlined,
            colorList: const [Colors.deepPurple, Colors.tealAccent],
            isVertical: true,
            onPressed: () {}),
        SizedBox(
          width: 10.w,
        ),
        TextWithIconButtonWidget(
            labelText: 'Play Now',
            icon: Icons.play_circle_fill_outlined,
            colorList: const [Colors.red, Colors.purple],
            isVertical: false,
            onPressed: ()  {
/*
           Navigator.push(context, MaterialPageRoute(builder: (context)=>  PlayingScreen(audioBook: widget.audioBook,)));
*/
              //AutoRouter.of(context).push(PlayingScreenRoute(audioBook: widget.audioBook));
              Navigator.of(context).pushNamed(PlayingScreen.routeName, arguments: widget.audioBook);

            }),
      ],
    );
  }
}
