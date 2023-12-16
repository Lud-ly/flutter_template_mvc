import 'package:mvc_pattern/mvc_pattern.dart';

class HomeController extends ControllerMVC {
  int currentPagination = 1;
  late int totalPage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  nextPagination() {
    setState(() {
      currentPagination++;
    });
  }

  previousPagination() {
    setState(() {
      currentPagination--;
    });
  }
}
