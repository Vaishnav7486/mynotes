import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotesapp/constants/routes.dart';
import 'package:mynotesapp/helpers/loading/loading_screen.dart';
import 'package:mynotesapp/services/auth/bloc/auth_bloc.dart';
import 'package:mynotesapp/services/auth/bloc/auth_event.dart';
import 'package:mynotesapp/services/auth/bloc/auth_state.dart';
import 'package:mynotesapp/services/auth/firebase_auth_provider.dart';
import 'package:mynotesapp/views/forgot_password_view.dart';
import 'package:mynotesapp/views/login_view.dart';
import 'package:mynotesapp/views/notes/create_update_note_view.dart';
import 'package:mynotesapp/views/notes/notes_view.dart';
import 'package:mynotesapp/views/register_view.dart';
import 'package:mynotesapp/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
              context: context,
              text: state.loadingText ?? "please wait a moment");
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );

    // return FutureBuilder(
    //   future: AuthService.firebase().initialize(),
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.done:
    //         final user = AuthService.firebase().currentUser;
    //         if (user != null) {
    //           if (user.isEmailVerified) {
    //             // basicWarning(context, 'Verified User');
    //             devtools.log(user.toString());
    //             devtools.log('User verified');
    //             return const NotesView();
    //           } else {
    //             // return const VerifyEmailView();
    //             devtools.log(user.toString());
    //             devtools.log('Passing to verify email view');
    //             // basicWarning(context, 'Non verified User');
    //             // return const NotesView();
    //             return const VerifyEmailView();
    //           }
    //         } else {
    //           // basicWarning(context, 'User have to verify');
    //           return const LoginView();
    //         }
    //       default:
    //         return const CircularProgressIndicator();
    //     }
    //   },
    // );
  }
}


// time stopped - 1.10.30.00


// note that I have commented everything in the auth_test.dart
// remaining things 
// 1 creating a app key  - genkey -v -keystore.......
// project / android / key.properties 
// update build.gradle for signing in 
// flutter build app bundle
// flutter localization dependancy installing 
//  the localization and internationalization part has not done by me in this project 