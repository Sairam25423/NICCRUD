using NICCRUD.App_Start;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;
using static NICCRUD.Naveen_Task.Dropdowns;

namespace NICCRUD.Naveen_Task
{
    public partial class Dropdowns : System.Web.UI.Page
    {
        DataAccessLayer objDL = new DataAccessLayer();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static List<State> GetStates()
        {
            Dropdowns DFw = new Dropdowns();
            List<State> states = new List<State>();
            string SP = "Sp_State";
            DataSet Ds = DFw.objDL.RetrivedData(SP);
            if (Ds.Tables.Count > 0)
            {
                DataTable dt = Ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    states.Add(new State
                    {
                        StateId = Convert.ToInt32(row["State_Id"]),
                        StateName = row["State_Name"].ToString()
                    });
                }
            }
            return new List<State>();
        }

        [WebMethod]
        public static List<Mandal> GetMandals(int stateId)
        {
            Dropdowns DFw = new Dropdowns();
            List<Mandal> mandals = new List<Mandal>();
            string SP = "Sp_Mandal"; string[] ParameterName = { "@State_Id" }; string[] ParameterValue = { stateId.ToString() };
            DataSet Ds = DFw.objDL.RetrivedData(SP, ParameterName, ParameterValue);
            if (Ds.Tables.Count > 0)
            {
                DataTable dt = Ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    mandals.Add(new Mandal
                    {
                        MandalId = Convert.ToInt32(row["Mandal_Id"]),
                        MandalName = row["Mandal_Name"].ToString()
                    });
                }
            }
            return new List<Mandal>();
        }

        public class State
        {
            public int StateId { get; set; }
            public string StateName { get; set; }
        }

        public class Mandal
        {
            public int MandalId { get; set; }
            public string MandalName { get; set; }
        }
    }
}