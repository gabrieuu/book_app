import 'package:book_app/modules/book_details/details_controller.dart';
import 'package:book_app/modules/book_details/page/details_page.dart';
import 'package:book_app/modules/favoritas/favoritas_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailsModule extends Module {
  @override
  // TODO: implement imports
  List<Module> get imports => [FavoritasModule()];

  @override
  void binds(Injector i) {
    i.addSingleton(DetailsController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => DetailsPage(book: r.args.data));
  }
}
