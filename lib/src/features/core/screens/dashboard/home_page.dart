import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/audio_book_controller_firebase.dart';
import 'imports.dart';

//@RoutePage()
class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController1 = PageController();
  final _pageController2 = PageController();
  List<AudioBookF> audioBookListF = [];
  List<AudioBookF> audioBookCarouselList = [];
  //List<String> audioBookCarouselImageList = [];
  bool _isMounted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isMounted = true;
    if (ModalRoute.of(context)?.isCurrent == true) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (_isMounted) {
          _fetchAudioBook();
        }
      });
    }
  }

  void _fetchAudioBook() async {
    final audioBooksProvider =
        Provider.of<AudioBooksProviderFirebase>(context, listen: false);
    await audioBooksProvider.fetchAudioBooks();
    //await audioBooksProvider.getAllAudioBooksByIsCarousel();
/*    final result =
        await audioBooksProvider.getAllAudioBookImageUrlsByIsCarousel();*/
    await audioBooksProvider.getAllAudioBookCarousel();
    if (_isMounted) {
      setState(() {
        // Update the state only if the widget is still mounted.
        audioBookListF = audioBooksProvider.audioBooksF;
        //audioBookCarouselImageList = result;
        audioBookCarouselList = audioBooksProvider.audioBooksCarousel;
      });
    }
  }

  @override
  void dispose() {
    _pageController1.dispose();
    _pageController2.dispose();
    _isMounted = false; // Cancel the timer when the widget is disposed
    super.dispose();
  }

/*  void playAudioFrom5Minutes(Uint8List audioBytes) async {
    final AudioPlayer audioPlayer = AudioPlayer();
    const Duration fiveMinutes = Duration(minutes: 1);
    final StreamAudioSource audioSource = CustomStreamAudioSource(audioBytes, startPosition: fiveMinutes);

    await audioPlayer.setAudioSource(audioSource);
    final duration = await audioSource.duration;
    print(duration?.inMinutes);
    audioPlayer.play();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: (audioBookListF.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ),)
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      //First slider
                      MainCarouselSliderWidget(
                        pageController1: _pageController1,
                        audioBookCarouselList: audioBookCarouselList,
                      ),
                      SizedBox(height: 10.h),
                      SmoothPageIndicatorWidget(
                        pageController: _pageController1,
                          audioBookCarouselList: audioBookCarouselList,
                      ),

                      //Trending
                      TrendingAudioBook(
                        audioBookListF: audioBookListF,
                      ),
                      SizedBox(height: 10.h),

                      //Second Slider
                      SecondCarouselSliderWidget(
                          pageController2: _pageController2,
                        audioBookCarouselList: audioBookCarouselList,),

                      // New Section
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 8, right: 20).w,
                        child: const SectionHeader(title: 'New'),
                      ),
                      NewSectionWidget(audioBookList: audioBookListF),
                    ],
                  ),
                ),
                const TopSearchSectionWidget(),
              ],
            ),
    );
  }
}

/*

class CustomStreamAudioSource extends StreamAudioSource {
  final Uint8List audioBytes;
  final Duration startPosition;

  CustomStreamAudioSource(this.audioBytes, {this.startPosition = const Duration()});

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    final int startByte = startPosition.inMilliseconds * 2; // Assuming 16-bit audio
    start ??= startByte;
    end ??= audioBytes.length;

    if (start < 0) {
      start = 0;
    }
    if (end > audioBytes.length) {
      end = audioBytes.length;
    }

    final StreamController<List<int>> controller = StreamController<List<int>>();
    final Stream<List<int>> audioStream = Stream<List<int>>.fromIterable([audioBytes.sublist(start, end)]);

    controller.addStream(audioStream).then((_) {
      controller.close();
    });

    return StreamAudioResponse(
      sourceLength: audioBytes.length,
      contentLength: end - start,
      offset: start,
      stream: controller.stream,
      contentType: 'audio/mpeg', // Adjust the content type as needed
    );
  }
}*/

