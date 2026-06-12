import 'package:client/core/providers/current_song_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    if (currentSong == null) {
      return const SizedBox();
    } else {
      return Container(
        height: 100,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(currentSong.thumbnail_url),
                    ),
                  ),
                ),
              ],
            ),
            Row(children: []),
          ],
        ),
      );
    }
  }
}
