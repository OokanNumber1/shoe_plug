
import 'package:shoe_plug/models/product.dart';

class TimbuResponse {
  TimbuResponse({this.errorMessage, this.isLoading, this.products});
   String? errorMessage;
   List<Product>? products;
   bool? isLoading;

  static TimbuResponse empty() => TimbuResponse();
}
