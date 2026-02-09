import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../models/device_info.dart';

class DeviceBar extends StatelessWidget {
  const DeviceBar({
    super.key,
    required this.devices,
    required this.loading,
    required this.errorText,
    required this.selectedSerial,
    required this.onChanged,
    required this.onRefresh,
    required this.onScan,
    required this.scanning,
  });

  final List<DeviceInfo> devices;
  final bool loading;
  final String? errorText;
  final String? selectedSerial;
  final ValueChanged<String?> onChanged;
  final VoidCallback onRefresh;
  final VoidCallback onScan;
  final bool scanning;

  @override
  Widget build(BuildContext context) {
    final hasDevices = devices.isNotEmpty;
    final availableSerials = devices.map((d) => d.serial).toSet();
    final effectiveSelectedSerial = selectedSerial != null &&
            availableSerials.contains(selectedSerial)
        ? selectedSerial
        : null;
    final seenSerials = <String>{};
    final dropdownItems = devices
        .where((d) => seenSerials.add(d.serial))
        .map(
          (d) => DropdownMenuItem<String>(
            value: d.serial,
            child: Text(
              '${d.serial} (${d.state})',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF121720),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          const Icon(Icons.usb, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: loading
                ? const Text('Loading devices...')
                : hasDevices
                    ? DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          value: effectiveSelectedSerial,
                          isExpanded: true,
                          hint: const Text('Select device'),
                          items: dropdownItems,
                          onChanged: onChanged,
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF121720),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.08),
                              ),
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.expand_more),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 300,
                            decoration: BoxDecoration(
                              color: const Color(0xFF121720),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.08),
                              ),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      )
                    : const Text('No devices found'),
          ),
          if (errorText != null) ...[
            const SizedBox(width: 8),
            Tooltip(
              message: errorText!,
              child: const Icon(Icons.warning_amber_rounded, size: 18),
            ),
          ],
          IconButton(
            onPressed: loading ? null : onRefresh,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh devices',
          ),
          IconButton(
            onPressed: scanning ? null : onScan,
            icon: const Icon(Icons.radar),
            tooltip: 'Scan LAN (port 5555)',
          ),
        ],
      ),
    );
  }
}
