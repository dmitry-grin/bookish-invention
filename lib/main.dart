import 'package:bookish_invention/providers.dart';
import 'package:bookish_invention/routing/routes.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviderScope(
      externalInterfaceProviders: [bookishExternalInterfaceProvider],
      child: AppRouterScope(
        create: BookishRouter.new,
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.from(colorScheme: const ColorScheme.light(primary: Colors.black)),
            routerConfig: context.router.config,
          );
        },
      ),
    );
  }
}
