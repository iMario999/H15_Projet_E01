//------------------------------------------------------------------------------
// <auto-generated>
//     Ce code a été généré à partir d'un modèle.
//
//     Des modifications manuelles apportées à ce fichier peuvent conduire à un comportement inattendu de votre application.
//     Les modifications manuelles apportées à ce fichier sont remplacées si le code est régénéré.
// </auto-generated>
//------------------------------------------------------------------------------

namespace H15_Projet_E01.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Photo
    {
        public int PhotoID { get; set; }
        public int SeanceID { get; set; }
        public string fileType { get; set; }
        public string Path { get; set; }
    
        public virtual Seance Seance { get; set; }
    }
}
