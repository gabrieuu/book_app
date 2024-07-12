import 'package:book_app/modules/details/details_controller.dart';
import 'package:book_app/modules/details/page/details_page.dart';
import 'package:book_app/modules/favoritas/favoritas_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailsModule extends Module{


  @override
  void binds(Injector i) {
    i.addSingleton(DetailsController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => DetailsPage(book: r.args.data));
  }
}