import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_test/config/routes/router.dart';
import 'package:practical_test/config/theme/theme.dart';
import 'package:practical_test/core/constants/const.dart';
import 'package:practical_test/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocs,
      child: MaterialApp(
        title: APP_NAME,
        theme: theme,
        routes: AppRouter.routes,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.initialRoute,
      ),
    );
  }
}
