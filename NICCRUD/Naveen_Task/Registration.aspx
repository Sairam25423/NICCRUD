<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="NICCRUD.Naveen_Task.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!--Sweet Alerts Links-->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.6.0/dist/sweetalert2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.6.0/dist/sweetalert2.all.min.js"></script>
</head>
<body>
    <form id="form1" runat="server" method="post" enctype="multipart/form-data">
        <section class="bg-primary p-3 p-md-4 p-xl-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                        <div class="card border-0 shadow-sm rounded-4">
                            <div class="card-body p-3 p-md-4 p-xl-5">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="mb-5">
                                            <h2 class="h3 text-center">Student Registration</h2>
                                        </div>
                                        <div class="row gy-3 overflow-hidden">
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblStdId" class="form-label"><span style="color: red">*</span> Student Id</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:TextBox ID="txtStudentid" runat="server" CssClass="form-control" MaxLength="4" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvStudentid" runat="server" ErrorMessage="* Studentid Required." ForeColor="Red" Display="Dynamic" ControlToValidate="txtStudentid" ValidationGroup="SR"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="revStudentid" runat="server" ErrorMessage="* Studentid should be number only." ForeColor="Red" Display="Dynamic" ControlToValidate="txtStudentid" ValidationExpression="^\d+$" ValidationGroup="SR"></asp:RegularExpressionValidator>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblName" class="form-label"><span style="color: red">*</span> Name</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="100" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="* Student Name Required." ForeColor="Red" Display="Dynamic" ControlToValidate="txtName" ValidationGroup="SR"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="revName" runat="server" ErrorMessage="* Allowed alphabets only with mim 3 Charecters." Display="Dynamic" ForeColor="Red" ControlToValidate="txtName" ValidationExpression="^[A-Za-z\s]{3,}$" ValidationGroup="SR"></asp:RegularExpressionValidator>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblMobile" class="form-label"><span style="color: red">*</span> Mobile No.</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" MaxLength="10" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="* Mobile Number Required." ForeColor="Red" Display="Dynamic" ControlToValidate="txtMobile" ValidationGroup="SR"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="revMobile" runat="server" ErrorMessage="* Enter valid number." ControlToValidate="txtMobile" ForeColor="Red" Display="Dynamic" ValidationExpression="^[6-9]\d{9}$" ValidationGroup="SR"></asp:RegularExpressionValidator>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblEmail" class="form-label"><span style="color: red">*</span> Email ID</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:TextBox ID="txtEmailid" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvEmailid" runat="server" ErrorMessage="* Email id Required." ForeColor="Red" Display="Dynamic" ControlToValidate="txtEmailid" ValidationGroup="SR"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="revEmailid" runat="server" ErrorMessage="* Enter valid Email." Display="Dynamic" ControlToValidate="txtEmailid" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" ValidationGroup="SR"></asp:RegularExpressionValidator>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblGender" class="form-label"><span style="color: red">*</span> Gender</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Value="1" Text="M">Male</asp:ListItem>
                                                                <asp:ListItem Value="2" Text="F">FeMale</asp:ListItem>
                                                                <asp:ListItem Value="3" Text="O">Others</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvGender" runat="server" ErrorMessage="* Gender Required." ForeColor="Red" Display="Dynamic" ControlToValidate="rblGender" InitialValue="" ValidationGroup="SR"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblQualification" class="form-label"><span style="color: red">*</span> Qualification</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:DropDownList ID="DpQualification" runat="server" CssClass="form-control">
                                                                <asp:ListItem Value="0">--Select Qualification--</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvQualification" runat="server" ErrorMessage="* Qualification Required." ForeColor="Red" Display="Dynamic" ControlToValidate="DpQualification" InitialValue="0" ValidationGroup="SR"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblName" class="form-label"><span style="color: red">*</span> State</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:DropDownList ID="DpState" runat="server" CssClass="form-control" OnSelectedIndexChanged="DpState_SelectedIndexChanged" AutoPostBack="true">
                                                                <asp:ListItem Value="0">--Select State--</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvState" runat="server" ErrorMessage="* State Required." ForeColor="Red" Display="Dynamic" ControlToValidate="DpState" InitialValue="0" ValidationGroup="SR"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblName" class="form-label"><span style="color: red">*</span> Mandal</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:DropDownList ID="DpMandal" runat="server" CssClass="form-control">
                                                                <asp:ListItem Value="0">--Select Mandal--</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvMandal" runat="server" ErrorMessage="* Mandal Required." ForeColor="Red" Display="Dynamic" ControlToValidate="DpMandal" InitialValue="0" ValidationGroup="SR"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblAddress" class="form-label"><span style="color: red">*</span> Address</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="* Address Required." ForeColor="Red" Display="Dynamic" ControlToValidate="txtAddress" ValidationGroup="SR"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-12">
                                                <div class="mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblBioData" class="form-label"><span style="color: red">*</span> Bio Data</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:FileUpload ID="FlUpBio" runat="server" CssClass="form-control" />
                                                        </div>
                                                    </div>
                                                    <span style="color:darkgrey;font-size:smaller;">Pdf size should be less than 2MB.</span>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvUpBio" runat="server" ControlToValidate="FlUpBio" ForeColor="Red" Display="Dynamic" ErrorMessage="* Please select a file to upload." ValidationGroup="SR" />
                                                <asp:RegularExpressionValidator ID="revFlUpBio" runat="server" ControlToValidate="FlUpBio" ForeColor="Red" Display="Dynamic" ValidationExpression="^.*\.pdf$" ErrorMessage="* Only pdf files are allowed." ValidationGroup="SR" />
                                            </div>
                                            <div class="col-12">
                                                <div class="mb-3">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <label for="lblPhoto" class="form-label"><span style="color: red">*</span> Photo</label>
                                                        </div>
                                                        <div class="col-8">
                                                            <asp:FileUpload ID="FlUpPhoto" runat="server" CssClass="form-control" />
                                                        </div>
                                                    </div>
                                                    <span style="color:darkgrey;font-size:smaller;">Photo should be less than 100KB.</span>
                                                </div>
                                                <asp:RequiredFieldValidator ID="rfvFileUpload" runat="server" ControlToValidate="FlUpPhoto" ForeColor="Red" Display="Dynamic" ErrorMessage="* Please select a file to upload." ValidationGroup="SR" />
                                                <asp:RegularExpressionValidator ID="revFileUpload" runat="server" ControlToValidate="FlUpPhoto" Display="Dynamic" ValidationExpression="^.*\.(jpg|jpeg|png)$" ErrorMessage="* Only image files (jpg, jpeg, png) are allowed." ForeColor="Red" ValidationGroup="SR" />
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-4"></div>
                                                <div class="col-4  text-center">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnSubmit_Click" ValidationGroup="SR" />
                                                </div>
                                                <div class="col-4"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row  mt-3">
                    <div class="row justify-content-center">
                        <div class="grid-container table-responsive">
                            <asp:GridView ID="GVEmployees" runat="server" CssClass="table table-striped table-bordered text-center table-hover" AutoGenerateColumns="false"
                                OnRowEditing="GVEmployees_RowEditing" OnRowUpdating="GVEmployees_RowUpdating" OnRowDeleting="GVEmployees_RowDeleting"
                                OnRowDataBound="GVEmployees_RowDataBound" OnRowCancelingEdit="GVEmployees_RowCancelingEdit" OnPageIndexChanging="GVEmployees_PageIndexChanging"
                                OnRowCommand="GVEmployees_RowCommand" DataKeyNames="StudentCode" AllowPaging="true" PageSize="10" AllowSorting="true">
                                <PagerStyle HorizontalAlign="Center" />
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No">
                                        <ItemTemplate><%# Container.DataItemIndex+1 %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Student Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentIdEdit" runat="server" Text='<%# Bind("StudentId") %>' ReadOnly="true"></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtStudentIdEdit" runat="server" Text='<%# Bind("StudentId") %>' CssClass="form-control" MaxLength="3" AutoCompleteType="Disabled" autocomplete="off" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Student Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentName" runat="server" Text='<%# Bind("Name") %>' ReadOnly="true"></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtStudentNameEdit" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control" MaxLength="100" AutoCompleteType="Disabled" autocomplete="off" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mobile Number">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentMobile" runat="server" Text='<%# Bind("Mobile_Number") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtStudentMobileEdit" runat="server" Text='<%# Bind("Mobile_Number") %>' CssClass="form-control" MaxLength="10" AutoCompleteType="Disabled" autocomplete="off" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Email id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentEmailid" runat="server" Text='<%# Bind("Emailid") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtStudentEmailidEdit" runat="server" Text='<%# Bind("Emailid") %>' CssClass="form-control" MaxLength="10" AutoCompleteType="Disabled" autocomplete="off" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Student Gender">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentGender" runat="server" Text='<%# Bind("Gender_Description") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:RadioButtonList ID="rblStudentGenderEdit" runat="server">
                                                <asp:ListItem Value="1" Text="M">Male</asp:ListItem>
                                                <asp:ListItem Value="2" Text="F">FeMale</asp:ListItem>
                                                <asp:ListItem Value="3" Text="O">Others</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Student Qualification">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentQualification" runat="server" Text='<%# Bind("Qualification_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DpStudentQualificationEdit" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Student State">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentState" runat="server" Text='<%# Bind("State_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DpStudentStateEdit" runat="server" CssClass="form-control" OnSelectedIndexChanged="DpStudentStateEdit_SelectedIndexChanged">
                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Student Mandal">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentMandal" runat="server" Text='<%# Bind("Mandal_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DpStudentMandalEdit" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Student Address">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentAddress" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtStudentAddressEdit" runat="server" Text='<%# Bind("Address") %>' CssClass="form-control" TextMode="MultiLine" AutoCompleteType="Disabled" autocomplete="off" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Student Image">
                                        <ItemTemplate>
                                            <asp:Image ID="Image1" runat="server" CssClass="img-fluid" ImageUrl='<%# ResolveUrl("~/Images/" + Eval("Photo").ToString()) %>' Height="50px" Width="50px" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:FileUpload ID="StudentImage" runat="server" CssClass="form-control" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Student Pdf">
                                        <ItemTemplate>
                                            <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-primary" CommandName="ViewPDF" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Student Print">
                                        <ItemTemplate>
                                            <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn btn-success" CommandName="PrintPdf" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpCode" runat="server" Text='<%# Bind("StudentCode") %>' ReadOnly="true" Visible="false"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpPhoto" runat="server" Text='<%# Bind("Photo") %>' ReadOnly="true" Visible="false"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" HeaderText="Actions"
                                        EditText="<span class='btn btn-primary'>Edit</span>" DeleteText="<span class='btn btn-danger'>Delete</span>"
                                        UpdateText="<span class='btn btn-success'>Update</span>" CancelText="<span class='btn btn-warning'>Cancel</span>"
                                        ItemStyle-Width="16%" HeaderStyle-Width="16%" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </form>
</body>
</html>
