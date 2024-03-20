import 'dart:io';
import 'dart:math';

import 'package:articles_app/cubit/articles/cubit.dart';
import 'package:articles_app/models/article.dart';
import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/utils/app_strings.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:articles_app/views/custom_widgets/custom_container.dart';
import 'package:articles_app/views/screens/p1/p1article_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom_widgets/writeArticle.dart';

class P1Screen extends StatefulWidget {
  const P1Screen({super.key});

  @override
  State<P1Screen> createState() => _P1ScreenState();
}

class _P1ScreenState extends State<P1Screen> {
  File? pdf;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? email;
  bool loaded = false;

  Color getRandomContainerColor() {
    final List<Color> containerColors = [
      kContainer1Color,
      kContainer2Color,
      kContainer3Color,
      kContainer4Color,
    ];
    final Random random = Random();
    final int randomIndex = random.nextInt(containerColors.length);
    return containerColors[randomIndex];
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('userEmail');
      loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getArticles();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomappBar(
              text: 'P1',
              showBackButton: false,
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<ArticleCubit, ArticleState>(
                  builder: (context, state) {
                    if (state is ArticleLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ArticleLoadSuccess) {
                      List<Article> articles = state.articles;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: articles.map((article) {
                            Color color = getRandomContainerColor();
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        P1ArticleScreen(article: article),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: CustomContainer(
                                  text: article.title,
                                  containercolor: color,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else if (state is ArticleLoadFailure) {
                      return Center(
                        child: AlertDialog(
                          title: const Text('Error'),
                          content:
                              Text('Failed to load articles: ${state.message}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: loaded
            ? email == "csa.fondateurs@gmail.com"
                ? Padding(
                    padding: EdgeInsets.only(left: 300.w),
                    child: FloatingActionButton(
                      onPressed: () => _showOptionsBottomSheet(context),
                      backgroundColor: kPrimaryMainColor,
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  )
                : null
            : const SizedBox(),
      ),
    );
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.create),
              title: const Text("Write Article"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WriteArticleScreen(
                            type: 'p1',
                          )),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_upload),
              title: const Text("Upload PDF File"),
              onTap: () {
                Navigator.pop(context);
                _pickFile(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null && filePath.toLowerCase().endsWith('.pdf')) {
        setState(() {
          pdf = File(filePath);
        });
        uploadConfirmation(pdf!);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Invalid File"),
              content: const Text("Please select a PDF file."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void uploadConfirmation(File pdf) {
    String fileName = pdf.path.split('/').last;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Upload Article"),
          content: Text("Are you sure you want to upload $fileName"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                uploadPdf(pdf);
              },
              child: const Text("YES"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("NO"),
            ),
          ],
        );
      },
    );
  }

  Future<String> uploadPdf(File pdf) async {
    try {
      String fileName = pdf.path.split('/').last;
      String articleTitle = fileName.replaceAll('.pdf', '');
      print("\nPDF\n\n$pdf");
      Reference ref = _storage.ref().child('articles/$fileName');
      UploadTask uploadTask = ref.putFile(pdf);
      await uploadTask.whenComplete(() => null);
      Article article = Article(
        description: "",
        file: 'articles/$fileName',
        isPDF: true,
        title: articleTitle,
        type: 'p1',
      );
      uploadArticleToFirestore(article);
      return 'articles/$fileName';
    } catch (e) {
      print('Error uploading PDF: $e');
      return "";
    }
  }

  Future<void> uploadArticleToFirestore(Article article) async {
    ArticleCubit cubit = BlocProvider.of<ArticleCubit>(context);
    try {
      print("\n\n\n UPLOAD ARTICLE START");
      await cubit.uploadArticle(article);
    } catch (e) {
      print("Error uploading article$e");
    }
  }

  Future<void> getArticles() async {
    ArticleCubit cubit = BlocProvider.of<ArticleCubit>(context);
    try {
      await cubit.getAllArticles('p1');
    } catch (e) {
      print("Error getting article$e");
    }
  }
}
