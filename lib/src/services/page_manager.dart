import 'dart:async';
import 'package:flutter/foundation.dart';
import '../notifiers/play_button_notifier.dart';
import '../notifiers/progress_notifier.dart';
import '../notifiers/repeat_button_notifier.dart';
import 'package:audio_service/audio_service.dart';
import 'service_locator.dart';

class PageManager {
  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final currentSongPlayingNotifier = ValueNotifier<MediaItem?>(null);
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final rewindSongNotifier = ValueNotifier<bool>(true);
  final fastForwardSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  final _audioHandler = getIt<AudioHandler>();

  // Events: Calls coming from the UI
  void init() async {
    //await _loadPlaylist();
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
    _listenToPlayingSong();
  }

/*  Future<void> _loadPlaylist() async {
    final songRepository = getIt<PlaylistRepository>();
    final playlist = await songRepository.fetchInitialPlaylist();
    final mediaItems = playlist
        .map(
          (song) => MediaItem(
            id: song.id?.toString() ?? '',
            album: song.album,
            title: song.title,
            extras: {'url': song.url,'isFile': true,},
            artUri: Uri.file(File(song.artUri).path),
          ),
        )
        .toList();
    _audioHandler.addQueueItems(mediaItems);
  }*/
 /* Future<void> _loadPlaylist() async {
    final songRepository = getIt<PlaylistRepository>();
    final playlist = await songRepository.fetchInitialPlaylist();
    final mediaItems = playlist
        .map(
          (song) => MediaItem(
        id: song['id'] ?? '',
        album: song['album'] ?? '',
        title: song['title'] ?? '',
        extras: {'url': song['url'],'isFile': false,},
        artUri: Uri.parse(song['artUri'] ?? ''),
      ),
    )
        .toList();
    _audioHandler.addQueueItems(mediaItems);
  }*/
  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongTitleNotifier.value = '';
      } else {
        final newList = playlist.map((item) => item.title).toSet().toList();
        playlistNotifier.value = newList;
      }
      _updateSkipButtons();
      _updateRewindAndFastForwardButton();
    });
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongTitleNotifier.value = mediaItem?.title ?? '';
      _updateSkipButtons();
      _updateRewindAndFastForwardButton();
    });
  }
  void _listenToPlayingSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongPlayingNotifier.value = mediaItem;

    });
  }

  void _updateRewindAndFastForwardButton() {
    final currentPosition = _audioHandler.playbackState.value.position;
    final duration = _audioHandler.mediaItem.value?.duration;

    if (duration != null) {
      fastForwardSongNotifier.value =
          currentPosition < duration - const Duration(seconds: 5);
      rewindSongNotifier.value = currentPosition > const Duration(seconds: 5);
    } else {
      fastForwardSongNotifier.value = false;
      rewindSongNotifier.value = false;
    }
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void skipToQueueItem(int index) {
    _audioHandler.skipToQueueItem(index);
  }

  void play() => _audioHandler.play();

  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);

  void setSpeed(double speed) => _audioHandler.setSpeed(speed);

  void previous() => _audioHandler.skipToPrevious();

  void next() => _audioHandler.skipToNext();

  void rewind() => _audioHandler.rewind();

  void fastForward() => _audioHandler.fastForward();

  void repeat() {
    repeatButtonNotifier.nextState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

/*  Future<void> add() async {
    final songRepository = getIt<PlaylistRepository>();
    final song = await songRepository.fetchAnotherSong();
    final mediaItem = MediaItem(
      id: song['id'] ?? '',
      album: song['album'] ?? '',
      title: song['title'] ?? '',
      extras: {
        'url': song['url'],
      },
      artUri: Uri.parse(song['artUri']!),
    );
    _audioHandler.addQueueItem(mediaItem);
  }*/
/*  void removeQueueItemsExceptLast() async {
    // Get the current queue
    List<MediaItem>? queue = _audioHandler.queue.value;
    if (queue.isEmpty) {
      return; // No items in the queue or the queue is null
    }
    // Find the last added item in the queue
    MediaItem lastAddedItem = queue.last;
     _audioHandler.queue.value.clear();
    _audioHandler.addQueueItem(lastAddedItem);

  }*/
  int getIndexInQueue(String itemId) {
    List<MediaItem> queue = _audioHandler.queue.value;
    int index = queue.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      // Item found, and itemIndex contains the index of the item in the queue.
      debugPrint('Item found at index: $index');
    } else {
      // Item not found in the queue.
      debugPrint('Item not found in the queue.');
    }
    return index;
  }
  Future<void> removeQueueItemsExceptLast(String id) async {
    List<MediaItem>? queue = _audioHandler.queue.value;
    final queueLength = _audioHandler.queue.value.length;
    //print('queueLength = $queueLength');

    if (queue.isEmpty) {
      return ;
    }
    List<MediaItem> itemsToKeep = [];
    for (var i = 0; i < queueLength; i++) {
      if (queue[i].id == id) {
        itemsToKeep.add(queue[i]);
      }
    }
    for (var i = 0; i < queueLength; i++) {
      _audioHandler.removeQueueItemAt(0);
    }
   // print('itemsToKeep = ${itemsToKeep.last}');
    //print('After removing = ${_audioHandler.queue.value}');
     _audioHandler.addQueueItem(itemsToKeep.last);
    // _audioHandler.updateMediaItem(itemsToKeep.last) ;
    //print('page manager mediaItem = ${_audioHandler.mediaItem.value}');

  }

  void remove() {
    final lastIndex = _audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    _audioHandler.removeQueueItemAt(lastIndex);
  }
  void dispose() {
    _audioHandler.customAction('dispose');
    _audioHandler.onTaskRemoved();
  }

  void stop() {
    _audioHandler.stop();
    _audioHandler.onTaskRemoved();
  }
}
