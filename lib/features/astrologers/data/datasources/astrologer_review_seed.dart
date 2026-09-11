import '../../domain/entities/astrologer_review.dart';

/// Seeded reviews, dated relative to a fixed anchor so ordering is stable
/// across runs. `_daysAgo` keeps them looking recent without a time bomb in
/// the assertions that depend on them.
final DateTime _anchor = DateTime.now();

DateTime _daysAgo(int days) => _anchor.subtract(Duration(days: days));

final List<AstrologerReview> astrologerReviewSeed = [
  AstrologerReview(
    id: 'rv-1',
    astrologerId: 'np-uttam',
    authorName: 'Sabina K.',
    rating: 5,
    comment:
        'Very detailed reading of my chart. He explained the Dasha period '
        'clearly and the remedies were simple to follow.',
    tags: ['Accurate', 'Patient'],
    createdAt: _daysAgo(3),
    reply: 'Thank you Sabina. Wishing you well in the new role.',
    repliedAt: _daysAgo(2),
  ),
  AstrologerReview(
    id: 'rv-2',
    astrologerId: 'np-uttam',
    authorName: 'Rajan M.',
    rating: 4,
    comment: 'Good session, though we ran short on time for the Vaastu part.',
    tags: ['Knowledgeable'],
    createdAt: _daysAgo(9),
  ),
  AstrologerReview(
    id: 'rv-3',
    astrologerId: 'np-uttam',
    authorName: 'Prakash B.',
    rating: 5,
    comment: 'Second consultation with him. Consistent and honest.',
    tags: ['Honest', 'Accurate'],
    createdAt: _daysAgo(21),
  ),
  AstrologerReview(
    id: 'rv-4',
    astrologerId: 'np-sarita',
    authorName: 'Nisha T.',
    rating: 5,
    comment: 'The tarot pull was surprisingly on point about my job change.',
    tags: ['Insightful'],
    createdAt: _daysAgo(5),
  ),
  AstrologerReview(
    id: 'rv-5',
    astrologerId: 'np-sarita',
    authorName: 'Amrit S.',
    rating: 4,
    comment: 'Clear and quick. Would consult again.',
    tags: ['Quick'],
    createdAt: _daysAgo(14),
  ),
  AstrologerReview(
    id: 'rv-6',
    astrologerId: 'np-hari',
    authorName: 'Gita P.',
    rating: 5,
    comment:
        'Nadi reading was remarkably specific about family details I had '
        'not shared.',
    tags: ['Accurate', 'Experienced'],
    createdAt: _daysAgo(6),
  ),
  AstrologerReview(
    id: 'rv-7',
    astrologerId: 'np-bishnu',
    authorName: 'Sunita R.',
    rating: 5,
    comment: 'Did the Gun Milan for my daughter. Very thorough.',
    tags: ['Thorough'],
    createdAt: _daysAgo(2),
  ),
  AstrologerReview(
    id: 'rv-8',
    astrologerId: 'np-anjali',
    authorName: 'Dipesh L.',
    rating: 4,
    comment: 'Helpful gemstone advice, no pressure to buy anything.',
    tags: ['Honest'],
    createdAt: _daysAgo(11),
  ),
  AstrologerReview(
    id: 'rv-9',
    astrologerId: 'in-rajesh',
    authorName: 'Ankit V.',
    rating: 5,
    comment:
        'Asked about a business decision and got a clear answer with timing. '
        'Worth the wait in the queue.',
    tags: ['Accurate', 'Practical'],
    createdAt: _daysAgo(4),
    reply: 'Glad it helped. Do share how it goes.',
    repliedAt: _daysAgo(3),
  ),
  AstrologerReview(
    id: 'rv-10',
    astrologerId: 'in-rajesh',
    authorName: 'Priya N.',
    rating: 4,
    comment: 'Detailed, though the chat was a little slow to start.',
    tags: ['Detailed'],
    createdAt: _daysAgo(17),
  ),
  AstrologerReview(
    id: 'rv-11',
    astrologerId: 'in-meera',
    authorName: 'Ravi S.',
    rating: 5,
    comment: 'South Indian chart style explained properly for the first time.',
    tags: ['Knowledgeable', 'Patient'],
    createdAt: _daysAgo(8),
  ),
  AstrologerReview(
    id: 'rv-12',
    astrologerId: 'in-devika',
    authorName: 'Kavya J.',
    rating: 4,
    comment: 'Quick tarot reading at a fair price.',
    tags: ['Quick', 'Affordable'],
    createdAt: _daysAgo(1),
  ),
  AstrologerReview(
    id: 'rv-13',
    astrologerId: 'in-arun',
    authorName: 'Manoj G.',
    rating: 5,
    comment: 'Vaastu changes he suggested for the shop were practical.',
    tags: ['Practical'],
    createdAt: _daysAgo(13),
  ),
  AstrologerReview(
    id: 'rv-14',
    astrologerId: 'in-lakshmi',
    authorName: 'Deepa H.',
    rating: 5,
    comment: 'Careful and kind. Explained what she could and could not see.',
    tags: ['Honest', 'Patient'],
    createdAt: _daysAgo(7),
  ),
];
