import 'dart:io';
import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class P3ArticlesScreen extends StatefulWidget {
  const P3ArticlesScreen({super.key});

  @override
  State<P3ArticlesScreen> createState() => _P3ArticlesScreenState();
}

class _P3ArticlesScreenState extends State<P3ArticlesScreen> {
  File? _selectedMedia;

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedMedia = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomappBar(text: 'File to do'),
              const SizedBox(height: 16),
              FloatingActionButton(
                onPressed: () => _pickFile(context),
                backgroundColor: kPrimaryMainColor,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
