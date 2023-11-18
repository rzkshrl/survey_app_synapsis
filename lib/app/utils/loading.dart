import 'package:flutter/material.dart';
import 'package:survey_app_synapsis/app/theme/theme.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: blue,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
