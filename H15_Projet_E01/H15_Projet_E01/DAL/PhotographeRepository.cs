using H15_Projet_E01.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace H15_Projet_E01.DAL
{
    public class PhotographeRepository:GenericRepository<Photographe>
    {

        public PhotographeRepository(H15_PROJET_E01Entities3 context) : base(context) { }

        public IEnumerable<Photographe> GetPhotographes()
        {
            return Get();
        }
        public Photographe GetPhotographeByID(int? id)
        {
            return GetByID(id);
        }

    }
}