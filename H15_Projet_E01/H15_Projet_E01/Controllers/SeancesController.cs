using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using H15_Projet_E01.Models;
using H15_Projet_E01.DAL;
using PagedList;

namespace H15_Projet_E01.Controllers
{
    public class SeancesController : Controller
    {
        
        private UnitOfWork unitOfWork = new UnitOfWork();

        private void PopulateAgentsDrop(object selectedType = null)
        {
            var TypeQuery = unitOfWork.AgentRepository.GetAgents();
            ViewBag.AgentID = new SelectList(TypeQuery, "AgentID", "Nom", selectedType);
        }


        // GET: Seances
        public ActionResult Index(string enAttente, string sortOrder, int? page, string searchString, string currentFilter)
        {
           
            var seances = unitOfWork.SeanceRepository.GetSeances();

            ViewBag.CurrentAttente = enAttente;
            ViewBag.AttenteShowParm = String.IsNullOrEmpty(enAttente) ? "All" : "";

            if (enAttente == "No")
            {
                seances = unitOfWork.SeanceRepository.getSeanceEnAttente(false);        
            }
            else if (enAttente == "Yes")
            {
                seances = unitOfWork.SeanceRepository.getSeanceEnAttente(true);            
            }

            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            if (!String.IsNullOrEmpty(searchString))
            {

                seances = from Seance seance in unitOfWork.SeanceRepository.GetSeances()
                          where (seance.Agent.Nom.ToUpper() == searchString.ToUpper())
                          select seance;
            }

            ViewBag.CurrentFilter = searchString;

            ViewBag.CurrentSort = sortOrder;
            ViewBag.DateSortParm = String.IsNullOrEmpty(sortOrder) ? "Date" : "";
            ViewBag.DateSortParm = sortOrder == "Date" ? "date_desc" : "Date";
            ViewBag.AgentSortParm = sortOrder == "Agent" ? "agent_desc" : "Agent";

            switch (sortOrder)
            {
                case "Agent":
                    seances = seances.OrderBy(s => s.Agent.Nom);
                    break;
                case "agent_desc":
                    seances = seances.OrderByDescending(s => s.Agent.Nom);
                    break;
                case "date_desc":
                    seances = seances.OrderByDescending(s => s.DateSeance);
                    break;
                case "Date":
                default:
                    seances = seances.OrderBy(s => s.DateSeance);
                    break;
            }

            int pageSize = 3;
            int pageNumber = page ?? 1;
            return View(seances.ToPagedList(pageNumber, pageSize));
        }

        // GET: Seances/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            
            Seance seance = unitOfWork.SeanceRepository.GetSeanceByID(id);
            if (seance == null)
            {
                return HttpNotFound();
            }
            return View(seance);
        }

        // GET: Seances/Create
        public ActionResult Create()
        {
            //ViewBag.AgentID = new SelectList( unitOfWork.SeanceRepository.get(), "AgentID", "Nom");
           PopulateAgentsDrop();
            return View();
        }

        // POST: Seances/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SeanceID,DateSeance,Adresse,Ville,Telephone,Commentaire,AgentID,FactureID,HeureSeance")] Seance seance)
        {
            if (ModelState.IsValid)
            {
              
                unitOfWork.SeanceRepository.InsertSeance(seance);
                unitOfWork.Save();
                return RedirectToAction("Index");
            }

            PopulateAgentsDrop();
            return View(seance);
        }

        // GET: Seances/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
           
           Seance seance = unitOfWork.SeanceRepository.GetSeanceByID(id);
            if (seance == null)
            {
                return HttpNotFound();
            }
            PopulateAgentsDrop();
            return View(seance);
        }

        // POST: Seances/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "SeanceID,DateSeance,Adresse,Ville,Telephone,Commentaire,AgentID,FactureID,HeureSeance")] Seance seance)
        {
            if (ModelState.IsValid)
            {
               
                unitOfWork.SeanceRepository.UpdateSeance(seance);
                unitOfWork.Save();
                return RedirectToAction("Index");
            }
            PopulateAgentsDrop();
            return View(seance);
        }

        // GET: Seances/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
          

            Seance seance = unitOfWork.SeanceRepository.GetSeanceByID(id);
            if (seance == null)
            {
                return HttpNotFound();
            }
            return View(seance);
        }

        // POST: Seances/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {

            unitOfWork.SeanceRepository.DeleteSeance(id);
            unitOfWork.Save();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {             
                unitOfWork.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
