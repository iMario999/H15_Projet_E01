﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class H15_PROJET_E01Entities1 : DbContext
    {
        public H15_PROJET_E01Entities1()
            : base("name=H15_PROJET_E01Entities1")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Agent> Agents { get; set; }
        public virtual DbSet<Facture> Factures { get; set; }
        public virtual DbSet<Forfait> Forfaits { get; set; }
        public virtual DbSet<Notification> Notifications { get; set; }
        public virtual DbSet<Photographe> Photographes { get; set; }
        public virtual DbSet<Seance> Seances { get; set; }
        public virtual DbSet<Statut> Statuts { get; set; }
        public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
    }
}