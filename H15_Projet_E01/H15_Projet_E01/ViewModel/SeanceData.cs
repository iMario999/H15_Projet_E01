using H15_Projet_E01.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace H15_Projet_E01.ViewModel
{
    public class SeanceData
    {
        public Seance Seance { get; set; }
        public Agent Agent { get; set; }
        public Photographe Photographe { get; set; }
        public Forfait Forfait { get; set; }
        public IEnumerable<Photo> Photos { get; set; }
    }
}