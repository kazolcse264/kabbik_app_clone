
import 'package:flutter/material.dart';

import '../details_page.dart';

class DetailsPageAppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  const DetailsPageAppBarWidget({
    super.key,
    required this.widget,
  });

  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
       // context.router.pop();


      }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(widget.audioBook.title,style: const TextStyle(color: Colors.white,),),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
