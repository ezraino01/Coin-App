 import 'package:image_picker/image_picker.dart';
Future<XFile?> imagePicker() async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (file != null) {
    return file;
  } else {
    print('no image selected');
    return null;
  }
}

