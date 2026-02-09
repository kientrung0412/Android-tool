import 'package:flutter/material.dart';

class DiscoveredHostsPanel extends StatefulWidget {
  const DiscoveredHostsPanel({
    super.key,
    required this.hosts,
    required this.scanning,
    required this.errorText,
    required this.onConnect,
  });

  final List<String> hosts;
  final bool scanning;
  final String? errorText;
  final ValueChanged<String> onConnect;

  @override
  State<DiscoveredHostsPanel> createState() => _DiscoveredHostsPanelState();
}

class _DiscoveredHostsPanelState extends State<DiscoveredHostsPanel> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF121720),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.wifi_tethering, size: 18),
                const SizedBox(width: 8),
                Text(
                  widget.scanning
                      ? 'Scanning LAN for adb...'
                      : 'Discovered adb hosts (${widget.hosts.length})',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (widget.errorText != null) ...[
                  const SizedBox(width: 8),
                  Tooltip(
                    message: widget.errorText!,
                    child: const Icon(Icons.warning_amber_rounded, size: 18),
                  ),
                ],
              ],
            ),
            if (widget.hosts.isNotEmpty) ...[
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 120),
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.hosts
                          .map(
                            (host) => OutlinedButton.icon(
                              onPressed: () => widget.onConnect(host),
                              icon: const Icon(Icons.link, size: 14),
                              label: Text('$host:5555'),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
