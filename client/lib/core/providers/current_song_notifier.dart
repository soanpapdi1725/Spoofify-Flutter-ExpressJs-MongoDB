import 'package:client/features/home/model/song_model.dart';
import 'package:client/features/home/repository/home_local_repository.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import "package:just_audio/just_audio.dart";
part 'current_song_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentSongNotifier extends _$CurrentSongNotifier {
  late HomeLocalRepository _homeLocalRepository;
  AudioPlayer? audioPlayer;
  @override
  ({SongModel? song, bool isPlaying}) build() {
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return (song: null, isPlaying: false);
  }

  void updateSong(SongModel song) async {
    await audioPlayer?.stop();
    audioPlayer = AudioPlayer();
    final audioSource = AudioSource.uri(
      Uri.parse(song.song_url),
      tag: MediaItem(
        id: song.id,
        title: song.songName,
        artUri: Uri.parse(song.thumbnail_url),
        artist: song.artistNames,
      ),
    );

    audioPlayer!.playerStateStream.listen((songState) {
      if (songState.processingState == ProcessingState.completed) {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        state = (song: state.song, isPlaying: false);
      }
    });
    await audioPlayer!.setAudioSource(audioSource);
    _homeLocalRepository.uploadLocalSong(song);
    audioPlayer?.play();
    state = (song: song, isPlaying: true);
  }

  void pausePlay() {
    if (state.isPlaying) {
      audioPlayer?.pause();
    } else {
      audioPlayer?.play();
    }
    state = (song: state.song, isPlaying: !state.isPlaying);
  }

  void seekSong(double val) {
    audioPlayer?.seek(
      Duration(
        milliseconds: (val * audioPlayer!.duration!.inMilliseconds).toInt(),
      ),
    );
  }
}
