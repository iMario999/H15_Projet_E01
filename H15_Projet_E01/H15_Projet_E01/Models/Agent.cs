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
    
    public partial class Agent
    {
        public Agent()
        {
            this.Seance = new HashSet<Seance>();
        }
    
        public int AgentID { get; set; }
        public string Nom { get; set; }
        public string Telephone { get; set; }
        public string Prenom { get; set; }
        public string Email { get; set; }
        public string Agence { get; set; }
        public string Commentaire { get; set; }
    
        public virtual ICollection<Seance> Seance { get; set; }
    }
}
