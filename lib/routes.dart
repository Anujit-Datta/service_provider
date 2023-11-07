  import 'package:service_provider/Pages/forgotpassword.dart';
  import 'package:service_provider/Pages/launcher.dart';
  import 'package:service_provider/Pages/login.dart';
  import 'package:service_provider/Pages/Register.dart';
import 'package:service_provider/Pages/services.dart';
  import 'package:service_provider/Pages/userHome.dart';

  const loginRoute = '/login';
  const registerRoute = '/register';
  const launcherRoute = '/launcher';
  const userHomePageRoute = '/userHome';
  const forgotPasswordRoute = '/forgotpass';
  const servicesRoute = '/services';

  var appRoutes={
    loginRoute: (context)=> const LoginPage(),
    registerRoute: (context)=> const RegisterPage(),
    launcherRoute: (context)=> const launcherPage(),
    userHomePageRoute: (context)=> const userHomePage(),
    forgotPasswordRoute: (context)=> const forgotPassword(),
    servicesRoute: (context)=> const Services(),
  };
