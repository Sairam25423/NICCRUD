using NICCRUD.App_Start;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;

namespace NICCRUD.Naveen_Task
{
    public partial class DpStateandCity : System.Web.UI.Page
    {
        DataAccessLayer objDL = new DataAccessLayer();
        BussinessLogicLayer objBL = new BussinessLogicLayer();
        #region PageLoad
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindState();
            }
        }
        #endregion
        #region State
        public void BindState()
        {
            objBL.FillDropdown(DpState, "Sp_State", "State_Name", "State_Id", "---Select State---", "0");
        }
        #endregion
        [WebMethod]
        public static List<Mandal> GetMandals(string stateId)
        {
            DpStateandCity DFw = new DpStateandCity();
            List<Mandal> mandals = new List<Mandal>();
            string SP = "Sp_Mandal"; string[] ParameterName = { "@State_Id" }; string[] ParameterValue = { stateId };
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
            return mandals;
        }
        public class Mandal
        {
            public int MandalId { get; set; }
            public string MandalName { get; set; }
        }
    }
}