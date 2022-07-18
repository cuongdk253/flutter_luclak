import 'dart:async';
import 'dart:convert';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'dart:io';

import 'cmd.dart';

typedef OnUploadProgressCallback = void Function(double percent);

class HttpPostMultipart {
  static final HttpPostMultipart _instance = HttpPostMultipart.internal();

  HttpPostMultipart.internal();
  factory HttpPostMultipart() => _instance;

  static bool trustSelfSigned = true;

  static HttpClient getHttpClient() {
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 15)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  Map<String, String> headerSignature = {};

  setToken(String token) {
    headerSignature['x-access-token'] = token;
  }

  Future<dynamic> doUploadImage({
    required String path,
    OnUploadProgressCallback? onUploadProgress,
  }) async {
    try {
      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(path);
      int targetWidth = 1000;
      int targetHeight =
          (properties.height! * targetWidth / properties.width!).round();
      File compressedFile = await FlutterNativeImage.compressImage(
        path,
        quality: 80,
        targetWidth: targetWidth,
        targetHeight: targetHeight,
      );

      final httpClient = getHttpClient();

      final request =
          await httpClient.postUrl(Uri.parse(baseUrl + uploadImage));

      int byteCount = 0;

      var multipart = await http.MultipartFile.fromPath(
        'file',
        compressedFile.path,
        filename: path.split('/').last,
        contentType: MediaType('image', 'jpg'),
      );

      var requestMultipart =
          http.MultipartRequest("POST", Uri.parse(baseUrl + uploadImage));

      requestMultipart.files.add(multipart);

      requestMultipart.headers.addAll(headerSignature);

      var msStream = requestMultipart.finalize();

      var totalByteLength = requestMultipart.contentLength;

      request.contentLength = totalByteLength;

      request.headers.set(HttpHeaders.contentTypeHeader,
          requestMultipart.headers[HttpHeaders.contentTypeHeader]!);
      request.headers
          .set('x-access-token', requestMultipart.headers['x-access-token']!);

      Stream<List<int>> streamUpload = msStream.transform(
        StreamTransformer.fromHandlers(
          handleData: (data, sink) {
            sink.add(data);

            byteCount += data.length;
            if (onUploadProgress != null) {
              onUploadProgress(byteCount / totalByteLength);
            }
          },
          handleError: (error, stack, sink) {
            throw error;
          },
          handleDone: (sink) {
            sink.close();
          },
        ),
      );

      await request.addStream(streamUpload);

      final _httpResponse = await request.close();

      final _completer = Completer();
      final _contents = StringBuffer();
      _httpResponse.transform(utf8.decoder).listen((data) {
        _contents.write(data);
      }, onDone: () => _completer.complete(jsonDecode(_contents.toString())));

      return _completer.future;
    } catch (e) {
      _handleExeption(e);
    }
  }

  _handleExeption(e) async {
    if (e is TimeoutException) {
      // showSnackBar('mLoiTaiAnh'.tr);
      // await Future.delayed(Duration(seconds: 2));
    }

    return null;
  }
}
