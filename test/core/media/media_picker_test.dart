import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/media/media_bucket.dart';
import 'package:sanathan_nepal_mobile_app/core/media/media_picker.dart';

/// A fake platform so the picker can be exercised without a camera.
class _FakePlatform extends ImagePickerPlatform {
  _FakePlatform({this.file, this.error});

  final XFile? file;
  final Object? error;
  ImageSource? lastSource;
  double? lastMaxWidth;
  int? lastQuality;

  @override
  Future<XFile?> getImageFromSource({
    required ImageSource source,
    ImagePickerOptions options = const ImagePickerOptions(),
  }) async {
    lastSource = source;
    lastMaxWidth = options.maxWidth;
    lastQuality = options.imageQuality;
    if (error != null) throw error!;
    return file;
  }
}

XFile _png({int bytes = 1024, String name = 'shot.png', String? mimeType}) =>
    XFile.fromData(
      Uint8List.fromList(List.filled(bytes, 1)),
      name: name,
      // Android usually reports no MIME type, so the picker falls back to the
      // extension; both paths are exercised below.
      mimeType: mimeType,
      path: name,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a camera photo is downscaled before it is read', () async {
    final platform = _FakePlatform(file: _png());
    ImagePickerPlatform.instance = platform;

    final picked = await MediaPickerImpl(
      images: ImagePicker(),
    ).pick(source: MediaSource.camera, bucket: MediaBucket.userMedia);

    expect(picked, isNotNull);
    expect(platform.lastSource, ImageSource.camera);
    // A 12 MP original would be several megabytes of pixels nothing in this
    // app ever displays; capping the long edge is what keeps an upload from
    // eating a rural user's data.
    expect(platform.lastMaxWidth, 1600);
    expect(platform.lastQuality, 85);
  });

  test('cancelling the picker returns null rather than throwing', () async {
    ImagePickerPlatform.instance = _FakePlatform();

    final picked = await MediaPickerImpl(
      images: ImagePicker(),
    ).pick(source: MediaSource.gallery, bucket: MediaBucket.userMedia);

    expect(picked, isNull);
  });

  test('a file over the bucket limit is rejected with its size', () async {
    ImagePickerPlatform.instance = _FakePlatform(
      file: _png(bytes: MediaBucket.userMedia.maxBytes + 1),
    );

    await expectLater(
      MediaPickerImpl(
        images: ImagePicker(),
      ).pick(source: MediaSource.gallery, bucket: MediaBucket.userMedia),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.message,
          'message',
          allOf(contains('8 MB'), contains('8.0 MB')),
        ),
      ),
    );
  });

  test(
    'the type is read from the name when the platform reports none',
    () async {
      ImagePickerPlatform.instance = _FakePlatform(
        file: _png(name: 'holiday.jpeg'),
      );

      final picked = await MediaPickerImpl(
        images: ImagePicker(),
      ).pick(source: MediaSource.gallery, bucket: MediaBucket.userMedia);

      expect(picked?.mimeType, 'image/jpeg');
    },
  );

  test('an unsupported type names what is allowed instead', () async {
    ImagePickerPlatform.instance = _FakePlatform(file: _png(name: 'scan.pdf'));

    await expectLater(
      MediaPickerImpl(images: ImagePicker()).pick(
        source: MediaSource.gallery,
        // Avatars and chat photos are images only.
        bucket: MediaBucket.userMedia,
      ),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.message,
          'message',
          contains('JPEG'),
        ),
      ),
    );
  });

  test('a denied permission is reported as one, not as a crash', () async {
    ImagePickerPlatform.instance = _FakePlatform(
      error: PlatformException(code: 'camera_access_denied'),
    );

    await expectLater(
      MediaPickerImpl(
        images: ImagePicker(),
      ).pick(source: MediaSource.camera, bucket: MediaBucket.userMedia),
      throwsA(isA<PermissionException>()),
    );
  });

  test('an empty file is rejected before it is uploaded', () async {
    ImagePickerPlatform.instance = _FakePlatform(file: _png(bytes: 0));

    await expectLater(
      MediaPickerImpl(
        images: ImagePicker(),
      ).pick(source: MediaSource.gallery, bucket: MediaBucket.userMedia),
      throwsA(isA<ValidationException>()),
    );
  });
}
