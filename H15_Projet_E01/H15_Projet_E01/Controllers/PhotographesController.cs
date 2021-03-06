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
    public class PhotographesController : Controller
    {
        private UnitOfWork unitOfWork = new UnitOfWork();

        // GET: Photographes
        public ActionResult Index()
        {
            return View(unitOfWork.PhotographeRepository.GetPhotographes());
        }

        // GET: Photographes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Photographe photographe = unitOfWork.PhotographeRepository.GetPhotographeByID(id);
            if (photographe == null)
            {
                return HttpNotFound();
            }
            return View(photographe);
        }

        // GET: Photographes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Photographes/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "PhotographeID,Nom,Prenom,Telephone,email")] Photographe photographe)
        {
            if (ModelState.IsValid)
            {
                unitOfWork.PhotographeRepository.Insert(photographe);
                unitOfWork.Save();
                return RedirectToAction("Index");
            }

            return View(photographe);
        }

        // GET: Photographes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Photographe photographe = unitOfWork.PhotographeRepository.GetPhotographeByID(id);
            if (photographe == null)
            {
                return HttpNotFound();
            }
            return View(photographe);
        }

        // POST: Photographes/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "PhotographeID,Nom,Prenom,Telephone,email")] Photographe photographe)
        {
            if (ModelState.IsValid)
            {
                unitOfWork.PhotographeRepository.Update(photographe);
                unitOfWork.Save();
                return RedirectToAction("Index");
            }
            return View(photographe);
        }

        // GET: Photographes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Photographe photographe = unitOfWork.PhotographeRepository.GetPhotographeByID(id);
            if (photographe == null)
            {
                return HttpNotFound();
            }
            return View(photographe);
        }

        // POST: Photographes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Photographe photographe = unitOfWork.PhotographeRepository.GetPhotographeByID(id);
            unitOfWork.PhotographeRepository.Delete(photographe);
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

