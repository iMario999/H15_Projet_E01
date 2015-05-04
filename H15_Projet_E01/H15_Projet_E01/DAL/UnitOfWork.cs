using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace H15_Projet_E01.DAL
{
    public class UnitOfWork: IUnitOfWork, IDisposable
    {
        public void Save()
        {
            throw new NotImplementedException();
        }
        void IDisposable.Dispose()
        {
            throw new NotImplementedException();
        }

    }
}