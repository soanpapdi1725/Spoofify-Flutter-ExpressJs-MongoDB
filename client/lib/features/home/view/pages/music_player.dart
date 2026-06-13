import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final songPlaying = ref.read(currentSongProvider.notifier);
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) > 100) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(12),
                height: MediaQuery.of(context).size.height,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(currentSong.song!.thumbnail_url),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Positioned(
                bottom: 240,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        currentSong.song!.songName,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currentSong.song!.artistNames,
                        style: TextStyle(
                          color: Pallete.inactiveSeekColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 40,
                left: 15,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.keyboard_arrow_down_outlined, size: 35),
                ),
              ),
              Positioned(
                bottom: 200,
                left: 20,
                child: Container(
                  height: 8,
                  width: (MediaQuery.of(context).size.width - 40),

                  decoration: BoxDecoration(
                    color: Pallete.inactiveSeekColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              StreamBuilder(
                stream: songPlaying.audioPlayer?.positionStream,
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  double sliderValue = 0.0;
                  final position = asyncSnapshot.data;
                  final duration = songPlaying.audioPlayer?.duration;
                  if (position != null && duration != null) {
                    sliderValue =
                        position.inMilliseconds / duration.inMilliseconds;
                  }
                  return Positioned(
                    bottom: 200,
                    left: 20,
                    child: Container(
                      height: 8,
                      width:
                          sliderValue *
                          (MediaQuery.of(context).size.width - 40),

                      decoration: BoxDecoration(
                        color: Pallete.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 120,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final currentPosition =
                              songPlaying.audioPlayer!.position;
                          final newPosition =
                              currentPosition - const Duration(seconds: 10);
                          await songPlaying.audioPlayer?.seek(
                            newPosition.isNegative
                                ? Duration.zero
                                : newPosition,
                          );
                        },
                        icon: Icon(
                          Icons.fast_rewind,
                          size: 40,
                          color: Pallete.whiteColor,
                        ),
                      ),
                      IconButton(
                        onPressed: songPlaying.pausePlay,
                        icon: Icon(
                          currentSong.isPlaying
                              ? Icons.pause_circle_outline
                              : Icons.play_circle_fill,
                          size: 50,
                          color: Pallete.whiteColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final currentPosition =
                              songPlaying.audioPlayer!.position;
                          final songDuration =
                              songPlaying.audioPlayer!.duration;
                          final newPosition =
                              currentPosition + const Duration(seconds: 10);

                          await songPlaying.audioPlayer?.seek(
                            newPosition > songDuration!
                                ? songDuration
                                : newPosition,
                          );
                        },
                        icon: Icon(
                          Icons.fast_forward,
                          size: 40,
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
