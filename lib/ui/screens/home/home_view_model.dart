import 'package:hichat/core/other/base_view_model.dart';
import 'package:hichat/core/services/database_service.dart';

class HomeViewModel extends BaseViewModel {
  final DatabaseService _db;

  HomeViewModel(this._db);
}
