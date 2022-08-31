import 'package:floor/floor.dart';
import 'package:tchat/models/person_model.dart';

@dao
abstract class PersonDao{
  @Query('SELECT * FROM PersonModel')
  Future<List<PersonModel>> getAllPerson();

  @Query('SELECT * FROM PersonModel WHERE uid = :uid LIMIT 1')
  Future<PersonModel?> searchById(String uid);

  @Query('SELECT * FROM PersonModel LIMIT 1')
  Future<PersonModel?> getSinglePerson();

  @insert
  Future<void> insertPerson(PersonModel person);

  @Query('DELETE FROM PersonModel')
  Future<void> deleteAllPerson();

  @update
  Future<void> updatePerson(PersonModel person);
}