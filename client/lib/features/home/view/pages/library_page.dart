import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/home/view/pages/upload_song_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadSongPage()),
              );
            },
            icon: Icon(CupertinoIcons.music_note_list),
          ),
          IconButton(
            onPressed: () {
              ref.read(authLocalRepositoryProvider).setToken("");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
