import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:student_project/bloc/add_student/bloc/add_image_bloc.dart';
import 'package:student_project/bloc/home/bloc/home_bloc.dart';

import 'package:student_project/bloc/search/bloc/search_bloc.dart';
import 'package:student_project/bloc/update_image/bloc/update_image_bloc.dart';
import 'package:student_project/db/models/student_model.dart';
import 'package:student_project/widget/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  await Hive.openBox<StudentModel>('student_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => AddImageBloc()),
        BlocProvider(create: (context) => UpdateImageBloc()),
        BlocProvider(create: (context) => SearchBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const HomeScreen(),
      ),
    );
  }
}
