import 'dart:io';

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/widgets/audio_waves.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;
  final formKey = GlobalKey<FormState>();
  // Functions
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  @override
  void dispose() {
    songNameController.dispose();
    artistController.dispose();
    formKey.currentState?.validate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      homeViewModelProvider.select((val) => val?.isLoading == true),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        centerTitle: true,
        title: Text(
          "Upload Song",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Pallete.backgroundColor,
        actions: [
          IconButton(
            onPressed: () async {
              if (formKey.currentState!.validate() &&
                  selectedAudio != null &&
                  selectedImage != null) {
                await ref
                    .read(homeViewModelProvider.notifier)
                    .uploadSong(
                      selectedAudio: selectedAudio!,
                      selectedThumbNail: selectedImage!,
                      songName: songNameController.text,
                      artistNames: artistController.text,
                      hexCode: selectedColor,
                    );
              } else {
                showSnackBar(context, "Fields Cannot be Empty", false);
              }
            },
            icon: Icon(Icons.check_rounded),
          ),
        ],
      ),

      body: SafeArea(
        child: isLoading
            ? Loader()
            : Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: selectImage,
                          child: selectedImage != null
                              ? SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      selectedImage!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              : DottedBorder(
                                  options: const RoundedRectDottedBorderOptions(
                                    strokeCap: StrokeCap.round,
                                    radius: Radius.circular(12),
                                    dashPattern: [5, 4],
                                    strokeWidth: 1.5,
                                    color: Pallete.borderColor,
                                  ),
                                  child: const SizedBox(
                                    height: 159,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder_open_rounded,
                                          size: 40,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Select the Thumbnail for your Song",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),

                        const SizedBox(height: 20),
                        Column(
                          children: [
                            selectedAudio != null
                                ? AudioWaves(
                                    path: selectedAudio!.path,
                                    selectedColor: selectedColor,
                                  )
                                : CustomField(
                                    hintText: selectedAudio != null
                                        ? selectedAudio
                                              .toString()
                                              .split("/")
                                              .last
                                        : "Pick Song",
                                    controller: null,
                                    readOnly: true,
                                    onTap: () {
                                      selectAudio();
                                    },
                                  ),

                            const SizedBox(height: 20),
                            CustomField(
                              hintText: "Artist",
                              controller: artistController,
                            ),
                            const SizedBox(height: 20),
                            CustomField(
                              hintText: "Song Name",
                              controller: songNameController,
                            ),
                            const SizedBox(height: 20),
                            ColorPicker(
                              pickersEnabled: {ColorPickerType.wheel: true},
                              color: selectedColor,
                              onColorChanged: (Color color) {
                                setState(() {
                                  selectedColor = color;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
