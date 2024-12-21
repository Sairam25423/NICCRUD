using NICCRUD.App_Start;
using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Web;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.UI;
using iText.Layout;
using iText.Kernel.Pdf;
using iText.Layout.Element;
using iText.IO.Image;
using iText.Kernel.Font;
using iText.IO.Font.Constants;
using Image = iText.Layout.Element.Image;
using PdfSharp.Pdf;
using PdfSharp.Drawing;
using iText.Kernel.Pdf.Canvas;
using iText.Kernel.Geom;
using iText.Kernel.Colors;

namespace NICCRUD.Naveen_Task
{
    public partial class Registration : System.Web.UI.Page
    {
        DataAccessLayer objDL = new DataAccessLayer();
        BussinessLogicLayer objBL = new BussinessLogicLayer();
        #region Pageload
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillQualification(); FillState(); BindGridData();
            }
        }
        #endregion
        #region Qualification
        public void FillQualification()
        {
            objBL.FillDropdown(DpQualification, "Sp_Qualification", "Qualification_Name", "Qualification_Id", "---Select Qualification---", "0");
        }
        #endregion
        #region State
        public void FillState()
        {
            objBL.FillDropdown(DpState, "Sp_State", "State_Name", "State_Id", "---Select State---", "0");
        }
        #endregion
        #region StateSelectedIndex
        protected void DpState_SelectedIndexChanged(object sender, EventArgs e)
        {
            DpMandal.SelectedIndex = -1;
            if (DpState.SelectedIndex > 0)
            {
                string[] ParameterName = { "@State_Id" }; string[] ParameterValue = { DpState.SelectedValue };
                objBL.FillDropdown(DpMandal, "Sp_Mandal", "Mandal_Name", "Mandal_Id", "---Select Mandal---", "0", ParameterName, ParameterValue);
            }
            else { DpState.SelectedIndex = DpMandal.SelectedIndex = -1; }
        }
        #endregion
        #region BtnSubmit
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!(string.IsNullOrEmpty(txtStudentid.Text.Trim()) && string.IsNullOrWhiteSpace(txtName.Text.Trim()) && string.IsNullOrEmpty(txtMobile.Text.Trim()) && string.IsNullOrEmpty(txtEmailid.Text.Trim())
                && string.IsNullOrEmpty(txtAddress.Text.Trim())) && DpQualification.SelectedIndex > 0 && DpState.SelectedIndex > 0 && DpMandal.SelectedIndex > 0)
            {
                string BioExtenction = string.Empty; string PhotoExtenction = string.Empty;
                if (FlUpBio.HasFile)
                {
                    BioExtenction = System.IO.Path.GetExtension(FlUpBio.PostedFile.FileName).ToLower();
                    if (BioExtenction == ".pdf")
                    {
                        if (FlUpBio.PostedFile.ContentLength <= 2 * 1024 * 1024)
                        {
                            if (FlUpPhoto.HasFile)
                            {
                                PhotoExtenction = System.IO.Path.GetExtension(FlUpPhoto.PostedFile.FileName).ToLower();
                                if (PhotoExtenction == ".jpg" || PhotoExtenction == ".jpeg" || PhotoExtenction == ".png")
                                {
                                    if (FlUpPhoto.PostedFile.ContentLength <= 100 * 1024)
                                    {
                                        string SP = "Sp_InsertData"; string[] ParameterNames = { "@StudentId", "@Name", "@Mobile_Number", "@Emailid", "@Gender", "@Qualification", "@State", "@Mandal", "@Address" };
                                        string[] ParameterValues = { txtStudentid.Text.Trim(), txtName.Text.Trim(), txtMobile.Text.Trim(), txtEmailid.Text.Trim(), rblGender.SelectedValue, DpQualification.SelectedValue, DpState.SelectedValue, DpMandal.SelectedValue, txtAddress.Text.Trim(), };
                                        string StudentCode = objDL.InsertExecuteScalar(SP, ParameterNames, ParameterValues);
                                        if (!string.IsNullOrEmpty(StudentCode))
                                        {
                                            string SP1 = "Sp_UpdateImage"; string[] PMNames = { "@StudentCode", "@Photo", "@BioData" };
                                            string[] PMValues = { StudentCode, StudentCode + PhotoExtenction, StudentCode + BioExtenction };
                                            bool Result = objDL.InsertData(SP1, PMNames, PMValues);
                                            if (Result == true)
                                            {
                                                string BioRootFolder = HttpContext.Current.Server.MapPath("~/Pdf/");
                                                string BioDestinationPath = System.IO.Path.Combine(BioRootFolder, BioRootFolder + StudentCode + BioExtenction);
                                                FlUpBio.SaveAs(BioDestinationPath);

                                                string PhotoRootFolder = HttpContext.Current.Server.MapPath("~/Images/");
                                                string PhotoDestinationPath = System.IO.Path.Combine(PhotoRootFolder, PhotoRootFolder + StudentCode + PhotoExtenction);
                                                FlUpBio.SaveAs(PhotoDestinationPath);

                                                Clear(); BindGridData();

                                                string script = @"Swal.fire({title: 'Success!',text: 'Registration successful!',icon: 'success',confirmButtonText: 'OK'});";
                                                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                                            }
                                            else
                                            {
                                                string script = @"Swal.fire({title: 'Failure!',text: 'Something went wrong.',icon: 'error',confirmButtonText: 'OK'});";
                                                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                                            }
                                        }
                                        else
                                        {
                                            string script = @"Swal.fire({title: 'Failure!',text: 'Something went wrong.',icon: 'error',confirmButtonText: 'OK'});";
                                            ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                                        }
                                    }
                                    else
                                    {
                                        string script = @"Swal.fire({title: 'Failure!',text: 'File size should not be greater than 100 KB for the photo.',icon: 'error',confirmButtonText: 'OK'});";
                                        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                                    }
                                }
                                else
                                {
                                    string script = @"Swal.fire({title: 'Failure!',text: 'Please upload jpg, jpeg, or png files for the photo.',icon: 'error',confirmButtonText: 'OK'});";
                                    ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                                }
                            }
                            else
                            {
                                string script = @"Swal.fire({title: 'Failure!',text: 'Please upload a photo.',icon: 'error',confirmButtonText: 'OK'});";
                                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                            }
                        }
                        else
                        {
                            string script = @"Swal.fire({title: 'Failure!',text: 'Bio data file size should not be greater than 2 MB.',icon: 'error',confirmButtonText: 'OK'});";
                            ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                        }
                    }
                    else
                    {
                        string script = @"Swal.fire({title: 'Failure!',text: 'Please upload a pdf file for bio data only.',icon: 'error',confirmButtonText: 'OK'});";
                        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                    }
                }
                else
                {
                    string script = @"Swal.fire({title: 'Failure!',text: 'Please upload the bio data.',icon: 'error',confirmButtonText: 'OK'});";
                    ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                }
            }
            else
            {
                string script = @"Swal.fire({title: 'Failure!',text: 'Please fill all the mandatory fields.',icon: 'error',confirmButtonText: 'OK'});";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
            }
        }
        #endregion
        #region ClearMethod
        public void Clear()
        {
            txtAddress.Text = txtEmailid.Text = txtMobile.Text = txtName.Text = txtStudentid.Text = string.Empty;
            rblGender.SelectedIndex = -1; DpQualification.SelectedIndex = -1; DpState.SelectedIndex = -1;
            DpMandal.SelectedIndex = -1;
        }
        #endregion
        #region BindData
        public void BindGridData()
        {
            GVEmployees.DataSource = null;
            GVEmployees.DataBind();

            string SP = "Sp_GetData"; string[] ParameterNames = null; string[] ParameterValues = null;
            DataSet Ds = objDL.RetrivedData(SP, ParameterNames, ParameterValues);
            if (Ds.Tables[0].Rows.Count > 0)
            {
                GVEmployees.DataSource = Ds.Tables[0];
                GVEmployees.DataBind();
                GVEmployees.Visible = true;
            }
        }
        #endregion
        #region RowEdit
        protected void GVEmployees_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GVEmployees.EditIndex = e.NewEditIndex; BindGridData();
        }
        #endregion
        #region RowUpdate
        protected void GVEmployees_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow Row = GVEmployees.Rows[e.RowIndex];
            string StudentName = (Row.FindControl("txtStudentNameEdit") as TextBox).Text.Trim();
            string StudentMobile = (Row.FindControl("txtStudentMobileEdit") as TextBox).Text.Trim();
            string StudentEmailid = (Row.FindControl("txtStudentEmailidEdit") as TextBox).Text.Trim();
            string rblStudentGender = (Row.FindControl("rblStudentGenderEdit") as RadioButtonList).SelectedValue;
            string ddlStudentQualification = (Row.FindControl("DpStudentQualificationEdit") as DropDownList).SelectedValue;
            string ddlStudentState = (Row.FindControl("DpStudentStateEdit") as DropDownList).SelectedValue;
            string ddlStudentMandal = (Row.FindControl("DpStudentMandalEdit") as DropDownList).SelectedValue;
            string StudentAddress = (Row.FindControl("txtStudentAddressEdit") as TextBox).Text.Trim();
            string StudentCode = (Row.FindControl("lblEmpCode") as Label).Text.Trim();
            string StudentId = (Row.FindControl("txtStudentIdEdit") as TextBox).Text.Trim();
            FileUpload FileUpload = Row.FindControl("StudentImage") as FileUpload;
            if (FileUpload.HasFile)
            {
                string PathExtenction = System.IO.Path.GetExtension(FileUpload.FileName).ToLower();
                if (PathExtenction == ".jpg" || PathExtenction == ".jpeg" || PathExtenction == ".png")
                {
                    string RootFolder = HttpContext.Current.Server.MapPath("~/Images/");
                    string DestinationPath = System.IO.Path.Combine(RootFolder, StudentCode + PathExtenction);

                    if (File.Exists(DestinationPath))
                    {
                        File.Delete(DestinationPath);
                    }
                    FileUpload.SaveAs(DestinationPath);
                }
            }
            else { };

            if (!(string.IsNullOrEmpty(StudentId.Trim()) && string.IsNullOrEmpty(StudentName.Trim()) && string.IsNullOrEmpty(StudentMobile.Trim()) && string.IsNullOrEmpty(StudentEmailid.Trim())
                && string.IsNullOrWhiteSpace(StudentAddress.Trim()) && string.IsNullOrWhiteSpace(rblStudentGender) && string.IsNullOrWhiteSpace(ddlStudentQualification)
                && string.IsNullOrWhiteSpace(ddlStudentState) && string.IsNullOrWhiteSpace(ddlStudentMandal)))
            {
                bool ValidFields = ValidationCheck(StudentId, StudentName, StudentMobile, StudentEmailid);
                if (ValidFields == true)
                {
                    string SP = "Sp_UpdateDetails"; string[] ParameterNames = { "@StudentId", "@Name", "@Mobile_Number", "@Emailid", "@Gender", "@Qualification", "@State", "@Mandal", "@Address", "@StudentCode" };
                    string[] ParameterValues = { StudentId, StudentName, StudentMobile, StudentEmailid, rblStudentGender, ddlStudentQualification, ddlStudentState, ddlStudentMandal, StudentAddress, StudentCode };
                    bool Result = objDL.InsertData(SP, ParameterNames, ParameterValues);
                    if (Result == true)
                    {
                        GVEmployees.EditIndex = -1; BindGridData();
                    }
                }
                else
                {
                }
            }
            else { }
        }
        #endregion
        #region RowDelete
        protected void GVEmployees_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string StudentCode = GVEmployees.DataKeys[e.RowIndex].Value.ToString();
            string SP = "Sp_DeleteDetails"; string[] ParameterNames = { "@StudentCode" };
            string[] ParameterValues = { StudentCode };
            bool Result = objDL.InsertData(SP, ParameterNames, ParameterValues);
            if (Result == true)
            {
                BindGridData();
                string script = @"Swal.fire({title: 'Success!',text: 'User deleted successfully.!',icon: 'success',confirmButtonText: 'OK'});";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
            }
            else
            {
                string script = @"Swal.fire({title: 'Failure!',text: 'Something went wrong.',icon: 'error',confirmButtonText: 'OK'});";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
            }
        }
        #endregion
        #region RowDataBound
        protected void GVEmployees_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList DpQualification = e.Row.FindControl("DpStudentQualificationEdit") as DropDownList;
                DropDownList DpState = e.Row.FindControl("DpStudentStateEdit") as DropDownList;
                DropDownList DpMandal = e.Row.FindControl("DpStudentMandalEdit") as DropDownList;
                RadioButtonList RbGender = e.Row.FindControl("rblStudentGenderEdit") as RadioButtonList;
                if (DpQualification != null)
                {
                    objBL.FillDropdown(DpQualification, "Sp_Qualification", "Qualification_Name", "Qualification_Id", "---Select Qualification---", "0");

                    string CurrentDepartment = DataBinder.Eval(e.Row.DataItem, "Qualification").ToString();
                    DpQualification.SelectedValue = CurrentDepartment;
                }
                if (DpState != null)
                {
                    objBL.FillDropdown(DpState, "Sp_State", "State_Name", "State_Id", "---Select State---", "0");

                    string CurrentState = DataBinder.Eval(e.Row.DataItem, "State").ToString();
                    DpState.SelectedValue = CurrentState;
                }
                if (DpMandal != null)
                {
                    string[] ParameterName = { "@State_Id" }; string[] ParameterValue = { DpState.SelectedValue };
                    objBL.FillDropdown(DpMandal, "Sp_Mandal", "Mandal_Name", "Mandal_Id", "---Select Mandal---", "0", ParameterName, ParameterValue);

                    string CurrentMandal = DataBinder.Eval(e.Row.DataItem, "Mandal").ToString();
                    DpMandal.SelectedValue = CurrentMandal;
                }
                if (RbGender != null)
                {
                    string CurrentGender = DataBinder.Eval(e.Row.DataItem, "Gender").ToString();
                    RbGender.SelectedValue = CurrentGender;
                }
            }
        }
        #endregion
        #region RowCancel
        protected void GVEmployees_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GVEmployees.EditIndex = -1; BindGridData();
        }
        #endregion
        #region Pagination
        protected void GVEmployees_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GVEmployees.PageIndex = e.NewPageIndex; BindGridData();
        }
        #endregion
        #region Validations Check
        public bool ValidationCheck(string StudentId, string StudentName, string StudentMobile, string StudentEmail)
        {
            string IdPattern = @"^\d+$";
            string NamePattern = @"^[a-zA-Z\s]{3,}$";
            string MobilePattren = @"^[6-9]\d{9}$";
            string EmailPattren = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            bool Validation = true;
            string validationMessage = string.Empty;
            if (!Regex.IsMatch(StudentId, IdPattern))
            {
                Validation = false; validationMessage = "Invalid id format.";
            }
            else if (!Regex.IsMatch(StudentName, NamePattern))
            {
                Validation = false; validationMessage = "Invalid name format.";
            }
            else if (!Regex.IsMatch(StudentMobile, MobilePattren))
            {
                Validation = false;
                validationMessage = "Invalid mobile number format.";
            }
            else if (!Regex.IsMatch(StudentEmail, EmailPattren))
            {
                Validation = false; validationMessage = "Invalid email format.";
            }
            if (!Validation)
            {
                string script = $@" Swal.fire({{ title: 'Validation Error', text: '{validationMessage}', icon: 'error', confirmButtonText: 'OK'}});";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
            }
            return Validation;
        }
        #endregion
        #region RowCommand
        protected void GVEmployees_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewPDF")
            {
                string id = string.Empty;
                Control ctl = (Control)e.CommandSource;
                GridViewRow currentRow = (GridViewRow)ctl.NamingContainer;
                object dataKeyValue = GVEmployees.DataKeys[currentRow.RowIndex].Value;
                if (dataKeyValue != null)
                {
                    id = dataKeyValue.ToString();
                }

                string filePath = Server.MapPath("~/Pdf/") + id.ToString() + ".pdf";

                if (File.Exists(filePath))
                {
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader("Content-Disposition", "inline; filename=" + id.ToString() + ".pdf");
                    Response.TransmitFile(filePath);
                    Response.End();
                }
                else
                {
                    string script = @"Swal.fire({title: 'Failure!',text: 'PDF not found.',icon: 'error',confirmButtonText: 'OK'});";
                    ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                }
            }
            if (e.CommandName == "PrintPdf")
            {
                string id = string.Empty;
                Control ctl = (Control)e.CommandSource;
                GridViewRow currentRow = (GridViewRow)ctl.NamingContainer;
                object StudentCode = GVEmployees.DataKeys[currentRow.RowIndex].Value;
                if (StudentCode != null)
                {
                    id = StudentCode.ToString();
                }

                GeneratePDF(id);
            }
        }
        #endregion
        #region MandalInGrid
        protected void DpStudentStateEdit_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlState = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddlState.NamingContainer;
            DropDownList ddlDistrict = (DropDownList)row.FindControl("DpStudentStateEdit");

            string selectedState = ddlState.SelectedValue;
            if (!string.IsNullOrEmpty(selectedState))
            {
                DpMandal.SelectedIndex = -1;
                if (DpState.SelectedIndex > 0)
                {
                    string[] ParameterName = { "@State_Id" }; string[] ParameterValue = { ddlDistrict.SelectedValue };
                    objBL.FillDropdown(DpMandal, "Sp_Mandal", "Mandal_Name", "Mandal_Id", "---Select Mandal---", "0", ParameterName, ParameterValue);
                }
                else { DpState.SelectedIndex = DpMandal.SelectedIndex = -1; }
            }

        }
        #endregion
        #region CreatePdf
        private void CreatePDF(StudentDetails student)
        {
            string filePath = Server.MapPath("~/Temp/StudentDetails_" + student.StudentId + ".pdf");

            using (MemoryStream ms = new MemoryStream())
            {
                PdfWriter writer = new PdfWriter(ms);
                PageSize pageSize = PageSize.A4;
                iText.Kernel.Pdf.PdfDocument pdf = new iText.Kernel.Pdf.PdfDocument(writer);
                pdf.SetDefaultPageSize(pageSize);
                Document document = new Document(pdf);
                document.SetMargins(36, 36, 36, 36);

                Paragraph heading = new Paragraph("Student Details").SetFont(iText.Kernel.Font.PdfFontFactory.CreateFont(StandardFonts.HELVETICA_BOLD)).SetFontSize(18)
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER).SetUnderline(); 

                document.Add(heading);
                document.Add(new Paragraph("Student ID: " + student.StudentId).SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                document.Add(new Paragraph("Name: " + student.Name).SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                document.Add(new Paragraph("Mobile: " + student.Mobile_Number).SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                document.Add(new Paragraph("Email: " + student.Emailid).SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                document.Add(new Paragraph("Gender: " + student.Gender).SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                document.Add(new Paragraph("Qualification: " + student.Qualification).SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                document.Add(new Paragraph("State: " + student.State).SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                document.Add(new Paragraph("Mandal: " + student.Mandal).SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                document.Add(new Paragraph("Address: " + student.Address).SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                string imagePath = student.Photo;
                //if (!string.IsNullOrEmpty(imagePath) && File.Exists(imagePath))
                //{
                //    string extension = Path.GetExtension(imagePath).ToLower();
                //    if (extension == ".jpg" || extension == ".png" || extension == ".jpeg")
                //    {
                        //Image img = ImageDataFactory.Create(student.Photo);
                        //document.Add(new Image(img).SetAutoScale(true).SetBorder(iText.Layout.Borders.Border.DOTTED));
                //        ImageData imageData = ImageDataFactory.Create(imagePath);
                //        Image image = new Image(imageData);
                //        document.Add(image);
                //    }
                //    else
                //    {
                //        document.Add(new Paragraph("Unsupported image format."));
                //    }
                //}
                //else
                //{
                //    document.Add(new Paragraph("Image not found."));
                //}
                document.Close();
                File.WriteAllBytes(filePath, ms.ToArray());
                ServePdfForDownload(filePath);
            }
        }
        #endregion
        #region GeneratePDF
        private void GeneratePDF(string StudentCode)
        {
            var studentDetails = GetStudentDetails(StudentCode);
            if (studentDetails != null)
            {
                CreatePDF(studentDetails);
            }
            else
            {
                throw new Exception("Student not found.");
            }
        }
        #endregion
        #region StudentDetails
        private StudentDetails GetStudentDetails(string StudentCode)
        {
            StudentDetails student = null;
            string Sp = "Sp_GetData_User";
            string[] ParamNames = { "@StudentCode" };
            string[] ParamValues = { StudentCode };

            DataSet Ds = objDL.RetrivedData(Sp, ParamNames, ParamValues);

            if (Ds != null && Ds.Tables.Count > 0 && Ds.Tables[0].Rows.Count > 0)
            {
                var row = Ds.Tables[0].Rows[0];
                student = new StudentDetails
                {
                    StudentId = row["StudentId"].ToString(),
                    Name = row["Name"].ToString(),
                    Mobile_Number = row["Mobile_Number"].ToString(),
                    Emailid = row["Emailid"].ToString(),
                    Qualification = row["Qualification_Name"].ToString(),
                    State = row["State_Name"].ToString(),
                    Mandal = row["Mandal_Name"].ToString(),
                    Address = row["Address"].ToString(),
                    Photo = row["Photo"].ToString()
                };
                string GAb = row["Gender"].ToString();
                if (GAb == "1")
                {
                    student.Gender = "Male";
                }
                else if (GAb == "2")
                {
                    student.Gender = "Female";
                }
                else
                {
                    student.Gender = "Others";
                }
            }
            return student;
        }
        #endregion
        #region PdfDownload
        private void ServePdfForDownload(string filePath)
        {
            string fileName = System.IO.Path.GetFileName(filePath);
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.TransmitFile(filePath);
            Response.End();
        }
        #endregion
    }
}