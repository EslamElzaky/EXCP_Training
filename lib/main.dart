import 'package:excp_training/constant.dart';
import 'package:excp_training/cubits/Categories/categories_cubit.dart';
import 'package:excp_training/cubits/ReadTask/read_task_cubit.dart';
import 'package:excp_training/cubits/task_cubit/task_cubit_cubit.dart';
import 'package:excp_training/firebase_options.dart';
import 'package:excp_training/helper/bottom_navigation.dart';
import 'package:excp_training/models/taske_model.dart';
import 'package:excp_training/simple_bloc_observer.dart';
import 'package:excp_training/views/Categories_page.dart';
import 'package:excp_training/views/eidt_profile_page.dart';
import 'package:excp_training/views/eidt_taske_page.dart';
import 'package:excp_training/views/home_view.dart';
import 'package:excp_training/views/login_page.dart';
import 'package:excp_training/views/profile_page.dart';
import 'package:excp_training/views/regester_page.dart';
import 'package:excp_training/views/change_password.dart';
import 'package:excp_training/views/view_taske_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk(kTaskesBox);
  Hive.registerAdapter(TaskeModelAdapter());
  await Hive.openBox<TaskeModel>(kTaskesBox);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskCubitCubit()),
        BlocProvider(create: (context) => ReadTaskCubit()),
        BlocProvider(create: (context) => CategoriesCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
        routes: {
          'login_page': (context) => LoginPage(),
          'BottomNavigation': (context) => BottomNavigation(),
          HomeView.id: (context) => HomeView(),
          'regesterpage': (context) => RegesterPage(),
          'ProfilePage': (context) => ProfilePage(),
          'edit_profile_page': (context) => EidtProfilePage(),
          'changePassword': (context) => ChangePasswordPage(),
          'task_view_page': (context) => ViewTaskePage(),
          'categories_page': (context) => ManageCategoriesPage(),
          'EidtTaskePage': (context) => EditTaskPage(),
        },
        initialRoute: 'login_page',
      ),
    );
  }
}
