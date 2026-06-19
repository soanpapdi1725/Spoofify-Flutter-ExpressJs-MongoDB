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
    return Scaffold(
    
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              "1. Playlist Array for each user saved in Backend's DB and cached in Hive",
            ),
            Text(
              "2. My songs will be created where user's own songs will be saved",
            ),
            Text("3. Favourites of user"),
          ],
        ),
      ),
    );
  }
}
