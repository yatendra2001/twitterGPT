import 'package:twitter_gpt/models/user_model.dart';

abstract class BaseUserRepo {
  Future<void> addData({required User user});
}
