import '../../../../core/utils/localized_text.dart';
import '../../domain/entities/session_summary.dart';

/// One scheduled astrologer reply.
class ScriptedLine {
  const ScriptedLine(this.after, this.text);

  /// Time from the start of the session at which this line arrives.
  final Duration after;
  final String text;
}

/// The scripted half of a mock consultation.
///
/// Paced like a real reading — a greeting, questions back, then substance —
/// so the chat screen is exercised with realistic gaps rather than an
/// instant wall of text. Deliberately generic enough to fit any question the
/// seeker typed at intake.
abstract final class ConsultationScript {
  static const List<ScriptedLine> lines = [
    ScriptedLine(
      Duration(seconds: 2),
      'Namaste. I have your birth details in front of me.',
    ),
    ScriptedLine(
      Duration(seconds: 8),
      'Give me a moment to cast the chart and look at your current '
      'Dasha period.',
    ),
    ScriptedLine(
      Duration(seconds: 18),
      'You are running Jupiter mahadasha with a Saturn antardasha. That '
      'combination usually feels slow, but it is constructive — things '
      'built now tend to last.',
    ),
    ScriptedLine(
      Duration(seconds: 32),
      'Is there a particular area you would like me to focus on — career, '
      'relationship, or health?',
    ),
    ScriptedLine(
      Duration(seconds: 55),
      'Your tenth house lord is well placed, which supports a change of '
      'role. The period after the next two months is more favourable '
      'than right now.',
    ),
    ScriptedLine(
      Duration(seconds: 80),
      'I would suggest a simple remedy to steady the Saturn influence. '
      'I will add the details to your session summary.',
    ),
    ScriptedLine(
      Duration(seconds: 110),
      'Do you have any other question before we close?',
    ),
  ];

  static const String summaryNotes =
      'Jupiter mahadasha with Saturn antardasha — a constructive but slow '
      'period. The tenth house lord supports a change of role, more strongly '
      'after the next two months. Avoid signing anything binding during the '
      'current retrograde window.';

  static const List<Remedy> remedies = [
    Remedy(
      kind: RemedyKind.mantra,
      title: LocalizedText(
        ne: 'शनि मन्त्र',
        en: 'Shani mantra',
        hi: 'शनि मंत्र',
      ),
      description: LocalizedText(
        ne: 'हरेक शनिबार बिहान १०८ पटक जप गर्नुहोस् ।',
        en: 'Recite 108 times on Saturday mornings.',
        hi: 'प्रत्येक शनिवार प्रातः 108 बार जप करें।',
      ),
    ),
    Remedy(
      kind: RemedyKind.gemstone,
      title: LocalizedText(ne: 'नीलम', en: 'Blue sapphire', hi: 'नीलम'),
      description: LocalizedText(
        ne: 'चाँदीको औंठीमा, माझी औंलामा — पहिले तीन दिन परीक्षण गर्नुहोस् ।',
        en:
            'Set in silver, worn on the middle finger. Trial it for three '
            'days first.',
        hi: 'चाँदी में जड़वाकर मध्यमा में धारण करें। पहले तीन दिन परीक्षण करें।',
      ),
      productId: 'neelam',
    ),
    Remedy(
      kind: RemedyKind.donation,
      title: LocalizedText(
        ne: 'शनिबारको दान',
        en: 'Saturday donation',
        hi: 'शनिवार का दान',
      ),
      description: LocalizedText(
        ne: 'शनिबार कालो तिल वा सरसोंको तेल दान गर्नुहोस् ।',
        en: 'Donate black sesame or mustard oil on Saturdays.',
        hi: 'शनिवार को काले तिल या सरसों का तेल दान करें।',
      ),
    ),
  ];
}
