﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using H15_Projet_E01.Models;

namespace H15_Projet_E01.DAL
{
    public class UnitOfWork: IUnitOfWork, IDisposable
    {
        private PhotoDuvalEntities context = new PhotoDuvalEntities();

        private SeanceRepository seanceRepository;
        private AgentRepository agentRepository;

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