import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'editText.dart';

class SearchableTextField<T> extends StatefulWidget {
  final String placeHolder;
  final ValueChanged<String>? listener;
  final TextEditingController? controller;
  final double order;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final bool? enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign alignment;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final Future<List<T>> Function(String value)? getDataFromAPI;
  List<T>? items;

  SearchableTextField(
      {Key? key,
      required this.placeHolder,
      this.listener,
      this.controller,
      this.enabled,
      this.fillColor,
      this.suffixIcon,
      this.prefixIcon,
      this.order = 1,
      this.inputFormatters,
      this.keyboardType,
      this.alignment = TextAlign.start,
      this.focusedBorder,
      this.border,
      this.getDataFromAPI,
      this.items})
      : super(key: key);

  @override
  _SearchableTextFieldState createState() => _SearchableTextFieldState();
}

class _SearchableTextFieldState extends State<SearchableTextField> {
  OverlayEntry? _overlayEntry;
  FocusNode? _textFocusNode;
  bool _isOpen = false;
  bool _skipNextFocusOut = false;
  late FocusScopeNode _dropDownFocusNode;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    // if (widget.items == null && widget.getDataFromAPI != null) {
    //   widget.getDataFromAPI!("").then((dataList) => widget.items = dataList);
    // }
    _dropDownFocusNode = FocusScopeNode();
    _dropDownFocusNode.addListener(handleDropdownFocusChanged);
    super.initState();
  }

  void handleDropdownFocusChanged() {
    if (!_dropDownFocusNode.hasFocus) {
      this._overlayEntry?.remove();
    }
  }

  @override
  void dispose() {
    _dropDownFocusNode.dispose();
    super.dispose();
  }

  void _handleValueChanged(String value) {
    // _updateFilteredItems();
    // widget.onChanged?.call(value);
    showOverlay();
  }

  void _handleFocusChanged(bool value) {
    if (_skipNextFocusOut && !value) {
      _skipNextFocusOut = false;
      return;
    }
    showOverlay(value);
    // widget.onFocusChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: DebounceRoundBoarderTextFieldState(
        placeHolder: widget.placeHolder,
        controller: widget.controller,
        order: widget.order,
        fillColor: widget.fillColor,
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        alignment: widget.alignment,
        // border: const OutlineInputBorder(),
        // focusedBorder: const OutlineInputBorder(),
        enabled: widget.enabled,
        onKey: (FocusNode node, RawKeyEvent evt) {
          if (evt is RawKeyDownEvent) {
            if ((_textFocusNode?.hasFocus ?? false) &&
                evt.logicalKey == LogicalKeyboardKey.space) {
              _skipNextFocusOut = true;
              Future.microtask(() => _dropDownFocusNode.requestFocus());
              return KeyEventResult.ignored;
            }
            if (_dropDownFocusNode.hasFocus &&
                (evt.logicalKey == LogicalKeyboardKey.arrowRight ||
                    evt.logicalKey == LogicalKeyboardKey.arrowLeft)) {
              _textFocusNode?.requestFocus();
              return KeyEventResult.ignored;
            }
          }
          return KeyEventResult.ignored;
        },
        onFocusCreated: (node) {
          _textFocusNode = node;
        },
        onFocusChanged: (hasFocus) {
          _handleFocusChanged(hasFocus);
          // if (hasFocus) {
          //   print('hasFocus : ${hasFocus}');
          //   this._overlayEntry = this._createOverlayEntry(_dropDownFocusNode);
          //   Overlay.of(context)?.insert(this._overlayEntry!);
          // }
          // else {
          //   this._overlayEntry?.remove();
          // }
        },
        onChanged: (queryStr) {
          print('decouce text: ${queryStr}');
          _handleValueChanged(queryStr);
          // widget.getDataFromAPI!(queryStr)
          //     .then((dataList) => widget.items?.addAll(dataList));
        },
      ),
    );
  }

  void showOverlay([bool show = true]) {
    if (show && _overlayEntry == null) {
      final overlay = this._createOverlayEntry(_dropDownFocusNode);
      _overlayEntry = overlay;
      Overlay.of(context)?.insert(overlay);
    } else if (!show && _overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    setState(() => _isOpen = show);
  }

  OverlayEntry _createOverlayEntry(FocusScopeNode? focusNode) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: FocusScope(
                  autofocus: true,
                  node: focusNode,
                  child: Material(
                    elevation: 4.0,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: <Widget>[
                        ListTile(
                          title: Text('Syria'),
                          onTap: () {
                            print('Syria Tapped');
                          },
                        ),
                        ListTile(
                          title: Text('Lebanon'),
                          onTap: () {
                            print('Lebanon Tapped');
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

class DebounceRoundBoarderTextFieldState extends DebounceSimpleTextField {
  final String placeHolder;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double order;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final bool? enabled;
  final TextAlign alignment;
  final ValueChanged<FocusNode>? onFocusCreated;
  final ValueChanged<bool>? onFocusChanged;
  final FocusOnKeyCallback? onKey;

  DebounceRoundBoarderTextFieldState({
    Key? key,
    required this.placeHolder,
    this.onChanged,
    this.controller,
    this.enabled,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.order = 1,
    this.inputFormatters,
    this.keyboardType,
    this.onFocusCreated,
    this.onFocusChanged,
    this.alignment = TextAlign.start,
    this.onKey,
  }) : super(
            key: key,
            placeHolder: placeHolder,
            controller: controller,
            onChanged: onChanged,
            order: order,
            fillColor: fillColor,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            alignment: alignment,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(),
            enabled: enabled,
            onKey: onKey,
            onFocusCreated: onFocusCreated,
            onFocusChanged: onFocusChanged);
}

class DebounceSimpleTextField extends StatefulWidget {
  final String placeHolder;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double order;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final bool? enabled;
  final TextAlign alignment;
  final ValueChanged<FocusNode>? onFocusCreated;
  final ValueChanged<bool>? onFocusChanged;
  final FocusOnKeyCallback? onKey;

  const DebounceSimpleTextField({
    Key? key,
    required this.placeHolder,
    this.onChanged,
    this.controller,
    this.enabled,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.order = 1,
    this.inputFormatters,
    this.keyboardType,
    this.alignment = TextAlign.start,
    this.focusedBorder,
    this.onFocusCreated,
    this.onFocusChanged,
    this.border,
    this.onKey,
  }) : super(key: key);

  @override
  _DebounceSimpleTextFieldState createState() =>
      _DebounceSimpleTextFieldState();
}

class _DebounceSimpleTextFieldState extends State<DebounceSimpleTextField> {
  // final myController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    // myController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleEditText(
      placeHolder: widget.placeHolder,
      controller: widget.controller,
      order: widget.order,
      fillColor: widget.fillColor,
      suffixIcon: widget.suffixIcon,
      prefixIcon: widget.prefixIcon,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      focusedBorder: widget.focusedBorder,
      alignment: widget.alignment,
      border: widget.border,
      enabled: widget.enabled,
      onFocusCreated: widget.onFocusCreated,
      onFocusChanged: widget.onFocusChanged,
      onKey: widget.onKey,
      onChanged: (queryStr) {
        // print('Searchable text: ${queryStr}');
        if (widget.onChanged != null) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 1000), () {
            widget.onChanged!(queryStr);
            // .then((dataList) => widget.dataList?.addAll(dataList));
          });
        }
      },
    );
  }
}
