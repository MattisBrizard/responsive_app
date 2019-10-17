import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_app/api/image_api_client.dart';
import 'package:responsive_app/modules/images/images_bloc.dart';
import 'package:responsive_app/modules/images/images_events.dart';
import 'package:responsive_app/modules/images/images_page.dart';
import 'package:responsive_app/repository/image_repository.dart';

void main() {
  bool isDebugMode = false;
  assert(isDebugMode = true);
  if (isDebugMode) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => ImagesBloc(
        imageRepository: ImageRepository(
          client: ImageApiClient(),
        ),
      )..add(FetchImages()),
      child: MaterialApp(
        title: 'Flutter Responsive App',
        debugShowCheckedModeBanner: false,
        home: ImagesPage(),
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
