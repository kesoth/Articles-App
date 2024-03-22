import 'dart:io';
import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:articles_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart' as local;

class P3GalleryScreen extends StatefulWidget {
  const P3GalleryScreen({super.key});

  @override
  State<P3GalleryScreen> createState() => _P3GalleryScreenState();
}

class _P3GalleryScreenState extends State<P3GalleryScreen> {
  List<String> _selectedMediaList = [];
  String? userId;

  @override
  void initState() {
    super.initState();
    getFiles();
  }

  Future<void> getFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = await prefs.getString('userId');
    setState(() {
      _selectedMediaList = prefs.getStringList(userID!) ?? [];
    });
  }

  Future<void> _pickFile(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        _selectedMediaList.add(result.path);
      });
      await saveImagesToLocalStorage();
    }
  }

  Future<void> saveImagesToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = await prefs.getString('userId');
    setState(() {
      userId = userID!;
    });
    await prefs.setStringList(userID!, []);
    await prefs.setStringList(userID, _selectedMediaList);
  }

  void _removeMedia(int index) async {
    setState(() {
      _selectedMediaList.removeAt(index);
    });
    await saveImagesToLocalStorage();
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
              CustomappBar(text: local.tr(LocaleKeys.fileToDo)),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.74,
                width: MediaQuery.of(context).size.width * 0.95,
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemCount: _selectedMediaList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.5,
                          child: Image.file(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.5,
                            File(_selectedMediaList[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () => _removeMedia(index),
                            child: const Icon(
                              Icons.delete,
                              color: kContainer1Color,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 320.w),
                child: FloatingActionButton(
                  onPressed: () => _pickFile(context),
                  backgroundColor: kPrimaryMainColor,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
