import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/features/content/data/datasources/api_article_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/entities/article.dart';

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.handler);
  final Future<ResponseBody> Function(RequestOptions options) handler;
  final List<RequestOptions> seen = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    seen.add(options);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _ok(Object body) => ResponseBody.fromString(
  jsonEncode(body),
  200,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

ResponseBody _error(int status, String kind, String code) =>
    ResponseBody.fromString(
      jsonEncode({
        'error': {
          'kind': kind,
          'code': code,
          'message': 'nope',
          'traceId': 't1',
        },
      }),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

ApiClient _clientFor(_StubAdapter adapter) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.test/api/v1',
      validateStatus: (s) => s != null && s < 400,
    ),
  )..httpClientAdapter = adapter;
  return ApiClient(dio: dio);
}

/// The server's article payload, as `packages/db` stores it.
const _articleJson = {
  'id': '01ABC',
  'slug': 'why-we-light-diyo',
  'type': 'blog',
  'title': {'en': 'Why we light the diyo', 'ne': 'किन दियो बाल्छौं'},
  'excerpt': {'en': 'The evening lamp.', 'ne': 'साँझको दियो।'},
  'body': [
    {'en': 'Paragraph one.', 'ne': 'पहिलो अनुच्छेद।'},
  ],
  'categoryKey': 'tradition',
  'categoryLabel': {'en': 'Tradition', 'ne': 'परम्परा'},
  'tags': [
    {
      'key': 'diyo',
      'label': {'en': 'Diyo', 'ne': 'दियो'},
    },
  ],
  'author': {'en': 'Sanatan Desk'},
  'readTimeMinutes': 3,
  'imageKey': 'seed/diyo.jpg',
  'publishedAt': '2026-09-01T10:00:00.000Z',
  'likeCount': 12,
  'isLiked': true,
};

void main() {
  test('maps the server payload onto the app model', () async {
    final adapter = _StubAdapter((_) async => _ok([_articleJson]));
    final source = ApiArticleDataSource(_clientFor(adapter));

    final articles = await source.fetchArticles(ArticleType.blog);

    expect(articles, hasLength(1));
    final article = articles.single;
    expect(article.id, '01ABC');
    expect(article.type, ArticleType.blog);
    expect(article.title.en, 'Why we light the diyo');
    expect(article.title.ne, 'किन दियो बाल्छौं');
    expect(article.body.single.ne, 'पहिलो अनुच्छेद।');
    expect(article.category.key, 'tradition');
    expect(article.category.label.en, 'Tradition');
    expect(article.tags.single.label.ne, 'दियो');
    expect(article.likes, 12);
    expect(article.isLiked, isTrue);
    expect(article.publishedAt.toUtc().year, 2026);
  });

  test('requests the type as a query parameter', () async {
    final adapter = _StubAdapter((_) async => _ok(const []));
    await ApiArticleDataSource(
      _clientFor(adapter),
    ).fetchArticles(ArticleType.news);

    expect(adapter.seen.single.queryParameters['type'], 'news');
    expect(adapter.seen.single.path, '/content/articles');
  });

  test('survives a payload with fields missing', () async {
    // The client must not crash on a partial record — a missing optional
    // translation is normal, not exceptional.
    final adapter = _StubAdapter(
      (_) async => _ok([
        {
          'id': 'x',
          'title': {'en': 'Bare'},
        },
      ]),
    );

    final article = (await ApiArticleDataSource(
      _clientFor(adapter),
    ).fetchArticles(ArticleType.blog)).single;

    expect(article.id, 'x');
    expect(article.title.en, 'Bare');
    expect(article.title.ne, isNull);
    expect(article.body, isEmpty);
    expect(article.likes, 0);
  });

  test('turns a not-found envelope into NotFoundException', () async {
    final adapter = _StubAdapter(
      (_) async => _error(404, 'notFound', 'NOT_FOUND'),
    );

    await expectLater(
      ApiArticleDataSource(_clientFor(adapter)).fetchArticle('missing'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('turns a permission envelope into PermissionException', () async {
    final adapter = _StubAdapter(
      (_) async => _error(403, 'permission', 'UNAUTHENTICATED'),
    );

    await expectLater(
      ApiArticleDataSource(_clientFor(adapter)).toggleLike('x'),
      throwsA(isA<PermissionException>()),
    );
  });

  test('turns a connection failure into NetworkException', () async {
    final adapter = _StubAdapter(
      (options) async => throw DioException.connectionError(
        requestOptions: options,
        reason: 'offline',
      ),
    );

    await expectLater(
      ApiArticleDataSource(_clientFor(adapter)).fetchArticles(ArticleType.blog),
      throwsA(isA<NetworkException>()),
    );
  });
}
