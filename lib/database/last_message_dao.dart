import 'package:floor/floor.dart';
import 'package:tchat/models/last_message_model.dart';


@dao
abstract class LastMessageDao {

  @Query('SELECT * FROM LastMessageModel')
  Future<List<LastMessageModel?>> getAllLastMessage();

  @Query('SELECT * FROM LastMessageModel WHERE idReceiver = :idReceiver LIMIT 1')
  Future<LastMessageModel?> getLastMessageById(String idReceiver);

  @Query('SELECT * FROM LastMessageModel WHERE uid = :uid GROUP BY idReceiver ORDER BY timestamp DESC')//  DESC ASC
  Future<List<LastMessageModel>> getSingleLastMessage(String uid);

  @Query('SELECT * FROM LastMessageModel LIMIT 1')
  Future<LastMessageModel?> getSingleMessage();

  @update
  Future<void> updateLastMessageById(LastMessageModel message);

  @insert
  Future<void> insertMessage(LastMessageModel message);

  @Query("DELETE FROM LastMessageModel")
  Future<void> deleteAllLastMessage();

}