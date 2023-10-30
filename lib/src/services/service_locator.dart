

import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'page_manager.dart';

import 'audio_handler.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  // Pass the MusicProvider instance when registering DemoPlaylist
  //var musicProvider = MusicProvider();
  //await musicProvider.getAllSongs(); // Make sure to fetch the songs before registering
  //getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist(musicProvider));
  //getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // page state
  getIt.registerLazySingleton<PageManager>(() => PageManager());

}
/*Future<bool> setupServiceLocator() async {
  try {
    // services
    getIt.registerSingleton<AudioHandler>(await initAudioService());
    // Pass the MusicProvider instance when registering DemoPlaylist
    var musicProvider = MusicProvider();
    await musicProvider.getAllSongs(); // Make sure to fetch the songs before registering
    getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist(musicProvider));
    //getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

    // page state
    getIt.registerLazySingleton<PageManager>(() => PageManager());

    // Setup completed successfully
    return true;
  } catch (e) {
    if (kDebugMode) {
      print('Service Locator Error : ${e.toString()}');
    }
    return false;
  }
}*/
