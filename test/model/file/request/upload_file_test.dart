import 'package:chat_gpt_sdk_lululala/chat_gpt_sdk_lululala.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('upload file test', () {
    test('upload file test get from', () {
      final upload = UploadFile(file: FileInfo("path", 'name'));

      expect(upload.getForm(), isA<Future<FormData>>());
    });
  });
}
