import 'dart:io';

import 'package:articles_app/generated/locale_keys.g.dart';
import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:articles_app/views/custom_widgets/custom_button.dart';
import 'package:articles_app/views/custom_widgets/customtextfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubit/articles/cubit.dart';
import '../../models/article.dart';
import 'package:articles_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart' as local;

class WriteArticleScreen extends StatefulWidget {
  final String type;
  const WriteArticleScreen({super.key, required this.type});

  @override
  State<WriteArticleScreen> createState() => _WriteArticleScreenState();
}

class _WriteArticleScreenState extends State<WriteArticleScreen> {
  String? image = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool loading = false;

  Future<void> _imagePicker(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        image = result.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomappBar(text: local.tr(LocaleKeys.writeArticle)),
            SizedBox(
              height: 20.w,
            ),
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => _imagePicker(context),
                          child: image != null && image != ""
                              ? Container(
                                  width: 380.w,
                                  height: 280.h,
                                  child: Image.file(
                                    width: 347.w,
                                    height: 280.h,
                                    File(image!),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: 380.w,
                                  height: 280.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black45),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.add),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        Text(
                          local.tr(LocaleKeys.title),
                          style: const TextStyle(
                            color: kTextFieldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        CustomTextField(
                            label: local.tr(LocaleKeys.title),
                            controller: titleController),
                        SizedBox(
                          height: 20.w,
                        ),
                        Text(
                          local.tr(LocaleKeys.writeArticle),
                          style: const TextStyle(
                            color: kTextFieldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        Container(
                          width: 380.w,
                          height: 300.h,
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: TextField(
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            cursorColor: const Color(0xFF979595),
                            style: const TextStyle(
                              color: Color(0xFF979595),
                            ),
                            expands: true,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: kTextFieldColor,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: kTextFieldColor,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              hintText: local.tr(LocaleKeys.description),
                              hintStyle: TextStyle(
                                color: kHintTextColor,
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        InkWell(
                          onTap: () async {
                            if (titleController.text.isNotEmpty &&
                                descriptionController.text.isNotEmpty) {
                              await _publish();
                            }
                          },
                          child:
                              CustomButton(text: local.tr(LocaleKeys.publish)),
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    ));
  }

  Future<void> _publish() async {
    try {
      setState(() {
        loading = true;
      });
      String fileName = image!.split('/').last;
      Reference ref =
          FirebaseStorage.instance.ref().child('articleImages/$fileName');
      UploadTask uploadTask = ref.putFile(File(image!));
      TaskSnapshot taskSnapshot = await uploadTask;

      Article article = Article(
        description: descriptionController.text,
        file: 'articleImages/$fileName',
        title: titleController.text,
        isPDF: false,
        type: widget.type,
      );
      await uploadArticleToFirestore(article);
      setState(() {
        loading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(local.tr(LocaleKeys.success)),
            content: Text(local.tr(LocaleKeys.articlePublishSuccess)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(local.tr(LocaleKeys.ok)),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print("Error uploading image: $error");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(local.tr(LocaleKeys.ok)),
            content: Text(local.tr(LocaleKeys.imageUploadFail)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(local.tr(LocaleKeys.ok)),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> uploadArticleToFirestore(Article article) async {
    ArticleCubit cubit = BlocProvider.of<ArticleCubit>(context);
    try {
      await cubit.uploadArticle(article);
    } catch (e) {
      print("Error uploading article$e");
    }
  }
}
