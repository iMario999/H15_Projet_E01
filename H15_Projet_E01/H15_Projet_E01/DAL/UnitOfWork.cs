using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using H15_Projet_E01.Models;

namespace H15_Projet_E01.DAL
{
    public class UnitOfWork: IUnitOfWork, IDisposable
    {
        private H15_PROJET_E01Entities3 context = new H15_PROJET_E01Entities3();

        private SeanceRepository seanceRepository;
        private AgentRepository agentRepository;
        private ForfaitRepository forfaitRepository;
        private NotificationRepository notificationRepository;

        //======================================================================================
        public SeanceRepository SeanceRepository
        {
            get
            {
                if (this.seanceRepository == null)
                {

                    this.seanceRepository = new SeanceRepository(context);
                }
                return seanceRepository;
            }
        }
        public AgentRepository AgentRepository
        {
            get
            {
                if (this.agentRepository == null)
                {

                    this.agentRepository = new AgentRepository(context);
                }
                return agentRepository;
            }
        }
        public ForfaitRepository ForfaitRepository
        {
            get
            {
                if (this.forfaitRepository == null)
                {

                    this.forfaitRepository = new ForfaitRepository(context);
                }
                return forfaitRepository;
            }
        }
        public NotificationRepository NotificationRepository
        {
            get
            {
                if (this.notificationRepository == null)
                {
                    this.notificationRepository = new NotificationRepository(context);
                }
                return notificationRepository;
            }
        }
        //======================================================================================
        public void Save()
        {
            context.SaveChanges();
        }

        private bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }
            this.disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}