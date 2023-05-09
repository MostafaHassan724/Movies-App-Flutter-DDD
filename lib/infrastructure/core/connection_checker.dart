import 'package:internet_connection_checker/internet_connection_checker.dart';

extension InternetConnectionCheckerX on InternetConnectionChecker {
  Future<bool> get isNotConnected async {
    return !(await hasConnection);
  }
}
