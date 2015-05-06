using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace H15_Projet_E01.Models
{
    [MetadataType(typeof(AgentMetaData))]
    public partial class Agent
    {
        internal sealed class AgentMetaData
        {
            public int AgentID { get; set; }
            [Required]
            public string Nom { get; set; }
            [Required]
            [RegularExpression("\\(\\d{3}\\)-?\\d{3}-\\d{4}", ErrorMessage = "Le numéro de téléphone doit être être sous le format (514)-123-4567 ou (514)789-0000")]
            public string Telephone { get; set; }
            [Required]
            public string Prenom { get; set; }
            [Required]
            [EmailAddress]
            public string Email { get; set; }
            [Required]
            public string Agence { get; set; }
            public string Commentaire { get; set; }
        }
    }
}