import 'package:flutter/material.dart';

class CommandInput extends StatelessWidget {
  const CommandInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isRunning,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isRunning;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      textInputAction: TextInputAction.send,
      onSubmitted: (_) => onSubmitted(),
      decoration: InputDecoration(
        hintText: 'adb shell pm list packages',
        filled: true,
        fillColor: const Color(0xFF141A24),
        hintStyle: .new(
          color: Colors.grey.shade700,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.terminal),
        suffixIcon: IconButton(
          onPressed: isRunning ? null : onSubmitted,
          icon: const Icon(Icons.play_arrow),
          tooltip: 'Run',
        ),
      ),
    );
  }
}
