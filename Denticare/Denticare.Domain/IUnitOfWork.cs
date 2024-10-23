namespace Denticare.Domain
{
    public interface IUnitOfWork : IDisposable, IAsyncDisposable
    {
        IRepository<T> Repository<T>() where T : class;

        Task<int> CommitAsync(CancellationToken cancellation = default);

        Task RollbackAsync(CancellationToken cancellation = default);
    }
}
