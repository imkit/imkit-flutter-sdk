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

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  IMRoomDao get roomDao {
    return _roomDaoInstance ??= _$IMRoomDao(database, changeListener);
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

// ignore_for_file: unused_element
final _iMStringListConverter = IMStringListConverter();
final _iMDateTimeConverter = IMDateTimeConverter();
final _iMRoomTypeConverter = IMRoomTypeConverter();
final _iMMessageConverter = IMMessageConverter();
final _iMUserListConverter = IMUserListConverter();
final _iMTagListConverter = IMTagListConverter();
