import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'domain/entities/legal_document.dart';
import 'presentation/pages/legal_document_page.dart';

/// Routes pushed on top of the shell for the legal feature.
final List<RouteBase> legalRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.privacyPolicy,
    name: 'privacyPolicy',
    builder: (context, state) =>
        const LegalDocumentPage(type: LegalDocumentType.privacyPolicy),
  ),
  GoRoute(
    path: AppRoutes.termsConditions,
    name: 'termsConditions',
    builder: (context, state) =>
        const LegalDocumentPage(type: LegalDocumentType.termsConditions),
  ),
];
