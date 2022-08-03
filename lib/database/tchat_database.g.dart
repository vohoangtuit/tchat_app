// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tchat_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorTChatDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TChatDatabaseBuilder databaseBuilder(String name) =>
      _$TChatDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TChatDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$TChatDatabaseBuilder(null);
}

class _$TChatDatabaseBuilder {
  _$TChatDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$TChatDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$TChatDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<TChatDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$TChatDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TChatDatabase extends TChatDatabase {
  _$TChatDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  LastMessageDao? _lastMessageDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserModel` (`idDB` INTEGER PRIMARY KEY AUTOINCREMENT, `id` TEXT, `email` TEXT, `userName` TEXT, `fullName` TEXT, `birthday` TEXT, `gender` INTEGER, `photoUrl` TEXT, `cover` TEXT, `statusAccount` INTEGER, `phone` TEXT, `createdAt` TEXT, `lastUpdated` TEXT, `lastLogin` TEXT, `deviceToken` TEXT, `isLogin` INTEGER, `address` TEXT, `isOnline` INTEGER, `accountType` INTEGER, `isOnlineChat` INTEGER, `allowSearch` INTEGER, `latitude` REAL, `longitude` REAL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `LastMessageModel` (`idDB` INTEGER PRIMARY KEY AUTOINCREMENT, `uid` TEXT, `idReceiver` TEXT, `nameReceiver` TEXT, `photoReceiver` TEXT, `timestamp` TEXT, `content` TEXT, `type` INTEGER, `status` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  LastMessageDao get lastMessageDao {
    return _lastMessageDaoInstance ??=
        _$LastMessageDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'UserModel',
            (UserModel item) => <String, Object?>{
                  'idDB': item.idDB,
                  'id': item.id,
                  'email': item.email,
                  'userName': item.userName,
                  'fullName': item.fullName,
                  'birthday': item.birthday,
                  'gender': item.gender,
                  'photoUrl': item.photoUrl,
                  'cover': item.cover,
                  'statusAccount': item.statusAccount,
                  'phone': item.phone,
                  'createdAt': item.createdAt,
                  'lastUpdated': item.lastUpdated,
                  'lastLogin': item.lastLogin,
                  'deviceToken': item.deviceToken,
                  'isLogin':
                      item.isLogin == null ? null : (item.isLogin! ? 1 : 0),
                  'address': item.address,
                  'isOnline':
                      item.isOnline == null ? null : (item.isOnline! ? 1 : 0),
                  'accountType': item.accountType,
                  'isOnlineChat': item.isOnlineChat == null
                      ? null
                      : (item.isOnlineChat! ? 1 : 0),
                  'allowSearch': item.allowSearch == null
                      ? null
                      : (item.allowSearch! ? 1 : 0),
                  'latitude': item.latitude,
                  'longitude': item.longitude
                }),
        _userModelUpdateAdapter = UpdateAdapter(
            database,
            'UserModel',
            ['idDB'],
            (UserModel item) => <String, Object?>{
                  'idDB': item.idDB,
                  'id': item.id,
                  'email': item.email,
                  'userName': item.userName,
                  'fullName': item.fullName,
                  'birthday': item.birthday,
                  'gender': item.gender,
                  'photoUrl': item.photoUrl,
                  'cover': item.cover,
                  'statusAccount': item.statusAccount,
                  'phone': item.phone,
                  'createdAt': item.createdAt,
                  'lastUpdated': item.lastUpdated,
                  'lastLogin': item.lastLogin,
                  'deviceToken': item.deviceToken,
                  'isLogin':
                      item.isLogin == null ? null : (item.isLogin! ? 1 : 0),
                  'address': item.address,
                  'isOnline':
                      item.isOnline == null ? null : (item.isOnline! ? 1 : 0),
                  'accountType': item.accountType,
                  'isOnlineChat': item.isOnlineChat == null
                      ? null
                      : (item.isOnlineChat! ? 1 : 0),
                  'allowSearch': item.allowSearch == null
                      ? null
                      : (item.allowSearch! ? 1 : 0),
                  'latitude': item.latitude,
                  'longitude': item.longitude
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  final UpdateAdapter<UserModel> _userModelUpdateAdapter;

  @override
  Future<List<UserModel>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM UserModel',
        mapper: (Map<String, Object?> row) => UserModel(
            idDB: row['idDB'] as int?,
            id: row['id'] as String?,
            email: row['email'] as String?,
            userName: row['userName'] as String?,
            fullName: row['fullName'] as String?,
            birthday: row['birthday'] as String?,
            gender: row['gender'] as int?,
            photoUrl: row['photoUrl'] as String?,
            cover: row['cover'] as String?,
            statusAccount: row['statusAccount'] as int?,
            phone: row['phone'] as String?,
            createdAt: row['createdAt'] as String?,
            lastUpdated: row['lastUpdated'] as String?,
            lastLogin: row['lastLogin'] as String?,
            deviceToken: row['deviceToken'] as String?,
            isLogin:
                row['isLogin'] == null ? null : (row['isLogin'] as int) != 0,
            address: row['address'] as String?,
            isOnline:
                row['isOnline'] == null ? null : (row['isOnline'] as int) != 0,
            accountType: row['accountType'] as int?,
            isOnlineChat: row['isOnlineChat'] == null
                ? null
                : (row['isOnlineChat'] as int) != 0,
            allowSearch: row['allowSearch'] == null
                ? null
                : (row['allowSearch'] as int) != 0,
            latitude: row['latitude'] as double?,
            longitude: row['longitude'] as double?));
  }

  @override
  Future<UserModel?> findUserById(String id) async {
    return _queryAdapter.query('SELECT * FROM UserModel WHERE id = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => UserModel(
            idDB: row['idDB'] as int?,
            id: row['id'] as String?,
            email: row['email'] as String?,
            userName: row['userName'] as String?,
            fullName: row['fullName'] as String?,
            birthday: row['birthday'] as String?,
            gender: row['gender'] as int?,
            photoUrl: row['photoUrl'] as String?,
            cover: row['cover'] as String?,
            statusAccount: row['statusAccount'] as int?,
            phone: row['phone'] as String?,
            createdAt: row['createdAt'] as String?,
            lastUpdated: row['lastUpdated'] as String?,
            lastLogin: row['lastLogin'] as String?,
            deviceToken: row['deviceToken'] as String?,
            isLogin:
                row['isLogin'] == null ? null : (row['isLogin'] as int) != 0,
            address: row['address'] as String?,
            isOnline:
                row['isOnline'] == null ? null : (row['isOnline'] as int) != 0,
            accountType: row['accountType'] as int?,
            isOnlineChat: row['isOnlineChat'] == null
                ? null
                : (row['isOnlineChat'] as int) != 0,
            allowSearch: row['allowSearch'] == null
                ? null
                : (row['allowSearch'] as int) != 0,
            latitude: row['latitude'] as double?,
            longitude: row['longitude'] as double?),
        arguments: [id]);
  }

  @override
  Future<UserModel?> getSingleUser() async {
    return _queryAdapter.query('SELECT * FROM UserModel LIMIT 1',
        mapper: (Map<String, Object?> row) => UserModel(
            idDB: row['idDB'] as int?,
            id: row['id'] as String?,
            email: row['email'] as String?,
            userName: row['userName'] as String?,
            fullName: row['fullName'] as String?,
            birthday: row['birthday'] as String?,
            gender: row['gender'] as int?,
            photoUrl: row['photoUrl'] as String?,
            cover: row['cover'] as String?,
            statusAccount: row['statusAccount'] as int?,
            phone: row['phone'] as String?,
            createdAt: row['createdAt'] as String?,
            lastUpdated: row['lastUpdated'] as String?,
            lastLogin: row['lastLogin'] as String?,
            deviceToken: row['deviceToken'] as String?,
            isLogin:
                row['isLogin'] == null ? null : (row['isLogin'] as int) != 0,
            address: row['address'] as String?,
            isOnline:
                row['isOnline'] == null ? null : (row['isOnline'] as int) != 0,
            accountType: row['accountType'] as int?,
            isOnlineChat: row['isOnlineChat'] == null
                ? null
                : (row['isOnlineChat'] as int) != 0,
            allowSearch: row['allowSearch'] == null
                ? null
                : (row['allowSearch'] as int) != 0,
            latitude: row['latitude'] as double?,
            longitude: row['longitude'] as double?));
  }

  @override
  Future<void> deleteAllUsers() async {
    await _queryAdapter.queryNoReturn('DELETE FROM UserModel');
  }

  @override
  Future<void> insertUser(UserModel user) async {
    await _userModelInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await _userModelUpdateAdapter.update(user, OnConflictStrategy.abort);
  }
}

class _$LastMessageDao extends LastMessageDao {
  _$LastMessageDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _lastMessageModelInsertionAdapter = InsertionAdapter(
            database,
            'LastMessageModel',
            (LastMessageModel item) => <String, Object?>{
                  'idDB': item.idDB,
                  'uid': item.uid,
                  'idReceiver': item.idReceiver,
                  'nameReceiver': item.nameReceiver,
                  'photoReceiver': item.photoReceiver,
                  'timestamp': item.timestamp,
                  'content': item.content,
                  'type': item.type,
                  'status': item.status
                }),
        _lastMessageModelUpdateAdapter = UpdateAdapter(
            database,
            'LastMessageModel',
            ['idDB'],
            (LastMessageModel item) => <String, Object?>{
                  'idDB': item.idDB,
                  'uid': item.uid,
                  'idReceiver': item.idReceiver,
                  'nameReceiver': item.nameReceiver,
                  'photoReceiver': item.photoReceiver,
                  'timestamp': item.timestamp,
                  'content': item.content,
                  'type': item.type,
                  'status': item.status
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LastMessageModel> _lastMessageModelInsertionAdapter;

  final UpdateAdapter<LastMessageModel> _lastMessageModelUpdateAdapter;

  @override
  Future<List<LastMessageModel?>> getAllLastMessage() async {
    return _queryAdapter.queryList('SELECT * FROM LastMessageModel',
        mapper: (Map<String, Object?> row) => LastMessageModel(
            idDB: row['idDB'] as int?,
            uid: row['uid'] as String?,
            idReceiver: row['idReceiver'] as String?,
            nameReceiver: row['nameReceiver'] as String?,
            photoReceiver: row['photoReceiver'] as String?,
            content: row['content'] as String?,
            type: row['type'] as int?,
            timestamp: row['timestamp'] as String?,
            status: row['status'] as int?));
  }

  @override
  Future<LastMessageModel?> getLastMessageById(String idReceiver) async {
    return _queryAdapter.query(
        'SELECT * FROM LastMessageModel WHERE idReceiver = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => LastMessageModel(
            idDB: row['idDB'] as int?,
            uid: row['uid'] as String?,
            idReceiver: row['idReceiver'] as String?,
            nameReceiver: row['nameReceiver'] as String?,
            photoReceiver: row['photoReceiver'] as String?,
            content: row['content'] as String?,
            type: row['type'] as int?,
            timestamp: row['timestamp'] as String?,
            status: row['status'] as int?),
        arguments: [idReceiver]);
  }

  @override
  Future<List<LastMessageModel?>> getSingleLastMessage(String uid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM LastMessageModel WHERE uid = ?1 GROUP BY idReceiver ORDER BY timestamp DESC',
        mapper: (Map<String, Object?> row) => LastMessageModel(idDB: row['idDB'] as int?, uid: row['uid'] as String?, idReceiver: row['idReceiver'] as String?, nameReceiver: row['nameReceiver'] as String?, photoReceiver: row['photoReceiver'] as String?, content: row['content'] as String?, type: row['type'] as int?, timestamp: row['timestamp'] as String?, status: row['status'] as int?),
        arguments: [uid]);
  }

  @override
  Future<LastMessageModel?> getSingleMessage() async {
    return _queryAdapter.query('SELECT * FROM LastMessageModel LIMIT 1',
        mapper: (Map<String, Object?> row) => LastMessageModel(
            idDB: row['idDB'] as int?,
            uid: row['uid'] as String?,
            idReceiver: row['idReceiver'] as String?,
            nameReceiver: row['nameReceiver'] as String?,
            photoReceiver: row['photoReceiver'] as String?,
            content: row['content'] as String?,
            type: row['type'] as int?,
            timestamp: row['timestamp'] as String?,
            status: row['status'] as int?));
  }

  @override
  Future<void> deleteAllLastMessage() async {
    await _queryAdapter.queryNoReturn('DELETE FROM LastMessageModel');
  }

  @override
  Future<void> insertMessage(LastMessageModel message) async {
    await _lastMessageModelInsertionAdapter.insert(
        message, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateLastMessageById(LastMessageModel message) async {
    await _lastMessageModelUpdateAdapter.update(
        message, OnConflictStrategy.abort);
  }
}
