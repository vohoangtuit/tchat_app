import 'package:floor/floor.dart';
import 'package:tchat/models/user_model.dart';
@dao
abstract class UserDao {

  @Query('SELECT * FROM UserModel')
  Future<List<UserModel>> findAllUsers();

  @Query('SELECT * FROM UserModel WHERE uid = :uid LIMIT 1')
  Future<UserModel?> searchById(String uid);

  @Query('SELECT * FROM UserModel LIMIT 1')
  Future<UserModel?> getSingleUser();

  @insert
  Future<void> insertUser(UserModel user);

  @Query('DELETE FROM UserModel')
  Future<void> deleteAllUsers();

  @update
  Future<void> updateUser(UserModel user);

}