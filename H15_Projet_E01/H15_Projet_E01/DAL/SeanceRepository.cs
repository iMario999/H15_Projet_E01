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
        public Seance GetSeanceByID(int? id)
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
        public void DeleteSeance(int? id)
        {
            Delete(id);
        }


        public ICollection<Seance> getFutureSeances()
        {
            var seances = from seance in Get()
                          where seance.DateSeance > DateTime.Now
                          select seance;
            return seances.ToList();
        }

        /// <summary>
        /// Retourner seulement les seances qui ont ou n'ont pas la date de seances
        /// </summary>
        /// <param name="enAttente">true si on veut les séances en attente, false si on ne veut pas voir les seances pas de date</param>
        /// <returns></returns>
        public ICollection<Seance> getSeanceEnAttente(bool enAttente)
        {
            IEnumerable<Seance> seances;
            if (enAttente)
            {
                seances = from seance in Get()
                              where seance.DateSeance == null
                              select seance;
            }
            else
            {
                seances = from seance in Get()
                              where seance.DateSeance != null
                              select seance;
            }
            return seances.ToList();
        }
    }
}