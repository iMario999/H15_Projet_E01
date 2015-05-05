using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace H15_Projet_E01.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "La technologie HDR attire l’œil en permettant la réalisation de photos de qualité ayant une luminosité exceptionnelle et un aperçu réaliste et vivant de la propriété.";

            ViewBag.TitleHDR = "QU’EST-CE QUELA PHOTOGRAPHIE HDR?";
            ViewBag.MessageHDR = "Le principe de base est de prendre de trois à neuf photos de la même scène avec un temps d’exposition différent. Ces photos sont par la suite traitées avec un logiciel spécialisé qui dé-termine la meilleure luminosité pour chacun des pixels de la photo. Ce qui assure une qualité d’image et une luminosité exceptionnelle.";

            ViewBag.TitleOffre = "QU’OFFRONS-NOUS?";
            ViewBag.MessageOffre = "Guy Duval et ses partenaires offrent un service professionnel avec garantie de satisfaction. Une gamme de produits est disponible pour la promotion de vos propriétés à des tarifs compétitifs et cet investissement est déductible d’impôt pour vous.";

            return View();
        }
    }
}