import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heylo/common/widgets/error.dart';
import 'package:heylo/common/widgets/loader.dart';
import 'package:heylo/features/auth/controller/auth_controller.dart';
import 'package:heylo/features/auth/pages/splash_screen.dart';
import 'package:heylo/features/auth/pages/welcome_page.dart';
import 'package:heylo/features/chat/pages/chats_home_page.dart';
import 'package:heylo/router.dart';
import 'package:heylo/theme/heylo_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  await dotenv.load(fileName: '.env');

  await Firebase.initializeApp();
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Heylo',
      theme: HeyloTheme.darkTheme,
      home: ref
          .watch(authInitializationProvider)
          .when(
            data: (_) {
              // Auth persistence has been initialized
              return ref
                  .watch(userDataAuthProvider)
                  .when(
                    data: (user) {
                      if (user == null) {
                        return const WelcomePage();
                      }
                      return const ChatsHomePage();
                    },
                    error: (err, trace) {
                      return ErrorPage(error: err.toString());
                    },
                    loading: () => const Loader(),
                  );
            },
            error: (err, trace) {
              return ErrorPage(error: 'Failed to initialize auth: $err');
            },
            loading: () => const SplashScreen(),
          ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
