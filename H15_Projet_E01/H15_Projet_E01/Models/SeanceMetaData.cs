using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace H15_Projet_E01.Models
{
    [MetadataType(typeof(SeanceMetaData))]
    public partial class Seance
    {       
        internal sealed class SeanceMetaData
        {
            public int SeanceID { get; set; }
            [DataType(DataType.Date)]
            public Nullable<System.DateTime> DateSeance { get; set; }
            [Required]
            public string Adresse { get; set; }
            [Required]
            public string Ville { get; set; }
            [Required]
            [RegularExpression("^\\([0-9]{3}\\)-?[0-9]{3}-[0-9]{4}", ErrorMessage = "Format doit être (000)000-0000 ou (000)-000-0000")]
            public string Telephone { get; set; }
            [DataType(DataType.MultilineText)]
            [Required]
            public string Commentaire { get; set; }
            public int AgentID { get; set; }
            [DataType(DataType.Time)]
            public Nullable<System.DateTime> HeureSeance { get; set; }
            [DataType(DataType.Date)]
            [Display(Name = "Date de facturation")]
            public Nullable<System.DateTime> DateFacturation { get; set; }
            [Display(Name= " Nombres de photos prises")]
            public Nullable<int> NbPhotosPrise { get; set; }
            
        } 



    }
}