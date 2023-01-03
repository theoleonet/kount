import 'dart:async';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:kount/screens/auth/auth_state.dart';

class TextEditor extends StatefulWidget {
  const TextEditor({required this.countdown_id, this.contentFromDB, super.key});

  final String countdown_id;
  final String? contentFromDB;

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> with WidgetsBindingObserver {
  late final QuillController _controller = QuillController(
    document: widget.contentFromDB != null
        ? Document.fromJson(jsonDecode(widget.contentFromDB!))
        : Document(),
    selection: const TextSelection.collapsed(offset: 0),
  );

  final textController = TextEditingController();
  Timer? _debounce;
  String? content;
  FocusNode _focus = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _focus.onKeyEvent = ((node, event) {
      saveText();
      return KeyEventResult.ignored;
    });
    _focus.addListener(() {
      saveToServer();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      saveToServer();
    }
  }

  void saveText() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        content = jsonEncode(_controller.document.toDelta());
      },
    );
  }

  void saveToServer() {
    AuthState state = AuthState();
    Databases databases = state.databases;

    if (content == null) {
      return;
    }
    var data = {'content': content!};

    Future result = databases.updateDocument(
      databaseId: '63af4631caad4e759e6e',
      collectionId: '63af48604cb294dfe0b2',
      documentId: widget.countdown_id,
      data: data,
    );

    result.then((response) {
      print(response);
    }).catchError((error) {
      print(error.response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: MediaQuery.of(context).size.height / 100 * 70 -
            MediaQuery.of(context).viewInsets.bottom / 100 * 70,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: QuillEditor(
                controller: _controller,
                readOnly: false,
                scrollController: ScrollController(),
                scrollable: true,
                focusNode: _focus,
                onTapUp: (details, p1) {
                  saveText();
                  return false;
                },
                autoFocus: false,
                expands: false,
                // maxHeight: MediaQuery.of(context).viewInsets.bottom,
                // minHeight: 300,
                padding: EdgeInsets.zero,
                placeholder: 'How was your day?',
                showCursor: true,
              ),
            ),
            QuillToolbar.basic(
              toolbarIconSize: 25,

              toolbarSectionSpacing: 10,
              controller: _controller,
              // showDividers: false,
              showFontFamily: false,
              showLink: true,
              showSmallButton: false,
              showInlineCode: false,
              showColorButton: false,
              showBackgroundColorButton: false,
              showClearFormat: false,
              // showHeaderStyle: false,
              // showListNumbers: false,
              // showListCheck: false,
              showCodeBlock: false,
              // showIndent: false,
              // showHistory: false,
              multiRowsDisplay: false,
            ),
          ],
        ),
      ),
    );
  }
}
