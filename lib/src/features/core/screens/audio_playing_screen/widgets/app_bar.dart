
import 'package:flutter/material.dart';

import '../playing_screen.dart';

class PlayingScreenAppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  const PlayingScreenAppBarWidget({
    super.key,
    required this.widget,
  });

  final PlayingScreen widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        widget.audioBook.title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}