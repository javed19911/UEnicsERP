import 'package:flutter/material.dart';

import 'editText.dart';

class SearchableTextField extends StatefulWidget {
  final String placeHolder;
  final VoidCallback? listener;
  final int minStringLength;

  const SearchableTextField(
      {Key? key,
      required this.placeHolder,
      this.listener,
      this.minStringLength = 3})
      : super(key: key);

  @override
  _SearchableTextFieldState createState() => _SearchableTextFieldState();
}

class DropdownModel {
  String label;
  dynamic value;

  DropdownModel({required this.label, this.value});

  factory DropdownModel.fromJson(Map<String, dynamic> json) {
    return DropdownModel(label: json['label'], value: json['value']);
  }
}

class _SearchableTextFieldState extends State<SearchableTextField> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<List> fetchComplexData() async {
    await Future.delayed(Duration(milliseconds: 10));
    List _list = [];
    List _jsonList = [
      {'label': 'Text' + ' Item 1', 'value': 30},
      {'label': 'Text' + ' Item 2', 'value': 31},
      {'label': 'Text' + ' Item 3', 'value': 32},
    ];
    // create a list from the text input of three items
    // to mock a list of items from an http call where
    // the label is what is seen in the textfield and something like an
    // ID is the selected value
    _list.add(new DropdownModel.fromJson(_jsonList[0]));
    _list.add(new DropdownModel.fromJson(_jsonList[1]));
    _list.add(new DropdownModel.fromJson(_jsonList[2]));

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return BoarderRoundTextView(
      placeHolder: widget.placeHolder,
      controller: myController,
      listener: (queryStr) {
        print('Searchable text: ${queryStr}');
      },
    );
  }
}
