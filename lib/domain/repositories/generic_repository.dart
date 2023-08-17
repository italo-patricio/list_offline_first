abstract class GenericRepository<T> {
  Future<T> save(T entity);
  Future<List<T>> findAll();
  Future<T?> findById(int id);
  Future<bool> update(int id, T entity);
  Future<bool> delete(int id);
}
