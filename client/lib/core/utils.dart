import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String textToShow, bool success) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        ),
        backgroundColor: success ? Colors.green : Colors.red[400],
        content: Text(
          textToShow,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
}

Future<File?> pickAudio() async {
  try {
    final filePickerRes = await FilePicker.pickFiles(type: FileType.audio);
    if (filePickerRes != null) {
      final path = filePickerRes.files.first.path;
      if (path != null) {
        return File(path);
      }
    }
    return null;
  } catch (error) {
    print("Error picking audio: $error");
    return null;
  }
}

Future<File?> pickImage() async {
  try {
    final pickImageRes = await FilePicker.pickFiles(type: FileType.image);
    if (pickImageRes != null) {
      final path = pickImageRes.files.first.path;
      if (path != null) {
        return File(path);
      }
    }
    return null;
  } catch (error) {
    print("Error picking image: $error");
    return null;
  }
}

// Colour code converter RGB to Hex -> color going to database

String rgbToHex(Color color) {
  return "${color.red.toRadixString(16).padLeft(2, "0")}${color.green.toRadixString(16).padLeft(2, "0")}${color.blue.toRadixString(16).padLeft(2, "0")}";
}

Color hexToRgb(String hexCode) {
  return Color(int.parse(hexCode, radix: 16) + 0xFF000000);
}
