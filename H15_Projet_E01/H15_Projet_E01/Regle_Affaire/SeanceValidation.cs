using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using H15_Projet_E01.Regle_Affaire;

namespace H15_Projet_E01.Models
{
    public partial class Seance : IValidatableObject
    {
        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            yield return DateValide.Validate(this);

        }
    }
}