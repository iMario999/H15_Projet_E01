using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace H15_Projet_E01.Models
{
    [MetadataType(typeof(PhotoMetaData))]
    public partial class Photo
    {
        internal sealed class PhotoMetaData
        {
            public int PhotoID { get; set; }
            [Display(Name = "Séance")]
            public int SeanceID { get; set; }
            [Display(Name = "Type de fichier")]
            public string fileType { get; set; }
            [Display(Name = "Chemin d'accès")]
            public string Path { get; set; }
        }
    }
}