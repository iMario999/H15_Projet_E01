using H15_Projet_E01.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace H15_Projet_E01.DAL
{
    public class NotificationRepository: GenericRepository<Notification>
    {
        public NotificationRepository(H15_PROJET_E01Entities3 context) : base(context) { }
        public IEnumerable<Notification> GetNotifications()
        {
            return Get();
        }
        public Notification GetNotificationByID(int? id)
        {
            return GetByID(id);
        }
        public IEnumerable<Notification> GetNotificationsBySeanceId(int? id)
        {
            return Get().Where(n=>n.SeanceID == id);
        }
        public IEnumerable<Notification> GetNotificationsByAgentID(int? id)
        {
            return Get().Where(n => n.Seance.AgentID == id);
        }
        public void InsertNotification(Notification notification)
        {
            Insert(notification);
        }
        public void UpdateNotification(Notification notification)
        {
            Update(notification);
        }
        public void DeleteNotification(int? id)
        {
            Delete(id);
        }
    }
}