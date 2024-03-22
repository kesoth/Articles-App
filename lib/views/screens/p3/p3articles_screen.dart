import 'dart:io';
import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:articles_app/views/custom_widgets/custom_button.dart';
import 'package:articles_app/views/custom_widgets/data_table.dart';
import 'package:articles_app/views/custom_widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:articles_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart' as local;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyTableData {
  final List<String> textFieldValues;
  final List<DateTime?> selectedDates;

  MyTableData({required this.textFieldValues, required this.selectedDates});

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'textFieldValues': textFieldValues,
      'selectedDates':
          selectedDates.map((date) => date?.toIso8601String()).toList(),
    };
  }

  // Deserialization
  factory MyTableData.fromJson(Map<String, dynamic> json) {
    return MyTableData(
      textFieldValues: List<String>.from(json['textFieldValues']),
      selectedDates: List<DateTime?>.from(json['selectedDates'].map(
          (dateString) =>
              dateString != null ? DateTime.tryParse(dateString) : null)),
    );
  }
}

class P3ArticlesScreen extends StatefulWidget {
  const P3ArticlesScreen({super.key});

  @override
  State<P3ArticlesScreen> createState() => _P3ArticlesScreenState();
}

class _P3ArticlesScreenState extends State<P3ArticlesScreen> {
  List<MyTableData> _tablesData = [];

  @override
  void initState() {
    super.initState();
    _loadTablesData();
  }

  Future<void> _loadTablesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("userId");
    List<String>? tablesDataJson = prefs.getStringList('$id-tablesData');
    if (tablesDataJson != null) {
      setState(() {
        _tablesData = tablesDataJson
            .map((jsonData) => MyTableData.fromJson(json.decode(jsonData)))
            .toList();
      });
    }
  }

  Future<void> _saveTablesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("userId");
    List<String> tablesDataJson =
        _tablesData.map((data) => json.encode(data.toJson())).toList();
    await prefs.setStringList('$id-tablesData', tablesDataJson);
  }

  void _addTable() {
    setState(() {
      _tablesData.add(MyTableData(
        textFieldValues: List.filled(20, ''),
        selectedDates: List.filled(10, null),
      ));
    });
    _saveTablesData();
  }

  void _updateTableData(
      int index, List<String> textFieldValues, List<DateTime?> selectedDates) {
    setState(() {
      _tablesData[index] = MyTableData(
        textFieldValues: textFieldValues,
        selectedDates: selectedDates,
      );
    });
    _saveTablesData();
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
              const SizedBox(height: 16),
              for (var index = 0; index < _tablesData.length; index++)
                MyTable(
                  textFieldValues: _tablesData[index].textFieldValues,
                  selectedDates: _tablesData[index].selectedDates,
                  onUpdate: (updatedTextFieldValues, updatedSelectedDates) {
                    _updateTableData(
                        index, updatedTextFieldValues, updatedSelectedDates);
                  },
                ),
              const SizedBox(
                height: 5,
              ),
              _tablesData.length > 0
                  ? InkWell(
                      onTap: () {
                        for (var index = 0;
                            index < _tablesData.length;
                            index++) {
                          MyTable(
                            textFieldValues: _tablesData[index].textFieldValues,
                            selectedDates: _tablesData[index].selectedDates,
                            onUpdate:
                                (updatedTextFieldValues, updatedSelectedDates) {
                              _updateTableData(index, updatedTextFieldValues,
                                  updatedSelectedDates);
                            },
                          );
                          SnackBarHelper.showSnackbar(
                              context, local.tr(LocaleKeys.success));
                        }
                      },
                      child: CustomButton(
                        text: local.tr(LocaleKeys.update),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 10),
                  child: FloatingActionButton(
                    onPressed: () => _addTable(),
                    backgroundColor: kPrimaryMainColor,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
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
