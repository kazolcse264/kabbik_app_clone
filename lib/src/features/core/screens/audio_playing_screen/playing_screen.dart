
import 'package:flutter/material.dart';
import 'imports.dart';

//@RoutePage()
class PlayingScreen extends StatefulWidget {
  static const String routeName = '/playing_screen';
  final AudioBookF audioBook;

  const PlayingScreen({
    super.key,
    required this.audioBook,
  });

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {

  late AudioBookProvider audioBookProvider;
  int? currentPlaybackPosition;
  StreamSubscription<PlaybackState>? playbackStateSubscription;
  final audioHandler = getIt<AudioHandler>();
  final pageManager = getIt<PageManager>();
  MediaItem? mediaItem;
  Timer? _songFinishedTimer;

  @override
  void initState() {
    super.initState();
    initPlayingScreen();
    pageManager.play();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      appBar: PlayingScreenAppBarWidget(widget: widget),
      body: Stack(
        children: [
          Column(
            children: [
              ClickedItemImageWidget(artUri: widget.audioBook.thumbnailImageModel.audioBookImageDownloadUrl,),
               SizedBox(
                height: 10.h,
              ),
              ///Current Song Title
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: CurrentSongTitle(textColor: Colors.white,textSize: 20,),
              ),
              //ItemClickedTitleAlbumWidget(title : mediaItem?.title ?? '', album: widget.audioBook.album,),
              //Progress Bar
               Padding(
                padding: EdgeInsets.only(
                  top: 40.0.h,
                  left: 40.w,
                  right: 40.w,
                  bottom: 18.0.h,
                ),
                child: AudioProgressBar(
                  id: mediaItem!.id,
                  currentPlaybackPosition: currentPlaybackPosition ?? 0,
                  updateCurrentPlaybackPosition: updateCurrentPlaybackPosition,
                ),
              ),
              // Control Buttons
              AudioControlButtonWidget(
                id: mediaItem!.id,
                currentPlaybackPosition: currentPlaybackPosition ?? 0,
                updateCurrentPlaybackPosition: updateCurrentPlaybackPosition,
                audioHandler: audioHandler,
              ),
              SizedBox(
                height: 12.h,
              ),
              //Timer section
               TimerSectionWidget(pageManager : pageManager,),
            ],
          ),
          //Playlist section
          const PlayListSectionWidget(),
        ],
      ),
    );
  }

  Future<void> initPlayingScreen() async {
    getIt<PageManager>().init();
    //var index = pageManager.getIndexInQueue(widget.audioBook.id);
    //pageManager.skipToQueueItem(index);
    mediaItem = audioHandler.queue.value.first;
    audioBookProvider = Provider.of<AudioBookProvider>(context, listen: false);
    await audioBookProvider.initialize();
    currentPlaybackPosition = audioBookProvider.getPosition(mediaItem!.id);
    if (currentPlaybackPosition != null && currentPlaybackPosition! > 0) {
      pageManager.seek(Duration(seconds: currentPlaybackPosition!));
    } else {
      currentPlaybackPosition =
      0; // Reset the position to 0 if no stored position is available
    }

    setupPlaybackPositionListener();
    _startSongFinishedTimer();
  }

  void setupPlaybackPositionListener() {
    playbackStateSubscription = audioHandler.playbackState.listen((state) {
      if (state.processingState == AudioProcessingState.ready) {
        final currentPosition = state.position.inSeconds;
        audioBookProvider.setPosition(mediaItem!.id, currentPosition);
      }
    });
  }

  void _startSongFinishedTimer() {
    _songFinishedTimer?.cancel();
    _songFinishedTimer = Timer.periodic(
        Duration(seconds: currentPlaybackPosition ?? 1), (timer) {
      final value = getIt<PageManager>().progressNotifier.value;
      final musicProvider = Provider.of<AudioBookProvider>(context, listen: false);
      if (value.current.inSeconds >= value.total.inSeconds) {
        // Song has finished, set position to 0
        musicProvider.setPosition(mediaItem!.id, 0);
        setState(() {
          currentPlaybackPosition = 0;
        });
      }
    });
  }


  void updateCurrentPlaybackPosition(int position) {
    setState(() {
      currentPlaybackPosition = position;
    });
  }



  @override
  void dispose() {
    playbackStateSubscription?.cancel(); // Cancel the subscription
    _songFinishedTimer?.cancel();

    super.dispose();
  }

}












