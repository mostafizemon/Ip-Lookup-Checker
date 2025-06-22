import 'package:flutter/material.dart';
import 'package:ip_lookup_check/features/check_ip/bloc/checkip_bloc.dart';
import 'package:ip_lookup_check/features/check_ip/ui/check_ip_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_lookup_check/theme/app_theme.dart';

void main() {
  runApp(
    BlocProvider(create: (context) => CheckipBloc(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ip Lookup Check',
      theme: AppTheme.lightThemeData,
      home: CheckIpScreen(),
    );
  }
}
