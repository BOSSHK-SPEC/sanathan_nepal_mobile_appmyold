import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/extensions/context_extensions.dart';
import '../motion/motion.dart';
import '../router/admin_routes.dart';
import 'admin_login_panel.dart';

/// `/sign-in` — the console's only public screen.
///
/// The introduction to the app lives on the static landing site served at `/`
/// (see `landing/`), whose "Staff sign in" buttons point here. Keeping the 3D
/// journey out of the Flutter bundle means the landing never waits on the
/// engine, and this page stays a plain form.
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // No listener here: signing in refreshes the router, whose redirect
    // moves staff on (back to the page they came from, when allowed).
    return Scaffold(
      body: AuroraBackground(
        intensity: 0.7,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    // A full page load: `/` is the static landing site, not
                    // a route inside this app.
                    onPressed: () => launchUrl(
                      Uri.base.resolve(AdminRoutes.landing),
                      webOnlyWindowName: '_self',
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 18),
                    label: const Text('Sanatan Nepal'),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Material(
                        color: colors.surface,
                        elevation: 12,
                        shadowColor: Colors.black45,
                        borderRadius: BorderRadius.circular(20),
                        clipBehavior: Clip.antiAlias,
                        child: const AdminLoginPanel(embedded: true),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
