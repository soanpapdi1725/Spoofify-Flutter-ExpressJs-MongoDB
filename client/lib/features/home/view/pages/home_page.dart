import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/home/view/pages/library_page.dart';
import 'package:client/features/home/view/pages/songs_page.dart';
import 'package:client/features/home/view/pages/upload_song_page.dart';
import 'package:client/features/home/view/widgets/music_slab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final pages = [
      SongsPage(
        onClickProfile: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      LibraryPage(),
    ];
    final currentUser = ref.watch(currentUserProvider);
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Text(currentUser!.firstName + " " + currentUser.lastName),
                  Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadSongPage(),
                        ),
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
                      ref.read(currentSongProvider.notifier).stopSong();
                    },
                    icon: Icon(Icons.logout),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Pallete.transparentColor,
          highlightColor: Pallete.transparentColor,
          splashFactory: NoSplash.splashFactory,
        ),

        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                selectedIndex == 0
                    ? "assets/images/home_filled.png"
                    : "assets/images/home_unfilled.png",
                color: selectedIndex == 0
                    ? Pallete.whiteColor
                    : Pallete.inactiveBottomBarItemColor,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/library.png",
                color: selectedIndex == 1
                    ? Pallete.whiteColor
                    : Pallete.inactiveBottomBarItemColor,
              ),
              label: "Library",
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          pages[selectedIndex],
          Positioned(bottom: 0, child: MusicSlab()),
        ],
      ),
    );
  }
}
