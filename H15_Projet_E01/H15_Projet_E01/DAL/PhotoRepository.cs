using H15_Projet_E01.Models;
using System;
using System.Collections.Generic;
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
        public void DeletePhotosBySeanceID(int? id)
        {
            foreach (var item in GetPhotos())
            {
                if (item.SeanceID == id)
                    DeletePhoto(id);
            }
        }

       /* public byte[] GetImage(int id)
        {
            Photo photo = Get(filter:s => s.PhotoID == id).Single();
            if (photo != null)  
            {
                if(photo.Path == null)
                {//photo defaut
                    Image img = Image.FromFile(HttpContext.Current.Server.MapPath("~/Images/defaut.jpg"));
                    MemoryStream ms = new System.IO.MemoryStream();
                    img.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                    student.Photo = ms.ToArray();
                } 
               // return File(student.Photo, "image/jpg"); 
                 return photo.Path; 
            }
             return null;
           }
        }*/
    }
}