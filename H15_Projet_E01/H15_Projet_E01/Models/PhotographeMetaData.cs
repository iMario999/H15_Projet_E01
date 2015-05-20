using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace H15_Projet_E01.Models
{
     [MetadataType(typeof(PhotographeMetaData))]
    public partial class Photographe
    {

         internal sealed class PhotographeMetaData
         {

             public int PhotographeID { get; set; }
             [Required]
             public string Nom { get; set; }
             [Required]
             [Display(Name = "Prénom")]
             public string Prenom { get; set; }
             [Required]
             [RegularExpression("^\\([0-9]{3}\\)-?[0-9]{3}-[0-9]{4}", ErrorMessage = "Format doit être (000)000-0000 ou (000)-000-0000")]
             public string Telephone { get; set; }
             public string email { get; set; }

         }


    }
}