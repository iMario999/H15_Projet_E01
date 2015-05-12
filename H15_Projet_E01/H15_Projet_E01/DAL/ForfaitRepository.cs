using H15_Projet_E01.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace H15_Projet_E01.DAL
{
    public class ForfaitRepository : GenericRepository<Forfait>
    {
        public ForfaitRepository(H15_PROJET_E01Entities1 context) : base(context) { }
        public IEnumerable<Forfait> GetForfaits()
        {
            return Get();
        }
    }
}