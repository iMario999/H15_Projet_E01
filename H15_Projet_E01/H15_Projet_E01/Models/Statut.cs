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
    
    public partial class Statut
    {
        public Statut()
        {
            this.Notifications = new HashSet<Notification>();
        }
    
        public int StatutID { get; set; }
        public string Nom { get; set; }
    
        public virtual ICollection<Notification> Notifications { get; set; }
    }
}
