import 'package:flutter/material.dart';

class OutputHeader extends StatelessWidget {
  const OutputHeader({
    super.key,
    required this.exitCode,
    required this.isRunning,
    required this.onCopy,
    required this.onToggleHistory,
    required this.historyVisible,
  });

  final int? exitCode;
  final bool isRunning;
  final VoidCallback onCopy;
  final VoidCallback onToggleHistory;
  final bool historyVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          isRunning ? 'Running' : 'Output',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        if (exitCode != null)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: exitCode == 0
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'exit $exitCode',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        const Spacer(),
        IconButton(
          onPressed: onToggleHistory,
          icon: Icon(historyVisible ? Icons.history_toggle_off : Icons.history),
          tooltip: 'Toggle history',
        ),
        IconButton(
          onPressed: onCopy,
          icon: const Icon(Icons.copy),
          tooltip: 'Copy output',
        ),
        if (isRunning)
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
      ],
    );
  }
}
