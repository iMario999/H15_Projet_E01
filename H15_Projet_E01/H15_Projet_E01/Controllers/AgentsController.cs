﻿using System;
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
    public class AgentsController : Controller
    {
        private UnitOfWork unitOfWork = new UnitOfWork();

        // GET: Agents
        public ActionResult Index()
        {
            return View(unitOfWork.AgentRepository.GetAgents().ToList());
        }

        // GET: Agents/Details/5
        public ActionResult Details(int? id, int? seanceId)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Agent agent = unitOfWork.AgentRepository.GetAgentByID(id);
            agent.Seances.OrderByDescending(a => a.DateSeance);

            //vue partiel : si une séance séléctionnée, afficher ses notif, si non, afficher toutes les notifs de l'agent
            if (seanceId != null)
            {
                var notifs = unitOfWork.NotificationRepository.GetNotificationsBySeanceId(seanceId).OrderByDescending(n => n.DateNotification).ToList();
                ViewBag.Notifications = notifs;
            }
            else
            {
                var notifs = unitOfWork.NotificationRepository.GetNotificationsByAgentID(id).OrderByDescending(n => n.DateNotification).ToList();
                ViewBag.Notifications = notifs;
            }
            
            if (agent == null)
            {
                return HttpNotFound();
            }
            return View(agent);
        }

        // GET: Agents/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Agents/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "AgentID,Nom,Telephone,Prenom,Email,Agence,Commentaire")] Agent agent)
        {
            if (ModelState.IsValid)
            {
                unitOfWork.AgentRepository.InsertAgent(agent);
                unitOfWork.Save();
                return RedirectToAction("Index");
            }

            return View(agent);
        }

        // GET: Agents/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Agent agent = unitOfWork.AgentRepository.GetAgentByID(id);
            if (agent == null)
            {
                return HttpNotFound();
            }
            return View(agent);
        }

        // POST: Agents/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "AgentID,Nom, Prenom, Telephone, Email, Agence, Commentaire")] Agent agent)
        {
            if (ModelState.IsValid)
            {
                unitOfWork.AgentRepository.UpdateAgent(agent);
                unitOfWork.Save();
                return RedirectToAction("Index");
            }
            return View(agent);
        }

        // GET: Agents/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Agent agent = unitOfWork.AgentRepository.GetAgentByID(id);
            if (agent == null)
            {
                return HttpNotFound();
            }
            return View(agent);
        }

        // POST: Agents/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            unitOfWork.AgentRepository.DeleteAgent(id);
            unitOfWork.Save();
            return RedirectToAction("Index");
        }

        public ActionResult Load(int? id)
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

            ViewBag.Forfait = unitOfWork.ForfaitRepository.GetForfaits();

            ViewBag.Seance = seance;

            string[] tabPrix = new string[4];
            double tps = ((double)seance.Forfait.Prix * 0.05);
            double tvq = ((double)seance.Forfait.Prix * 0.09975);
            double total = (double)seance.Forfait.Prix + tps + tvq;
            tabPrix[0] = seance.Forfait.Prix.ToString("0.00") + "$";
            tabPrix[1] = ((double)seance.Forfait.Prix * 0.05).ToString("0.00") + "$";
            tabPrix[2] = ((double)seance.Forfait.Prix * 0.09975).ToString("0.00") + "$";
            tabPrix[3] = total.ToString("0.00") + "$";

            ViewBag.tabPrix = tabPrix;

            return View("Facture");
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
