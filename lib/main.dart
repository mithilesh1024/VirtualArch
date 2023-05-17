import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtualarch/providers/models_provider.dart';
import 'package:virtualarch/screens/housemodels/models_detail_screen.dart';
import 'package:virtualarch/screens/upload_work/upload_info.dart';
import 'providers/chatsprovider.dart';
import 'providers/drawer_nav_provider.dart';
import 'providers/user_data_provider.dart';
import 'screens/auth/home_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/otp_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/user_info_screen.dart';
import 'screens/chats/chat_detail.dart';
import 'screens/chats/chats_screen.dart';
import 'screens/upload_work/upload_work.dart';
import 'screens/widgettree.dart';
import 'screens/accounts/account_screen.dart';
import 'screens/housemodels/exploremodels_screen.dart';
import 'screens/auth/forgotpassword_screen.dart';
import 'screens/accounts/edit_profile_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserDataProvide()),
        ChangeNotifierProvider(create: (ctx) => DrawerNavProvider()),
        ChangeNotifierProvider(create: (ctx) => ChatsProvider()),
        ChangeNotifierProvider(create: (ctx) => ModelsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VirtualArch',
        theme: ThemeData(
          // scaffoldBackgroundColor: const Color(0x40404040),
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.teal,
          canvasColor: const Color.fromARGB(64, 161, 157, 157),
          secondaryHeaderColor: Colors.white,
          fontFamily: 'Gilroy',
          textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              headlineMedium: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
              headlineSmall: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              titleMedium: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
              titleSmall: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
              )),
        ),
        // initialRoute: HomeScreen.routeName,
        home: WidgetTree(),
        //All routes for navigations.
        routes: {
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          RegisterScreen.routeName: (ctx) => const RegisterScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          ForgotPasswordScreen.routeName: (ctx) => const ForgotPasswordScreen(),
          OTPScreen.routeName: (ctx) => const OTPScreen(),
          AccountScreen.routeName: (ctx) => const AccountScreen(),
          ChatsScreen.routeName: (ctx) => const ChatsScreen(),
          ExploreModelsScreen.routeName: (ctx) => ExploreModelsScreen(),
          EditProfileScreen.routeName: (ctx) => const EditProfileScreen(),
          UserInfoScreen.routeName: (ctx) => const UserInfoScreen(),
          ChatDetail.routeName: (ctx) => const ChatDetail(),
          UploadProjInfo.routeName: (ctx) => UploadProjInfo(),
          UploadDesignScreen.routeName: (ctx) => UploadDesignScreen(),
          ModelsDetailScreen.routeName: (ctx) => ModelsDetailScreen(),
        },
      ),
    );
  }
}
