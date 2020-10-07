import 'package:provider/provider.dart';
import 'package:lucento/core/viewmodels/auth_model.dart';
import 'package:lucento/locator.dart';

class ProviderInjector {
  static List<SingleChildCloneableWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._consumableServices,
  ];
  static List<SingleChildCloneableWidget> _independentServices = [
    ChangeNotifierProvider.value(value: locator<AuthModel>()),
  ];
  static List<SingleChildCloneableWidget> _dependentServices = [];

  static List<SingleChildCloneableWidget> _consumableServices = [];
}
