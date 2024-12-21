using System;
using System.Data;
using System.Web.UI.WebControls;

namespace NICCRUD.App_Start
{
    public class BussinessLogicLayer
    {
        DataAccessLayer objDL = new DataAccessLayer();
        #region DropDownFill
        public void FillDropdown(DropDownList Dropdown, string SpName, string TextField, string Valuefield, string DefaultItemText, string DefaultItemValue, string[] ParameterNames = null, string[] ParameterValues = null)
        {
            try
            {
                DataSet Ds = objDL.RetrivedData(SpName, ParameterNames, ParameterValues);
                if (Ds.Tables[0].Rows.Count > 0)
                {
                    Dropdown.DataSource = Ds.Tables[0];
                    Dropdown.DataValueField = Valuefield;
                    Dropdown.DataTextField = TextField;
                    Dropdown.DataBind();
                    Dropdown.Items.Insert(0, new ListItem(DefaultItemText, DefaultItemValue));
                }
            }
            catch (Exception Ex)
            {
                Ex = new Exception("Exception Error");
            }
        }
        #endregion
    }
}