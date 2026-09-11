import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';

/// Feature-local strings for blogs / news.
abstract class ContentStrings {
  const ContentStrings();

  static ContentStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get blogs;
  String get news;
  String get categories;
  String get language;
  String get tags;
  String get all;
  String get nepali;
  String get english;
  String get hindi;
  String get recentPosts;
  String get sharePost;
  String get inCategory;
  String get minRead;
  String get noArticles;
  String get linkCopied;
  String get like;

  /// Placeholder ad-slot labels (kept in English like the Figma frames).
  String get blogsAds;
  String get newsAds;

  /// Titles of the embeddable "latest articles" section.
  String get latestBlogs;
  String get latestNews;
}

class _En extends ContentStrings {
  const _En();
  @override
  String get blogs => 'Blogs';
  @override
  String get news => 'News';
  @override
  String get categories => 'Categories';
  @override
  String get language => 'Language';
  @override
  String get tags => 'Tags';
  @override
  String get all => 'All';
  @override
  String get nepali => 'Nepali';
  @override
  String get english => 'English';
  @override
  String get hindi => 'Hindi';
  @override
  String get recentPosts => 'Recent Posts';
  @override
  String get sharePost => 'Share this post';
  @override
  String get inCategory => 'In';
  @override
  String get minRead => 'min read';
  @override
  String get noArticles => 'No posts found for this filter.';
  @override
  String get linkCopied => 'Link copied to clipboard';
  @override
  String get like => 'Like';
  @override
  String get blogsAds => 'BLOGS PAGE ADS';
  @override
  String get newsAds => 'NEWS PAGE ADS';
  @override
  String get latestBlogs => 'Latest Blogs';
  @override
  String get latestNews => 'Latest News';
}

class _Ne extends ContentStrings {
  const _Ne();
  @override
  String get blogs => 'ब्लगहरू';
  @override
  String get news => 'समाचार';
  @override
  String get categories => 'वर्गहरू';
  @override
  String get language => 'भाषा';
  @override
  String get tags => 'ट्यागहरू';
  @override
  String get all => 'सबै';
  @override
  String get nepali => 'नेपाली';
  @override
  String get english => 'English';
  @override
  String get hindi => 'हिन्दी';
  @override
  String get recentPosts => 'हालैका पोस्टहरू';
  @override
  String get sharePost => 'यो पोस्ट सेयर गर्नुहोस्';
  @override
  String get inCategory => 'वर्ग:';
  @override
  String get minRead => 'मिनेट पढाइ';
  @override
  String get noArticles => 'यस फिल्टरमा कुनै पोस्ट भेटिएन ।';
  @override
  String get linkCopied => 'लिङ्क प्रतिलिपि गरियो';
  @override
  String get like => 'मन पर्‍यो';
  @override
  String get blogsAds => 'BLOGS PAGE ADS';
  @override
  String get newsAds => 'NEWS PAGE ADS';
  @override
  String get latestBlogs => 'पछिल्ला ब्लगहरू';
  @override
  String get latestNews => 'ताजा समाचार';
}

class _Hi extends ContentStrings {
  const _Hi();
  @override
  String get blogs => 'ब्लॉग';
  @override
  String get news => 'समाचार';
  @override
  String get categories => 'श्रेणियाँ';
  @override
  String get language => 'भाषा';
  @override
  String get tags => 'टैग';
  @override
  String get all => 'सभी';
  @override
  String get nepali => 'नेपाली';
  @override
  String get english => 'English';
  @override
  String get hindi => 'हिन्दी';
  @override
  String get recentPosts => 'हाल की पोस्ट';
  @override
  String get sharePost => 'यह पोस्ट साझा करें';
  @override
  String get inCategory => 'श्रेणी:';
  @override
  String get minRead => 'मिनट पढ़ें';
  @override
  String get noArticles => 'इस फ़िल्टर में कोई पोस्ट नहीं मिली।';
  @override
  String get linkCopied => 'लिंक क्लिपबोर्ड पर कॉपी हो गया';
  @override
  String get like => 'पसंद';
  @override
  String get blogsAds => 'BLOGS PAGE ADS';
  @override
  String get newsAds => 'NEWS PAGE ADS';
  @override
  String get latestBlogs => 'नवीनतम ब्लॉग';
  @override
  String get latestNews => 'ताज़ा ख़बरें';
}
