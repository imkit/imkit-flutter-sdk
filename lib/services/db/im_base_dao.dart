import 'package:floor/floor.dart';

abstract class IMBaseDao<T> {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertItem(T item);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateItem(T item);

  @delete
  Future<int> deleteItem(T item);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertItems(List<T> items);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateItems(List<T> items);

  @delete
  Future<int> deleteItems(List<T> items);
}
