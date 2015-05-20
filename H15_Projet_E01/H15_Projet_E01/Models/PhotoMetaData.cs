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
            public int SeanceID { get; set; }
            [Required]
            public string fileType { get; set; }
            [Required]
            public string Path { get; set; }
        }
    }
}