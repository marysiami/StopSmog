import 'device.dart';

class DeviceCathegory {
  final int id;
  final String title;
  final String content;
  final List<Device> devices;

  const DeviceCathegory({this.id, this.title, this.content, this.devices});
}