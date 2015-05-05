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
            public Nullable<System.DateTime> DateSeance { get; set; }
            [Required]
            public string Adresse { get; set; }
            [Required]
            public string Ville { get; set; }
            [Required]
            public string Telephone { get; set; }
            [DataType(DataType.MultilineText)]
            [Required]
            public string Commentaire { get; set; }
            public int AgentID { get; set; }
            public string FactureID { get; set; }
            public Nullable<System.DateTime> HeureSeance { get; set; }
            
        } 



    }
}