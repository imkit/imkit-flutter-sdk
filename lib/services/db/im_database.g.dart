// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorIMDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$IMDatabaseBuilder databaseBuilder(String name) =>
      _$IMDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$IMDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$IMDatabaseBuilder(null);
}

class _$IMDatabaseBuilder {
  _$IMDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$IMDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$IMDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<IMDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$IMDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$IMDatabase extends IMDatabase {
  _$IMDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  IMRoomDao? _roomDaoInstance;

  IMMessageDao? _messageDaoInstance;

  IMUserDao? _userDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `IMRoom` (`id` TEXT NOT NULL, `type` TEXT NOT NULL, `name` TEXT NOT NULL, `desc` TEXT, `coverUrl` TEXT, `numberOfUnreadMessages` INTEGER NOT NULL, `isMuted` INTEGER NOT NULL, `isMentioned` INTEGER NOT NULL, `isTranslationEnabled` INTEGER NOT NULL, `lastMessage` TEXT, `members` TEXT NOT NULL, `roomTags` TEXT NOT NULL, `tags` TEXT NOT NULL, `createdAt` INTEGER, `updatedAt` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IMMessage` (`id` TEXT NOT NULL, `roomId` TEXT NOT NULL, `type` TEXT NOT NULL, `systemEvent` TEXT, `sender` TEXT, `createdAt` INTEGER, `updatedAt` INTEGER, `responseObject` TEXT, `text` TEXT, `stickerId` TEXT, `mentions` TEXT NOT NULL, `images` TEXT NOT NULL, `file` TEXT, `location` TEXT, `extra` TEXT, `status` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IMUser` (`id` TEXT NOT NULL, `nickname` TEXT NOT NULL, `desc` TEXT, `avatarUrl` TEXT, `lastLoginAt` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  IMRoomDao get roomDao {
    return _roomDaoInstance ??= _$IMRoomDao(database, changeListener);
  }

  @override
  IMMessageDao get messageDao {
    return _messageDaoInstance ??= _$IMMessageDao(database, changeListener);
  }

  @override
  IMUserDao get userDao {
    return _userDaoInstance ??= _$IMUserDao(database, changeListener);
  }
}

class _$IMRoomDao extends IMRoomDao {
  _$IMRoomDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _iMRoomInsertionAdapter = InsertionAdapter(
            database,
            'IMRoom',
            (IMRoom item) => <String, Object?>{
                  'id': item.id,
                  'type': _iMRoomTypeConverter.encode(item.type),
                  'name': item.name,
                  'desc': item.desc,
                  'coverUrl': item.coverUrl,
                  'numberOfUnreadMessages': item.numberOfUnreadMessages,
                  'isMuted': item.isMuted ? 1 : 0,
                  'isMentioned': item.isMentioned ? 1 : 0,
                  'isTranslationEnabled': item.isTranslationEnabled ? 1 : 0,
                  'lastMessage': _iMMessageConverter.encode(item.lastMessage),
                  'members': _iMUserListConverter.encode(item.members),
                  'roomTags': _iMStringListConverter.encode(item.roomTags),
                  'tags': _iMTagListConverter.encode(item.tags),
                  'createdAt': _iMDateTimeConverter.encode(item.createdAt),
                  'updatedAt': _iMDateTimeConverter.encode(item.updatedAt)
                },
            changeListener),
        _iMRoomUpdateAdapter = UpdateAdapter(
            database,
            'IMRoom',
            ['id'],
            (IMRoom item) => <String, Object?>{
                  'id': item.id,
                  'type': _iMRoomTypeConverter.encode(item.type),
                  'name': item.name,
                  'desc': item.desc,
                  'coverUrl': item.coverUrl,
                  'numberOfUnreadMessages': item.numberOfUnreadMessages,
                  'isMuted': item.isMuted ? 1 : 0,
                  'isMentioned': item.isMentioned ? 1 : 0,
                  'isTranslationEnabled': item.isTranslationEnabled ? 1 : 0,
                  'lastMessage': _iMMessageConverter.encode(item.lastMessage),
                  'members': _iMUserListConverter.encode(item.members),
                  'roomTags': _iMStringListConverter.encode(item.roomTags),
                  'tags': _iMTagListConverter.encode(item.tags),
                  'createdAt': _iMDateTimeConverter.encode(item.createdAt),
                  'updatedAt': _iMDateTimeConverter.encode(item.updatedAt)
                },
            changeListener),
        _iMRoomDeletionAdapter = DeletionAdapter(
            database,
            'IMRoom',
            ['id'],
            (IMRoom item) => <String, Object?>{
                  'id': item.id,
                  'type': _iMRoomTypeConverter.encode(item.type),
                  'name': item.name,
                  'desc': item.desc,
                  'coverUrl': item.coverUrl,
                  'numberOfUnreadMessages': item.numberOfUnreadMessages,
                  'isMuted': item.isMuted ? 1 : 0,
                  'isMentioned': item.isMentioned ? 1 : 0,
                  'isTranslationEnabled': item.isTranslationEnabled ? 1 : 0,
                  'lastMessage': _iMMessageConverter.encode(item.lastMessage),
                  'members': _iMUserListConverter.encode(item.members),
                  'roomTags': _iMStringListConverter.encode(item.roomTags),
                  'tags': _iMTagListConverter.encode(item.tags),
                  'createdAt': _iMDateTimeConverter.encode(item.createdAt),
                  'updatedAt': _iMDateTimeConverter.encode(item.updatedAt)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<IMRoom> _iMRoomInsertionAdapter;

  final UpdateAdapter<IMRoom> _iMRoomUpdateAdapter;

  final DeletionAdapter<IMRoom> _iMRoomDeletionAdapter;

  @override
  Stream<List<IMRoom>> findRooms() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM IMRoom ORDER BY updatedAt DESC',
        mapper: (Map<String, Object?> row) => IMRoom(
            id: row['id'] as String,
            type: _iMRoomTypeConverter.decode(row['type'] as String),
            name: row['name'] as String,
            desc: row['desc'] as String?,
            coverUrl: row['coverUrl'] as String?,
            numberOfUnreadMessages: row['numberOfUnreadMessages'] as int,
            isMuted: (row['isMuted'] as int) != 0,
            isMentioned: (row['isMentioned'] as int) != 0,
            isTranslationEnabled: (row['isTranslationEnabled'] as int) != 0,
            createdAt: _iMDateTimeConverter.decode(row['createdAt'] as int?),
            updatedAt: _iMDateTimeConverter.decode(row['updatedAt'] as int?),
            lastMessage:
                _iMMessageConverter.decode(row['lastMessage'] as String?),
            members: _iMUserListConverter.decode(row['members'] as String),
            roomTags: _iMStringListConverter.decode(row['roomTags'] as String),
            tags: _iMTagListConverter.decode(row['tags'] as String)),
        queryableName: 'IMRoom',
        isView: false);
  }

  @override
  Stream<IMRoom?> findRoom(String id) {
    return _queryAdapter.queryStream('SELECT * FROM IMRoom WHERE id = ?1',
        mapper: (Map<String, Object?> row) => IMRoom(
            id: row['id'] as String,
            type: _iMRoomTypeConverter.decode(row['type'] as String),
            name: row['name'] as String,
            desc: row['desc'] as String?,
            coverUrl: row['coverUrl'] as String?,
            numberOfUnreadMessages: row['numberOfUnreadMessages'] as int,
            isMuted: (row['isMuted'] as int) != 0,
            isMentioned: (row['isMentioned'] as int) != 0,
            isTranslationEnabled: (row['isTranslationEnabled'] as int) != 0,
            createdAt: _iMDateTimeConverter.decode(row['createdAt'] as int?),
            updatedAt: _iMDateTimeConverter.decode(row['updatedAt'] as int?),
            lastMessage:
                _iMMessageConverter.decode(row['lastMessage'] as String?),
            members: _iMUserListConverter.decode(row['members'] as String),
            roomTags: _iMStringListConverter.decode(row['roomTags'] as String),
            tags: _iMTagListConverter.decode(row['tags'] as String)),
        arguments: [id],
        queryableName: 'IMRoom',
        isView: false);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM IMRoom');
  }

  @override
  Future<void> insertItem(IMRoom item) async {
    await _iMRoomInsertionAdapter.insert(item, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertItems(List<IMRoom> items) async {
    await _iMRoomInsertionAdapter.insertList(items, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateItem(IMRoom item) async {
    await _iMRoomUpdateAdapter.update(item, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateItems(List<IMRoom> items) {
    return _iMRoomUpdateAdapter.updateListAndReturnChangedRows(
        items, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteItem(IMRoom item) async {
    await _iMRoomDeletionAdapter.delete(item);
  }

  @override
  Future<int> deleteItems(List<IMRoom> items) {
    return _iMRoomDeletionAdapter.deleteListAndReturnChangedRows(items);
  }
}

class _$IMMessageDao extends IMMessageDao {
  _$IMMessageDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _iMMessageInsertionAdapter = InsertionAdapter(
            database,
            'IMMessage',
            (IMMessage item) => <String, Object?>{
                  'id': item.id,
                  'roomId': item.roomId,
                  'type': _iMMessageTypeConverter.encode(item.type),
                  'systemEvent':
                      _iMSystemEventConverter.encode(item.systemEvent),
                  'sender': _iMUserConverter.encode(item.sender),
                  'createdAt': _iMDateTimeConverter.encode(item.createdAt),
                  'updatedAt': _iMDateTimeConverter.encode(item.updatedAt),
                  'responseObject':
                      _iMResponseObjectConverter.encode(item.responseObject),
                  'text': item.text,
                  'stickerId': item.stickerId,
                  'mentions': _iMStringListConverter.encode(item.mentions),
                  'images': _iMImageListConverter.encode(item.images),
                  'file': _iMFileConverter.encode(item.file),
                  'location': _iMLocationConverter.encode(item.location),
                  'extra': _iMMapConverter.encode(item.extra),
                  'status': _iMMessageStatusConverter.encode(item.status)
                },
            changeListener),
        _iMMessageUpdateAdapter = UpdateAdapter(
            database,
            'IMMessage',
            ['id'],
            (IMMessage item) => <String, Object?>{
                  'id': item.id,
                  'roomId': item.roomId,
                  'type': _iMMessageTypeConverter.encode(item.type),
                  'systemEvent':
                      _iMSystemEventConverter.encode(item.systemEvent),
                  'sender': _iMUserConverter.encode(item.sender),
                  'createdAt': _iMDateTimeConverter.encode(item.createdAt),
                  'updatedAt': _iMDateTimeConverter.encode(item.updatedAt),
                  'responseObject':
                      _iMResponseObjectConverter.encode(item.responseObject),
                  'text': item.text,
                  'stickerId': item.stickerId,
                  'mentions': _iMStringListConverter.encode(item.mentions),
                  'images': _iMImageListConverter.encode(item.images),
                  'file': _iMFileConverter.encode(item.file),
                  'location': _iMLocationConverter.encode(item.location),
                  'extra': _iMMapConverter.encode(item.extra),
                  'status': _iMMessageStatusConverter.encode(item.status)
                },
            changeListener),
        _iMMessageDeletionAdapter = DeletionAdapter(
            database,
            'IMMessage',
            ['id'],
            (IMMessage item) => <String, Object?>{
                  'id': item.id,
                  'roomId': item.roomId,
                  'type': _iMMessageTypeConverter.encode(item.type),
                  'systemEvent':
                      _iMSystemEventConverter.encode(item.systemEvent),
                  'sender': _iMUserConverter.encode(item.sender),
                  'createdAt': _iMDateTimeConverter.encode(item.createdAt),
                  'updatedAt': _iMDateTimeConverter.encode(item.updatedAt),
                  'responseObject':
                      _iMResponseObjectConverter.encode(item.responseObject),
                  'text': item.text,
                  'stickerId': item.stickerId,
                  'mentions': _iMStringListConverter.encode(item.mentions),
                  'images': _iMImageListConverter.encode(item.images),
                  'file': _iMFileConverter.encode(item.file),
                  'location': _iMLocationConverter.encode(item.location),
                  'extra': _iMMapConverter.encode(item.extra),
                  'status': _iMMessageStatusConverter.encode(item.status)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<IMMessage> _iMMessageInsertionAdapter;

  final UpdateAdapter<IMMessage> _iMMessageUpdateAdapter;

  final DeletionAdapter<IMMessage> _iMMessageDeletionAdapter;

  @override
  Stream<List<IMMessage>> findMessages(String roomId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM IMMessage WHERE roomId = ?1 ORDER BY createdAt ASC',
        mapper: (Map<String, Object?> row) => IMMessage(
            id: row['id'] as String,
            roomId: row['roomId'] as String,
            type: _iMMessageTypeConverter.decode(row['type'] as String),
            systemEvent:
                _iMSystemEventConverter.decode(row['systemEvent'] as String?),
            sender: _iMUserConverter.decode(row['sender'] as String?),
            createdAt: _iMDateTimeConverter.decode(row['createdAt'] as int?),
            updatedAt: _iMDateTimeConverter.decode(row['updatedAt'] as int?),
            text: row['text'] as String?,
            stickerId: row['stickerId'] as String?,
            responseObject: _iMResponseObjectConverter
                .decode(row['responseObject'] as String?),
            mentions: _iMStringListConverter.decode(row['mentions'] as String),
            images: _iMImageListConverter.decode(row['images'] as String),
            file: _iMFileConverter.decode(row['file'] as String?),
            location: _iMLocationConverter.decode(row['location'] as String?),
            extra: _iMMapConverter.decode(row['extra'] as String?),
            status: _iMMessageStatusConverter.decode(row['status'] as String)),
        arguments: [roomId],
        queryableName: 'IMMessage',
        isView: false);
  }

  @override
  Future<IMMessage?> findLatestMessage(String roomId) async {
    return _queryAdapter.query(
        'SELECT * FROM IMMessage WHERE roomId = ?1 ORDER BY createdAt DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => IMMessage(id: row['id'] as String, roomId: row['roomId'] as String, type: _iMMessageTypeConverter.decode(row['type'] as String), systemEvent: _iMSystemEventConverter.decode(row['systemEvent'] as String?), sender: _iMUserConverter.decode(row['sender'] as String?), createdAt: _iMDateTimeConverter.decode(row['createdAt'] as int?), updatedAt: _iMDateTimeConverter.decode(row['updatedAt'] as int?), text: row['text'] as String?, stickerId: row['stickerId'] as String?, responseObject: _iMResponseObjectConverter.decode(row['responseObject'] as String?), mentions: _iMStringListConverter.decode(row['mentions'] as String), images: _iMImageListConverter.decode(row['images'] as String), file: _iMFileConverter.decode(row['file'] as String?), location: _iMLocationConverter.decode(row['location'] as String?), extra: _iMMapConverter.decode(row['extra'] as String?), status: _iMMessageStatusConverter.decode(row['status'] as String)),
        arguments: [roomId]);
  }

  @override
  Future<void> deleteByRoom(String roomId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM IMMessage WHERE roomId = ?1',
        arguments: [roomId]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM IMMessage');
  }

  @override
  Future<void> insertItem(IMMessage item) async {
    await _iMMessageInsertionAdapter.insert(item, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertItems(List<IMMessage> items) async {
    await _iMMessageInsertionAdapter.insertList(
        items, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateItem(IMMessage item) async {
    await _iMMessageUpdateAdapter.update(item, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateItems(List<IMMessage> items) {
    return _iMMessageUpdateAdapter.updateListAndReturnChangedRows(
        items, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteItem(IMMessage item) async {
    await _iMMessageDeletionAdapter.delete(item);
  }

  @override
  Future<int> deleteItems(List<IMMessage> items) {
    return _iMMessageDeletionAdapter.deleteListAndReturnChangedRows(items);
  }
}

class _$IMUserDao extends IMUserDao {
  _$IMUserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _iMUserInsertionAdapter = InsertionAdapter(
            database,
            'IMUser',
            (IMUser item) => <String, Object?>{
                  'id': item.id,
                  'nickname': item.nickname,
                  'desc': item.desc,
                  'avatarUrl': item.avatarUrl,
                  'lastLoginAt': _iMDateTimeConverter.encode(item.lastLoginAt)
                }),
        _iMUserUpdateAdapter = UpdateAdapter(
            database,
            'IMUser',
            ['id'],
            (IMUser item) => <String, Object?>{
                  'id': item.id,
                  'nickname': item.nickname,
                  'desc': item.desc,
                  'avatarUrl': item.avatarUrl,
                  'lastLoginAt': _iMDateTimeConverter.encode(item.lastLoginAt)
                }),
        _iMUserDeletionAdapter = DeletionAdapter(
            database,
            'IMUser',
            ['id'],
            (IMUser item) => <String, Object?>{
                  'id': item.id,
                  'nickname': item.nickname,
                  'desc': item.desc,
                  'avatarUrl': item.avatarUrl,
                  'lastLoginAt': _iMDateTimeConverter.encode(item.lastLoginAt)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<IMUser> _iMUserInsertionAdapter;

  final UpdateAdapter<IMUser> _iMUserUpdateAdapter;

  final DeletionAdapter<IMUser> _iMUserDeletionAdapter;

  @override
  Future<IMUser?> findUser(String id) async {
    return _queryAdapter.query('SELECT * FROM IMUser WHERE id = ?1',
        mapper: (Map<String, Object?> row) => IMUser(
            id: row['id'] as String,
            nickname: row['nickname'] as String,
            desc: row['desc'] as String?,
            avatarUrl: row['avatarUrl'] as String?,
            lastLoginAt:
                _iMDateTimeConverter.decode(row['lastLoginAt'] as int?)),
        arguments: [id]);
  }

  @override
  Future<void> insertItem(IMUser item) async {
    await _iMUserInsertionAdapter.insert(item, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertItems(List<IMUser> items) async {
    await _iMUserInsertionAdapter.insertList(items, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateItem(IMUser item) async {
    await _iMUserUpdateAdapter.update(item, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateItems(List<IMUser> items) {
    return _iMUserUpdateAdapter.updateListAndReturnChangedRows(
        items, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteItem(IMUser item) async {
    await _iMUserDeletionAdapter.delete(item);
  }

  @override
  Future<int> deleteItems(List<IMUser> items) {
    return _iMUserDeletionAdapter.deleteListAndReturnChangedRows(items);
  }
}

// ignore_for_file: unused_element
final _iMStringListConverter = IMStringListConverter();
final _iMDateTimeConverter = IMDateTimeConverter();
final _iMRoomTypeConverter = IMRoomTypeConverter();
final _iMMessageConverter = IMMessageConverter();
final _iMUserConverter = IMUserConverter();
final _iMUserListConverter = IMUserListConverter();
final _iMTagListConverter = IMTagListConverter();
final _iMMessageTypeConverter = IMMessageTypeConverter();
final _iMMessageStatusConverter = IMMessageStatusConverter();
final _iMSystemEventConverter = IMSystemEventConverter();
final _iMResponseObjectConverter = IMResponseObjectConverter();
final _iMImageListConverter = IMImageListConverter();
final _iMFileConverter = IMFileConverter();
final _iMLocationConverter = IMLocationConverter();
final _iMMapConverter = IMMapConverter();
