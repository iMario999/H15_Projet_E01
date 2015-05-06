using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using H15_Projet_E01.Models;
using H15_Projet_E01.DAL;

namespace H15_Projet_E01.Regle_Affaire
{
    public class DateValide
    {
        public static ValidationResult Validate(Seance seance)
        {
            if (seance.DateSeance == null && seance.HeureSeance == null)
            {
                return ValidationResult.Success;
            }

            UnitOfWork unitOfWork = new UnitOfWork();
            /*
            foreach (Seance s in unitOfWork.SeanceRepository.GetSeances())
            {
                
                if (s.DateSeance == seance.DateSeance)
                {
                    TimeSpan ts = (TimeSpan)(s.HeureSeance - seance.HeureSeance);
                    if (ts.Hours < 4 || ts.Hours > -4)
                        return new ValidationResult("La différence entre deux séances en même journée devrait être plus de 4h. La séance la plus proche : " + s.DateSeance.Value.ToString("dd-MM-yyyy") + " "+  s.HeureSeance.Value.ToString("HH:mm"));
                }
            }
             */
            return ValidationResult.Success;

        }
    }
}