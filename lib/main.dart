import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master_admin/Data/db_service.dart';
import 'package:weigh_master_admin/Presentation/adding_page.dart';
import 'package:weigh_master_admin/Presentation/login_page.dart';

import 'firebase_options.dart';
import 'Presentation/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DbService>(create: (_) => DbService())
      ],
      child: MaterialApp(
        theme: ThemeData(
          // backgroundColor: Colors.red,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Weigh Master Admin',
        home: HomePage(),
      ),
    );
  }
}
