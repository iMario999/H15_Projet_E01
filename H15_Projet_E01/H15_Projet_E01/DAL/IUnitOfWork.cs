using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace H15_Projet_E01.DAL
{
    interface IUnitOfWork: IDisposable
    {
        void Save();
    }
}
