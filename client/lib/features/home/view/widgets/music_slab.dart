import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/view/pages/music_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final songPlaying = ref.watch(currentSongProvider.notifier);
    if (currentSong.song == null) {
      return const SizedBox();
    } else {
      return GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy < 0) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const MusicPlayer(),
                reverseTransitionDuration: const Duration(milliseconds: 350),
                transitionDuration: const Duration(milliseconds: 500),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      final tween = Tween(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOutQuad));

                      final offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
              ),
            );
          }
        },
        onTap: () {},
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: EdgeInsets.symmetric(horizontal: 2),
              height: 75,
              width: MediaQuery.of(context).size.width - 4,
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: hexToRgb(currentSong.song!.hexCode),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            image: NetworkImage(
                              currentSong.song!.thumbnail_url,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSong.song!.songName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            currentSong.song!.artistNames,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Pallete.subtitleText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.heart,
                          color: Pallete.whiteColor,
                        ),
                      ),
                      Hero(
                        tag: "music-play",

                        child: IconButton(
                          onPressed: songPlaying.pausePlay,
                          icon: Icon(
                            currentSong.isPlaying
                                ? CupertinoIcons.pause_solid
                                : CupertinoIcons.play_arrow_solid,
                            color: Pallete.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 8,
              left: 8,
              child: Container(
                height: 4,
                width: MediaQuery.of(context).size.width - 36,
                decoration: BoxDecoration(
                  color: Pallete.inactiveSeekColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            StreamBuilder(
              stream: songPlaying.audioPlayer!.positionStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                final position = snapshot.data;
                final duration = songPlaying.audioPlayer!.duration;
                double sliderValue = 0.0;
                if (position != null && duration != null) {
                  sliderValue =
                      position.inMilliseconds / duration.inMilliseconds;
                  // slider value will be in range of 0 to 1
                  // where 1 is max and min is 0
                }
                return Positioned(
                  bottom: 0,
                  left: 8,
                  child: Stack(
                    children: [
                      Hero(
                        tag: "music-image",
                        child: Container(
                          height: 4,
                          width:
                              sliderValue *
                              (MediaQuery.of(context).size.width -
                                  36), // here mediaQuery will be the main width and will slide because as it will be 0.1 or 0.2 it will be of it's percentage
                          decoration: BoxDecoration(
                            color: Pallete.whiteColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }
}
