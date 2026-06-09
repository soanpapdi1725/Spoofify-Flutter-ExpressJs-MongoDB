import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioWaves extends StatefulWidget {
  final String path;
  final Color selectedColor;
  const AudioWaves({
    super.key,
    required this.path,
    required this.selectedColor,
  });

  @override
  State<AudioWaves> createState() => _AudioWavesState();
}

class _AudioWavesState extends State<AudioWaves> {
  final PlayerController playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() async {
    await playerController.preparePlayer(path: widget.path);
  }

  Future<void> pauseAndPlay() async {
    if (!(playerController.playerState.isPlaying)) {
      await playerController.startPlayer();
    } else if (!playerController.playerState.isPaused) {
      await playerController.pausePlayer();
    }
    setState(() {});
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: pauseAndPlay,
          icon: Icon(
            !playerController.playerState.isPlaying
                ? CupertinoIcons.play_arrow_solid
                : CupertinoIcons.pause_solid,
          ),
        ),
        Expanded(
          child: AudioFileWaveforms(
            playerWaveStyle: PlayerWaveStyle(
              fixedWaveColor: Pallete.borderColor,
              liveWaveColor: widget.selectedColor != Pallete.cardColor
                  ? widget.selectedColor
                  : Pallete.gradient2,
              spacing: 6,
            ),
            size: const Size(double.infinity, 100),
            playerController: playerController,
          ),
        ),
      ],
    );
  }
}
