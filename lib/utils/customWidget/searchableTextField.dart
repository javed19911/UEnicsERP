import 'dart:async';
import 'package:flutter/material.dart';

import 'editText.dart';

class SearchableTextField<T> extends StatefulWidget {
  final String placeHolder;
  final ValueChanged<String>? listener;
  // final Future<List<T>> Function(String value)? getDataFromAPI;
  final int minStringLength;
  // List<T>? dataList;

  SearchableTextField({
    Key? key,
    required this.placeHolder,
    this.listener,
    this.minStringLength = 3,
    // this.getDataFromAPI,
    // this.dataList
  }) : super(key: key);

  @override
  _SearchableTextFieldState createState() => _SearchableTextFieldState();
}

class _SearchableTextFieldState extends State<SearchableTextField> {
  final myController = TextEditingController();
  Timer? _debounce;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   if (widget.dataList == null && widget.getDataFromAPI != null) {
  //     widget.getDataFromAPI!("").then((dataList) => widget.dataList = dataList);
  //   }
  // }

  @override
  void dispose() {
    myController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BoarderRoundTextView(
      placeHolder: widget.placeHolder,
      controller: myController,
      listener: (queryStr) {
        print('Searchable text: ${queryStr}');
        if (widget.listener != null) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 1000), () {
            widget.listener!(queryStr);
            // .then((dataList) => widget.dataList?.addAll(dataList));
          });
        }
      },
    );
  }
}
