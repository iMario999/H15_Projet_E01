using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using H15_Projet_E01.Models;

namespace H15_Projet_E01.DAL
{
    public class AgentRepository: GenericRepository<Agent>
    {
        public AgentRepository(H15_PROJET_E01Entities3 context) : base(context) { }
        public IEnumerable<Agent> GetAgents()
        {
            return Get();
        }
        public Agent GetAgentByID(int? id)
        {
            return GetByID(id);
        }
        public void InsertAgent(Agent agent)
        {
            Insert(agent);
        }
        public void UpdateAgent(Agent agent)
        {
            Update(agent);
        }
        public void DeleteAgent(int? id)
        {
            Delete(id);
        }
    }
}