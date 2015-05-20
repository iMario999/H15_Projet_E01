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
    public class PhotosController : Controller
    {
        private UnitOfWork unitOfWork = new UnitOfWork();

        // GET: Photos
        public ActionResult Index()
        {
            return View(unitOfWork.PhotoRepository.GetPhotosWithSeance().ToList());
        }

        // GET: Photos/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
           
            Photo photo = unitOfWork.PhotoRepository.GetPhotoByID(id);
            if (photo == null)
            {
                return HttpNotFound();
            }
            return View(photo);
        }

        // GET: Photos/Create
        public ActionResult Create()
        {
            ViewBag.SeanceID = new SelectList(unitOfWork.SeanceRepository.GetSeances(), "SeanceID", "Adresse");
            return View();
        }

        // POST: Photos/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "PhotoID,SeanceID,fileType,Path")] Photo photo, HttpPostedFileBase image)
        {
            //Check Directory if exist or else create
            string subPath = "Images/" + photo.SeanceID;
            bool exists = System.IO.Directory.Exists(Server.MapPath(subPath));
            if (!exists)
                System.IO.Directory.CreateDirectory(Server.MapPath(subPath));

            //Add Path to Photo
            photo.Path = "Photos/" + subPath + "/" + image.FileName;

            //Add format type to Photo
            string[] format = image.FileName.Split('.');
            photo.fileType = format[format.Length - 1];

            if (ModelState.IsValid)
            { 
                //Copy the picture into the folder
                image.SaveAs(Server.MapPath(subPath) +"\\"+ image.FileName);
                unitOfWork.PhotoRepository.InsertPhoto(photo);
                unitOfWork.Save();
                return RedirectToAction("Index", "Seances");
            }

            ViewBag.SeanceID = new SelectList(unitOfWork.SeanceRepository.GetSeances(), "SeanceID", "Adresse", photo.SeanceID);
            return View(photo);
        }

        // GET: Photos/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Photo photo = unitOfWork.PhotoRepository.GetPhotoByID(id);
            if (photo == null)
            {
                return HttpNotFound();
            }
            ViewBag.SeanceID = new SelectList(unitOfWork.SeanceRepository.GetSeances(), "SeanceID", "Adresse", photo.SeanceID);
            return View(photo);
        }

        // POST: Photos/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "PhotoID,SeanceID,fileType,Path")] Photo photo)
        {
            if (ModelState.IsValid)
            {
                unitOfWork.PhotoRepository.UpdatePhoto(photo);
                unitOfWork.Save();
                return RedirectToAction("Index");
            }
            ViewBag.SeanceID = new SelectList(unitOfWork.SeanceRepository.GetSeances(), "SeanceID", "Adresse", photo.SeanceID);
            return View(photo);
        }

        // GET: Photos/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Photo photo = unitOfWork.PhotoRepository.GetPhotoByID(id);
            if (photo == null)
            {
                return HttpNotFound();
            }
            return View(photo);
        }

        // POST: Photos/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            unitOfWork.PhotoRepository.DeletePhoto(id);
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
