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
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using H15_Projet_E01.ViewModel;

namespace H15_Projet_E01.Controllers
{
    public class SeancesController : Controller
    {
        
        private UnitOfWork unitOfWork = new UnitOfWork();

        private void PopulateAgentsDrop(object selectedType = null)
        {
            var TypeQuery = unitOfWork.AgentRepository.GetAgents();
            ViewBag.AgentID = new SelectList(TypeQuery, "AgentID", "Nom",selectedType);
            
        }

        private void PopulateForfaitsDrop(object selectedType = null)
        {
            var TypeQuery = unitOfWork.ForfaitRepository.GetForfaits();
            ViewBag.ForfaitID = new SelectList(TypeQuery, "ForfaitID", "Nom", selectedType);
        }

        // GET: Seances
        public ActionResult Index(string enAttente, string sortOrder, int? page, string searchString, string currentFilter)
        {
           
            var seances = unitOfWork.SeanceRepository.GetSeances();

            ViewBag.CurrentAttente = enAttente;
            ViewBag.AttenteShowParm = String.IsNullOrEmpty(enAttente) ? "All" : "";

            if (enAttente == "No")
                seances = unitOfWork.SeanceRepository.getSeanceEnAttente(false);      
            else if (enAttente == "Yes")
                seances = unitOfWork.SeanceRepository.getSeanceEnAttente(true);      

            if (searchString != null)
                page = 1;
            else
                searchString = currentFilter;

            if (!String.IsNullOrEmpty(searchString))
            {
                List<Seance> lstS = new List<Seance>();
                foreach (Seance s in seances)
                {
                    if (s.Photographe != null)
                        lstS.Add(s);
                }
                seances = lstS;
                seances = from Seance seance in seances
                          where (seance.Photographe.Nom.ToUpper().Contains(searchString.ToUpper()))
                          select seance;
            }

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

            ViewBag.CurrentFilter = searchString;
            ViewBag.CurrentSort = sortOrder;
            ViewBag.currentAttente = enAttente;

            int pageSize = 5;
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

            var viewModel = new SeanceData();
            Seance seance = unitOfWork.SeanceRepository.GetSeanceByID(id);

            if (seance == null)
            {
                return HttpNotFound();
            }            
            
            viewModel.Seance = seance;
            viewModel.Agent = unitOfWork.AgentRepository.GetAgentByID(seance.AgentID);
            viewModel.Forfait = unitOfWork.ForfaitRepository.GetForfaitByID(seance.ForfaitID);

            if (seance.PhotographeID != null)
            {
                viewModel.Photographe = unitOfWork.PhotographeRepository.GetPhotographeByID(seance.PhotographeID);
                viewModel.Photos = unitOfWork.PhotoRepository.GetPhotosBySeanceID(seance.SeanceID);
            }

            return View(viewModel);
        }

        // GET: Seances/Create
        public ActionResult Create()
        {
           PopulateAgentsDrop();
           PopulateForfaitsDrop();
            return View();
        }

        // POST: Seances/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SeanceID,DateSeance,Adresse,Ville,Telephone,Commentaire,AgentID,FactureID,HeureSeance,ForfaitID,PhotographeID")] Seance seance)
        {
            if (ModelState.IsValid)
            {
                seance.StatutID = 1; 
                unitOfWork.SeanceRepository.InsertSeance(seance);
                unitOfWork.Save();
                return RedirectToAction("Index");
            }

            PopulateAgentsDrop(seance.AgentID);
            PopulateForfaitsDrop();
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
            PopulateAgentsDrop(seance.AgentID);
            ViewBag.AgentID = new SelectList(unitOfWork.AgentRepository.GetAgents(), "AgentID", "Nom", seance.AgentID);
            ViewBag.PhotographeID = new SelectList(unitOfWork.PhotographeRepository.GetPhotographes(), "PhotographeID", "NomComplet", seance.PhotographeID);
            PopulateForfaitsDrop(seance.ForfaitID);
            return View(seance);
        }

        // POST: Seances/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "SeanceID,DateSeance,Adresse,Ville,Telephone,Commentaire,AgentID,FactureID,HeureSeance,ForfaitID, StatutID,PhotographeID, RowVersion")] Seance seance)
        {
            /*
            if (ModelState.IsValid)
            {
                unitOfWork.SeanceRepository.UpdateSeance(seance);
                unitOfWork.Save();
                return RedirectToAction("Index");
            }
            return View(seance);
            */

            Seance seanceModif = unitOfWork.SeanceRepository.GetSeanceByID(seance.SeanceID);
            if (TryUpdateModel(seanceModif, new string[] { "SeanceID", "DateSeance", "Adresse", "Ville", "Telephone", "Commentaire", "AgentID", "FactureID", "HeureSeance", "ForfaitID", "PhotographeID", "StatutID", "RowVersion" }))
            {
                unitOfWork.SeanceRepository.UpdateSeance(seanceModif);
                try{
                    unitOfWork.Save();
                    return RedirectToAction("Index");
                }
                catch (DbEntityValidationException ex)
                {
                    RecupereErreurValidation(ex);
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    var entry = ex.Entries.Single();
                    RecupererErreurUpdate(ex);
                }
                catch (DbUpdateException ex)
                {
                   // RecupereErreurValidation(ex);
                    //erreur lors de la modification de la BD
                    ModelState.AddModelError("DbUpdateException",ex.Message);
                         
                }
                     
            }
            PopulateAgentsDrop();
            PopulateForfaitsDrop();
            ViewBag.PhotographeID = new SelectList(unitOfWork.PhotographeRepository.GetPhotographes(), "PhotographeID", "NomComplet", seance.PhotographeID);
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
        private void RecupereErreurValidation(DbEntityValidationException ex)
        {
            foreach (var erreur in ex.EntityValidationErrors)
            {
                //var message = erreur.Entry.Entity.GetType();
                foreach (var validationErreur in erreur.ValidationErrors)
                {
                    ModelState.AddModelError("", validationErreur.ErrorMessage);
                }
            }

        }

        //Pour les messages en cas d'accès concurrents 
        private void RecupererErreurUpdate(DbUpdateConcurrencyException ex)
        {
            ModelState.AddModelError("", ex.Message);
            var entry = ex.Entries.Single();
            var seanceValues = (Seance)entry.Entity;
            var databaseValues = (Seance)entry.GetDatabaseValues().ToObject();
            if (databaseValues == null)
            {
                ModelState.AddModelError(string.Empty, "Unable to save changes. The department was deleted by another user.");
            }
            else
            {

                if (databaseValues.DateSeance != seanceValues.DateSeance)
                    ModelState.AddModelError("DateSeance", "Current value: " + databaseValues.DateSeance);
                if (databaseValues.HeureSeance != seanceValues.HeureSeance)
                    ModelState.AddModelError("HeureSeance", "Current value: " + databaseValues.HeureSeance);
                if (databaseValues.Adresse != seanceValues.Adresse)
                    ModelState.AddModelError("Adresse", "Current value: " + databaseValues.Adresse);
                if (databaseValues.Ville != seanceValues.Ville)
                    ModelState.AddModelError("Ville", "Current value: " + databaseValues.Ville);
                if (databaseValues.Telephone != seanceValues.Telephone)
                    ModelState.AddModelError("Telephone", "Current value: " + databaseValues.Telephone);
                if (databaseValues.Commentaire != seanceValues.Commentaire)
                    ModelState.AddModelError("Commentaire", "Current value: " + databaseValues.Commentaire);
                if (databaseValues.Forfait != seanceValues.Forfait)
                    ModelState.AddModelError("Forfait", "Current value: " + databaseValues.Forfait.Nom);
                if (databaseValues.Agent != seanceValues.Agent)
                    ModelState.AddModelError("Agent", "Current value: " + databaseValues.Agent.Nom);
                if (databaseValues.Statut != seanceValues.Statut)
                    ModelState.AddModelError("Statut", "Current value: " + databaseValues.Statut.Nom);
            }
        }
    }
}
