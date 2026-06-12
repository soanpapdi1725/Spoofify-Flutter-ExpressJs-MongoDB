import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/repository/home_repository.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SongsPage extends ConsumerWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8.0),
            child: Text(
              "Welcome Back, ${ref.read(currentUserProvider)!.firstName}",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(8.0),
            child: Text(
              "Latest Today",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
          ),
          ref
              .watch(getAllSongsProvider)
              .when(
                data: (songs) {
                  return SizedBox(
                    height: 260,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final singleSong = songs[index];
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(currentSongProvider.notifier)
                                .updateSong(singleSong);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        singleSong.thumbnail_url,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    singleSong.songName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),

                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    singleSong.artistNames,
                                    style: const TextStyle(
                                      color: Pallete.subtitleText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, st) {
                  return Center(child: Text(error.toString()));
                },
                loading: () => const Loader(),
              ),
        ],
      ),
    );
  }
}
