import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_playing_screen/playing_screen.dart';
import '../../../../common_widgets/dismissible_bottom_container.dart';
import '../../controllers/audio_book_controller_firebase.dart';
import '../audio_book_details_page/imports.dart';
import 'home_page.dart';

//@RoutePage()
class PreservingBottomNavBar extends StatefulWidget {
  static const String routeName = '/preserving_bottom_nav_bar';
  const PreservingBottomNavBar({Key? key}) : super(key: key);

  @override
  State<PreservingBottomNavBar> createState() => _PreservingBottomNavBarState();
}

class _PreservingBottomNavBarState extends State<PreservingBottomNavBar> {
  int _selectedIndex = 0;
  final pageManager = getIt<PageManager>();
  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const Center(
      child: Icon(
        Icons.upcoming,
        size: 150,
      ),
    ),
    const Center(
      child: Icon(
        Icons.menu_book,
        size: 150,
      ),
    ),
    const Center(
      child: Icon(
        Icons.podcasts,
        size: 150,
      ),
    ),
    const Center(
      child: Icon(
        Icons.person,
        size: 150,
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {

    ///Background player notification click handler
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AudioService.notificationClicked.listen((event) {
        if (event && mounted) {
          final mediaItem = pageManager.currentSongPlayingNotifier.value;
          final audioBook =
              Provider.of<AudioBooksProviderFirebase>(context, listen: false)
                  .getAudioBookByArtUri(mediaItem!.artUri!);
         /* print('AudioService.notificationClicked');
          print('audioBook = $audioBook');*/
          Navigator.of(context).pushReplacementNamed(PlayingScreen.routeName,arguments: audioBook);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    ///Must be called for canceling notifications listening
    AudioService.notificationClicked.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DismissibleBottomContainer(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upcoming),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Academic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.podcasts),
            label: 'Podcasts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0B033F),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
      ),
    );
  }
}
