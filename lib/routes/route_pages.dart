import 'package:billeteramovil/pages/Registro.dart';
import 'package:billeteramovil/pages/imagens.dart';
import 'package:billeteramovil/routes/route_names.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../pages/Home.dart';
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
      GetPage(
        name: RouteNames.home,
        page: () => const Home(),
      ),
      GetPage(
        name: RouteNames.registro,
        page: () => const Registro(),
      ),
      //   GetPage(
      //   name: RouteNames.registrardenuncias,
      //   page: () => RegistroDenuncia(),
      // ),
    ];
  }
}
