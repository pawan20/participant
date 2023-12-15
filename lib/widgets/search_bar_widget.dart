import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onTextChanged;
  final Function() onClear;
  final String hintText;

  const SearchBarWidget({super.key, 
    required this.onTextChanged,
    required this.onClear,
    this.hintText = 'Search',
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              onChanged: widget.onTextChanged,
              decoration: InputDecoration(
                hintText: widget.hintText,
                suffixIcon: _textEditingController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _textEditingController.clear();
                          widget.onClear();
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
