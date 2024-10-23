using Denticare.Domain;

namespace Denticare.Infrastructure
{
    public class UnitOfWork : IUnitOfWork
    {
        public Task<int> CommitAsync(CancellationToken cancellation = default)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public ValueTask DisposeAsync()
        {
            throw new NotImplementedException();
        }

        public IRepository<T> Repository<T>() where T : class
        {
            throw new NotImplementedException();
        }

        public Task RollbackAsync(CancellationToken cancellation = default)
        {
            throw new NotImplementedException();
        }
    }
}
