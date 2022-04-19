import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

Future<File> convertUrlImageToFile(String url) async {
  var response = await get(
    Uri.parse(url),
  );
  final documentDirectory = await getApplicationDocumentsDirectory();
  final standPhoto = File(
    '${documentDirectory.path}/${url.split("/").last}',
  );
  return await standPhoto.writeAsBytes(response.bodyBytes);
}
