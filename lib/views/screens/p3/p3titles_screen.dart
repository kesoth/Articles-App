import 'dart:io';
import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class P3TitlesScreen extends StatefulWidget {
  const P3TitlesScreen({super.key});

  @override
  State<P3TitlesScreen> createState() => _P3TitlesScreenState();
}

class _P3TitlesScreenState extends State<P3TitlesScreen> {
  File? _selectedMedia;
  final List<TextEditingController> _textControllers = [];

  @override
  void initState() {
    super.initState();
    // Add initial TextEditingController
    _textControllers.add(TextEditingController());
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomappBar(text: 'File to do'),
              SizedBox(height: 45.h),
              Container(
                height: 660.h,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  itemCount: _textControllers.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8.0);
                  },
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kSecondaryTextColor,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextFormField(
                            controller: _textControllers[index],
                            decoration: const InputDecoration(
                              hintText: 'Enter text',
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: kPrimaryMainColor),
                              ),
                            ),
                            maxLines: null,
                            textInputAction: TextInputAction.next,
                            cursorColor: kPrimaryMainColor,
                            onFieldSubmitted: (value) {
                              if (index == _textControllers.length - 1) {
                                setState(() {
                                  _textControllers.add(TextEditingController());
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 340.w),
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

  @override
  void dispose() {
    // Dispose all TextEditingController instances
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
