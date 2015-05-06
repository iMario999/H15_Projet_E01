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

namespace H15_Projet_E01.Controllers
{
    public class SeancesController : Controller
    {
        private PhotoDuvalEntities db = new PhotoDuvalEntities();
        private UnitOfWork unitOfWork = new UnitOfWork();
        // GET: Seances
        public ActionResult Index(bool? enAttente)
        {
            var seances = db.Seances.Include(s => s.Agent);
            //var seances = unitOfWork.SeanceRepository.GetSeances();
            if (enAttente == null)
            {
                //do nothing
            }
            else if (enAttente == false)
            {
                //seances = unitOfWork.SeanceRepository.getSeanceEnAttente(false);
                seances = from seance in db.Seances.Include(s => s.Agent)
                          where seance.DateSeance != null
                          select seance;
            }
            else
            {
                //seances = unitOfWork.SeanceRepository.getSeanceEnAttente(true);
                seances = from seance in db.Seances.Include(s => s.Agent)
                          where seance.DateSeance == null
                          select seance;
            }

            return View(seances.ToList());
        }

        // GET: Seances/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Seance seance = db.Seances.Find(id);
            //Seance seance = unitOfWork.SeanceRepository.GetSeanceByID(id.value);
            if (seance == null)
            {
                return HttpNotFound();
            }
            return View(seance);
        }

        // GET: Seances/Create
        public ActionResult Create()
        {
            ViewBag.AgentID = new SelectList(db.Agents /*unitOfWork.SeanceRepository.GetSeances()*/, "AgentID", "Nom");
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
                db.Seances.Add(seance);
                db.SaveChanges();
                //unitOfWork.SeanceRepository.InsertSeance(seance);
                //unitOfWork.Save();
                return RedirectToAction("Index");
            }

            ViewBag.AgentID = new SelectList(db.Agents, "AgentID", "Nom", seance.AgentID);
            return View(seance);
        }

        // GET: Seances/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Seance seance = db.Seances.Find(id);
            //Seance seance = unitOfWork.SeanceRepository.GetSeanceByID(id.value);
            if (seance == null)
            {
                return HttpNotFound();
            }
            ViewBag.AgentID = new SelectList(db.Agents /*unitOfWork.SeanceRepository.GetSeances()*/, "AgentID", "Nom", seance.AgentID);
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
                db.Entry(seance).State = EntityState.Modified;
                db.SaveChanges();
                //unitOfWork.SeanceRepository.UpdateSeance(seance);
                //unitOfWork.Save();
                return RedirectToAction("Index");
            }
            ViewBag.AgentID = new SelectList(db.Agents /*unitOfWork.SeanceRepository.GetSeances()*/, "AgentID", "Nom", seance.AgentID);
            return View(seance);
        }

        // GET: Seances/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Seance seance = db.Seances.Find(id);

            //Seance seance = unitOfWork.SeanceRepository.GetSeanceByID(id.value);
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
            Seance seance = db.Seances.Find(id);
            db.Seances.Remove(seance);
            db.SaveChanges();

            //unitOfWork.SeanceRepository.DeleteSeance(id);
            //unitOfWork.SeanceRepository.Save();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();

                //unitOfWork.SeanceRepository.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
