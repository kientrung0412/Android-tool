import 'package:freezed_annotation/freezed_annotation.dart';

part 'command_spec.freezed.dart';

@freezed
abstract class CommandSpec with _$CommandSpec {
  const factory CommandSpec(
    String command,
    String description, [
    String? params,
  ]) = _CommandSpec;

  const CommandSpec._();

  String get suggestionLabel {
    if (params == null || params!.trim().isEmpty) {
      return description;
    }
    return '$description (${params!.trim()})';
  }
}

const List<CommandSpec> kDefaultCommands = [
  CommandSpec('adb devices', 'List connected devices'),
  CommandSpec('adb connect', 'Connect to device over TCP/IP', '<ip:port>'),
  CommandSpec('adb disconnect', 'Disconnect a TCP/IP device', '<ip:port>'),
  CommandSpec('adb root', 'Restart adbd with root permissions'),
  CommandSpec('adb remount', 'Remount /system and vendor as writable'),
  CommandSpec('adb shell', 'Start device shell'),
  CommandSpec('adb shell pm', 'Package manager help'),
  CommandSpec('adb shell pm list packages', 'List all packages on device'),
  CommandSpec(
    'adb shell pm list packages -3',
    'List third-party packages only',
  ),
  CommandSpec(
    'adb shell pm list packages | grep',
    'Quick grep for package name',
    '<keyword>',
  ),
  CommandSpec('adb shell input text', 'Input text on device', '"<text>"'),
  CommandSpec('adb shell input keyevent', 'Send key event', '<keycode>'),
  CommandSpec('adb shell dumpsys', 'Dump system services'),
  CommandSpec('adb shell dumpsys', 'Dump specific service', '<service>'),
  CommandSpec('adb shell getprop', 'List all properties'),
  CommandSpec('adb shell getprop', 'Get specific property', '<property>'),
  CommandSpec('adb install', 'Install APK', '<apk_path>'),
  CommandSpec('adb install -r', 'Reinstall/upgrade APK', '<apk_path>'),
  CommandSpec('adb uninstall', 'Uninstall package', '<package_name>'),
  CommandSpec('adb push', 'Push file to device', '<local> <remote>'),
  CommandSpec('adb pull', 'Pull file from device', '<remote> <local>'),
  CommandSpec('adb reboot', 'Reboot device'),
  CommandSpec('adb reboot bootloader', 'Reboot device to bootloader'),
  CommandSpec('adb reboot recovery', 'Reboot device to recovery'),
  CommandSpec('fastboot devices', 'List devices in fastboot mode'),
  CommandSpec('fastboot reboot', 'Reboot from fastboot mode'),
  CommandSpec('fastboot reboot bootloader', 'Reboot to bootloader mode'),
  CommandSpec('fastboot flash', 'Flash partition image', '<partition> <img>'),
  CommandSpec('fastboot boot', 'Boot kernel image once', '<img>'),
  CommandSpec('fastboot getvar all', 'Print all bootloader variables'),
  CommandSpec('fastboot erase', 'Erase partition', '<partition>'),
  CommandSpec('fastboot format', 'Format partition', '<partition>'),
];
