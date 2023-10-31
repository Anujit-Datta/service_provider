  import 'package:service_provider/Pages/launcher.dart';
  import 'package:service_provider/Pages/login.dart';
  import 'package:service_provider/Pages/Register.dart';

  const loginRoute = '/login';
  const registerRoute = '/register';
  const launcherRoute = '/launcher';

  var appRoutes={
    loginRoute: (context)=> const LoginPage(),
    registerRoute: (context)=> const RegisterPage(),
    launcherRoute: (context)=> const launcherPage(),
  };
