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
    
    public partial class Seance
    {
        public Seance()
        {
            this.Notifications = new HashSet<Notification>();
        }
    
        public int SeanceID { get; set; }
        public Nullable<System.DateTime> DateSeance { get; set; }
        public string Adresse { get; set; }
        public string Ville { get; set; }
        public string Telephone { get; set; }
        public string Commentaire { get; set; }
        public int AgentID { get; set; }
        public Nullable<System.DateTime> HeureSeance { get; set; }
        public Nullable<int> PhotographeID { get; set; }
        public int StatutID { get; set; }
        public int ForfaitID { get; set; }
        public Nullable<int> NbPhotosPrise { get; set; }
        public Nullable<System.DateTime> DateFacturation { get; set; }
    
        public virtual Agent Agent { get; set; }
        public virtual Facture Facture { get; set; }
        public virtual Forfait Forfait { get; set; }
        public virtual ICollection<Notification> Notifications { get; set; }
        public virtual Photographe Photographe { get; set; }
        public virtual Statut Statut { get; set; }
    }
}
