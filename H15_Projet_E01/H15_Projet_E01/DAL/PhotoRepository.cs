using H15_Projet_E01.Models;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;

namespace H15_Projet_E01.DAL
{
    public class PhotoRepository : GenericRepository<Photo>
    {
        public PhotoRepository(H15_PROJET_E01Entities3 context) : base(context) { }
        public IEnumerable<Photo> GetPhotos()
        {
            return Get();
        }
        public IEnumerable<Photo> GetPhotosWithSeance()
        {
            return Get(includeProperties: "Seance");
        }
        public Photo GetPhotoByID(int? id)
        {
            return GetByID(id);
        }
        public void InsertPhoto(Photo photo)
        {
            Insert(photo);
        }
        public void UpdatePhoto(Photo photo)
        {
            Update(photo);
        }
        public void DeletePhoto(int? id)
        {
            Delete(id);
        }
        public IEnumerable<Photo> GetPhotosBySeanceID(int? id)
        {
            return Get().Where(p => p.SeanceID == id);
        }
        public void DeletePhotosBySeanceID(int? id)
        {
            foreach (var item in GetPhotos())
            {
                if (item.SeanceID == id)
                    DeletePhoto(id);
            }
        }
    }
}
