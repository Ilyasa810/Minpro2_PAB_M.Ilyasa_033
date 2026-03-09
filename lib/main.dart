import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/pages/home_page.dart';
import 'providers/team_provider.dart';
import 'providers/theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://utlxpmenxlhbilsfpxrd.supabase.co',
    anonKey: 'sb_publishable_-SL06gPLtJmY78gv3cnI5A_SzF6m07R',
  );

  await _ensureSupabaseSession();

  runApp(const MainApp());
}

Future<void> _ensureSupabaseSession() async {
  final client = Supabase.instance.client;
  if (client.auth.currentSession != null) {
    return;
  }

  try {
    await client.auth.signInAnonymously();
  } catch (_) {
    // Keep app running; provider will show a clear error if RLS still blocks CRUD.
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TeamProvider()..fetchTeams()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Katalog Tim Sepakbola',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blueGrey,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blueGrey,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
