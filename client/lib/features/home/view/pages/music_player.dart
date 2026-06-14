import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
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
      child: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                hexToRgb(currentSong.song!.hexCode),
                const Color(0xff121212),
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Scaffold(
            backgroundColor: Pallete.transparentColor,
            appBar: AppBar(
              backgroundColor: Pallete.transparentColor,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Transform.translate(
                  offset: Offset(-15, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset("assets/images/pull-down-arrow.png"),
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Hero(
                      tag: "music-image",
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          image: DecorationImage(
                            image: NetworkImage(
                              currentSong.song!.thumbnail_url,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Song Name & Song Artist Name will be in column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentSong.song!.songName,
                                style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                currentSong.song!.artistNames,
                                style: TextStyle(
                                  color: Pallete.inactiveBottomBarItemColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          // Favourite button
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.heart,
                              color: Pallete.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder(
                        stream: songPlaying.audioPlayer!.positionStream,
                        builder: (context, asyncSnapshot) {
                          if (asyncSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          }
                          final position = asyncSnapshot.data;
                          final duration = songPlaying.audioPlayer!.duration;
                          double sliderValue = 0.0;
                          if (position != null && duration != null) {
                            sliderValue =
                                position.inMilliseconds /
                                duration.inMilliseconds;
                          }
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Column(
                                children: [
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Pallete.whiteColor,
                                      inactiveTrackColor: Pallete.whiteColor
                                          .withValues(alpha: 0.117),
                                      thumbColor: Pallete.whiteColor,
                                      trackHeight: 4,
                                      overlayShape:
                                          SliderComponentShape.noOverlay,
                                    ),
                                    child: Slider(
                                      value: sliderValue,
                                      min: 0,
                                      max: 1,
                                      onChanged: (value) {
                                        sliderValue = value;
                                        setState(() {});
                                      },
                                      onChangeEnd: songPlaying.seekSong,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${position?.inMinutes}:${(position?.inSeconds ?? 0) < 10 ? "0${position?.inSeconds}" : "${(position?.inSeconds ?? 0) % 60 < 10 ? "0${(position?.inSeconds ?? 0) % 60}" : (position?.inSeconds ?? 0) % 60}"}",
                                        style: TextStyle(
                                          color: Pallete.subtitleText,
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text(
                                        "${duration?.inMinutes}:${(duration?.inSeconds ?? 0) < 10 ? "0${duration?.inSeconds}" : "${(duration?.inSeconds ?? 0) % 60 < 10 ? "0${(duration?.inSeconds ?? 0) % 60}" : (duration?.inSeconds ?? 0) % 60}"}",
                                        style: TextStyle(
                                          color: Pallete.subtitleText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.all(10),
                            onPressed: () {},
                            icon: Image.asset("assets/images/shuffle.png"),
                          ),
                          IconButton(
                            padding: EdgeInsets.all(10),

                            onPressed: () {},
                            icon: Image.asset(
                              "assets/images/previous-song.png",
                            ),
                          ),
                          Hero(
                            tag: "music-play",
                            child: IconButton(
                              onPressed: songPlaying.pausePlay,
                              icon: Icon(
                                currentSong.isPlaying
                                    ? CupertinoIcons.pause_circle_fill
                                    : CupertinoIcons.play_circle_fill,
                                color: Pallete.whiteColor,
                                size: 80,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/images/next-song.png"),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/images/repeat.png"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/images/connect-device.png",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: IconButton(
                              onPressed: () {},
                              icon: Image.asset("assets/images/playlist.png"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
