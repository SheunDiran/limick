import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'client.dart';
import 'screens/home_shell.dart';
import 'screens/onboarding_screen.dart';
import 'screens/welcome_screen.dart';
import 'state/app_state.dart';
import 'theme.dart';
import 'widgets/common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const LimickApp());
}

class LimickApp extends StatelessWidget {
  const LimickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: app,
      builder: (context, _) => MaterialApp(
        title: 'Limick',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(Brightness.light),
        darkTheme: buildTheme(Brightness.dark),
        themeMode: app.themeMode,
        home: const AppGate(),
      ),
    );
  }
}

/// Routes between sign-in, onboarding and the app based on auth state.
class AppGate extends StatefulWidget {
  const AppGate({super.key});

  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {
  bool _signedIn = false;

  @override
  void initState() {
    super.initState();
    _signedIn = client.auth.isAuthenticated;
    client.auth.authInfoListenable.addListener(_authChanged);
    app.addListener(_rebuild);
    if (_signedIn) app.refresh();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_authChanged);
    app.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  void _authChanged() {
    final signedIn = client.auth.isAuthenticated;
    if (signedIn == _signedIn) return;
    setState(() => _signedIn = signedIn);
    if (signedIn) {
      app.refresh();
    } else {
      app.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (!_signedIn) {
      child = const WelcomeScreen();
    } else if (app.me == null && app.error != null) {
      child = Scaffold(
        body: Empty.error(app.error!, onRetry: app.refresh),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24),
          child: TextButton(
            onPressed: () => client.auth.signOutDevice(),
            child: const Text('Sign out'),
          ),
        ),
      );
    } else if (app.me == null) {
      child = const Scaffold(body: Loading());
    } else if (!app.onboarded) {
      child = const OnboardingScreen();
    } else {
      child = const HomeShell();
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: KeyedSubtree(key: ValueKey(child.runtimeType), child: child),
    );
  }
}
