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
            if (seance.DateSeance == null)
            {
                if (seance.HeureSeance != null)
                    return new ValidationResult("Vous devez choisir la date ou laisser l'heure vide");
            }
            else
            {
                if (seance.HeureSeance == null)
                    return new ValidationResult("Vous devez choisir l'heure ou laisser la date vide");
                if (seance.DateSeance < DateTime.Now)
                    return new ValidationResult("La date doit être dans le future");
               
                UnitOfWork unitOfWork = new UnitOfWork();

                foreach (Seance s in unitOfWork.SeanceRepository.GetSeances())
                {
                    if (s.DateSeance == seance.DateSeance)
                    {
                        TimeSpan ts = (TimeSpan)(((DateTime)s.HeureSeance).TimeOfDay - ((DateTime)seance.HeureSeance).TimeOfDay);
                        if (ts.Hours < 4 && ts.Hours > -4)
                            return new ValidationResult("La différence entre deux séances en même journée devrait être plus de 4h. La séance la plus proche : " + s.DateSeance.Value.ToString("dd-MM-yyyy") + " " + s.HeureSeance.Value.ToString("HH:mm"));
                    }
                }
            }
            return ValidationResult.Success;

        }
    }
}