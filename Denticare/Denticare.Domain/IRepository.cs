namespace Denticare.Domain
{
    public interface IRepository<T> where T : class
    {
        IQueryable<T> GetAll();

        Task<T?> FindByIdAsync(params object?[] keyValues);

        void Add(T entity);

        void AddRange(IEnumerable<T> entities);

        Task AddAsync(T entity, CancellationToken cancellation = default);

        void Delete(T entity);

        void DeleteRange(IEnumerable<T> entities);

        void Update(T entity);

        void UpdateRange(IEnumerable<T> entities);
    }
}
