import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditor extends StatefulWidget {
  const TextEditor({super.key});

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  late final QuillController _controller = QuillController(
    document: Document(),
    selection: const TextSelection.collapsed(offset: 0),
  );

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              focusNode: FocusNode(),
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
    );
  }
}
