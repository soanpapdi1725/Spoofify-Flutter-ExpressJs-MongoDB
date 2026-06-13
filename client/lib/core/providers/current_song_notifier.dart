import 'package:client/features/home/model/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import "package:just_audio/just_audio.dart";
part 'current_song_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer = AudioPlayer();
  @override
  ({SongModel? song, bool isPlaying}) build() {
    return (song: null, isPlaying: false);
  }

  void updateSong(SongModel song) async {
    final audioSource = AudioSource.uri(Uri.parse(song.song_url));

    audioPlayer!.playerStateStream.listen((songState) {
      if (songState.processingState == ProcessingState.completed) {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        state = (song: state.song, isPlaying: false);
      }
    });

    await audioPlayer!.setAudioSource(audioSource);
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
