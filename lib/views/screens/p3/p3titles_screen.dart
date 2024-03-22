import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:articles_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart' as local;

class P3TitlesScreen extends StatefulWidget {
  const P3TitlesScreen({super.key});

  @override
  State<P3TitlesScreen> createState() => _P3TitlesScreenState();
}

class _P3TitlesScreenState extends State<P3TitlesScreen> {
  final List<TextEditingController> _textControllers = [];

  @override
  void initState() {
    super.initState();
    _loadTextControllers();
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
              CustomappBar(text: local.tr(LocaleKeys.fileToDo)),
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
                            decoration: InputDecoration(
                              hintText: local.tr(LocaleKeys.enterText),
                              focusedBorder: const UnderlineInputBorder(
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
                                  _saveTextControllers();
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
                  onPressed: () {
                    setState(() {
                      _textControllers.add(TextEditingController());
                      _saveTextControllers();
                    });
                  },
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

  Future<void> _loadTextControllers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString('userName');
      List<String>? textValues = prefs.getStringList('$id-textValues');
      if (textValues != null) {
        List<TextEditingController> controllers = [];
        for (var value in textValues) {
          controllers.add(TextEditingController(text: value));
        }
        setState(() {
          _textControllers.addAll(controllers);
        });
      }
    } catch (e) {
      print('Error loading text controllers: $e');
    }
  }

  Future<void> _saveTextControllers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString('userName');
      if (id != null) {
        List<String> textValues =
            _textControllers.map((controller) => controller.text).toList();
        await prefs.setStringList('$id-textValues', []);
        await prefs.setStringList('$id-textValues', textValues);
      }
    } catch (e) {
      print('Error saving text controllers: $e');
    }
  }

  @override
  void dispose() {
    _saveTextControllers();
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
