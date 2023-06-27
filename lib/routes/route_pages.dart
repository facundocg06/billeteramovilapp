import 'package:billeteramovil/pages/Register.dart';
import 'package:billeteramovil/routes/route_names.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../pages/Login.dart';
import '../pages/Registro.dart';

class RoutePages {
  const RoutePages._();

  static List<GetPage<dynamic>> get all {
    return [
      GetPage(
        name: RouteNames.signIn,
        page: () => LoginPage(),
      ),
      //  GetPage(
      //   name: RouteNames.home,
      //   page: () => const HomePage(),
      // ),
      GetPage(
        name: RouteNames.registro,
        page: () => const Register(),
      ),
      //   GetPage(
      //   name: RouteNames.registrardenuncias,
      //   page: () => RegistroDenuncia(),
      // ),
    ];
  }
}
