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
            UnitOfWork unitOfWork = new UnitOfWork();

            Seance seanceAvantModif = unitOfWork.SeanceRepository.GetSeanceByID(seance.SeanceID);


                if (seance.DateSeance == null)
                {
                    if (seance.HeureSeance != null)
                        return new ValidationResult("Vous devez choisir la date ou laisser l'heure vide");
                }
                else
                {
                    if (seanceAvantModif.DateSeance != seance.DateSeance || seanceAvantModif.HeureSeance.Value.TimeOfDay != seance.HeureSeance.Value.TimeOfDay)
                        //il y a eu un changement de date ou heure
                    {
                        if (seanceAvantModif.DateSeance < DateTime.Now)
                            return new ValidationResult("Vous ne pouvez pas modifier la date de la séance déjà passée");
                        if (seance.HeureSeance == null)
                            return new ValidationResult("Vous devez choisir l'heure ou laisser la date vide");
                        if (seance.DateSeance <= DateTime.Now)
                            return new ValidationResult("La date doit être dans le future");
                        if (seance.DateSeance > DateTime.Now.AddDays(15))
                            return new ValidationResult("La date ne doit pas être plus loin que d'ici aujourd'hui + 15 jours");


                        foreach (Seance s in unitOfWork.SeanceRepository.GetSeances())//comparer avec tous les séances 
                        {
                            if (s.DateSeance == seance.DateSeance)//si les deux dates sont pareilles, valide
                            {
                                if (s.SeanceID != seance.SeanceID)//si c'est la même séance, skip
                                {
                                    if (s.PhotographeID == seance.PhotographeID)//si c'est le même photographe, valide
                                    {
                                        TimeSpan ts = (TimeSpan)(((DateTime)s.HeureSeance).TimeOfDay - ((DateTime)seance.HeureSeance).TimeOfDay);
                                        if (ts.Hours < 4 && ts.Hours > -4)//si la différence est +- 4h, erreur
                                            return new ValidationResult("La différence entre deux séances en même journée devrait être plus de 4h. La séance la plus proche : " + s.DateSeance.Value.ToString("dd-MM-yyyy") + " " + s.HeureSeance.Value.ToString("HH:mm"));

                                    }
                                }
                            }
                        }
                    }
                }


            

            
            return ValidationResult.Success;

        }
    }
}