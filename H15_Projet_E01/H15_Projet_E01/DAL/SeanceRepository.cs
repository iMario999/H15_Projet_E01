using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using H15_Projet_E01.Models;

namespace H15_Projet_E01.DAL
{
    public class SeanceRepository: GenericRepository<Seance>
    {
        public SeanceRepository(PhotoDuvalEntities context) : base(context) { }
        public IEnumerable<Seance> GetSeances()
        {
            return Get();
        }
        public Seance GetSeanceByID(int id)
        {
            return GetByID(id);
        }
        public void InsertSeance(Seance seance)
        {
            Insert(seance);
        }
        public void UpdateSeance(Seance seance)
        {
            Update(seance);
        }
        public void DeleteSeance(int id)
        {
            Delete(id);
        }
    }
}