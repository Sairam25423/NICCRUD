<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DpStateandCity.aspx.cs" Inherits="NICCRUD.Naveen_Task.DpStateandCity" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        <%--$(document).ready(function () {
            $('#<%= DpState.ClientID %>').change(function () {
                var stateId = $("#DpState").val();
                if (stateId !== "0") {
                    loadDistricts(stateId);
                } else {
                    var dpMandals = $('#<%= DpMandal.ClientID %>');
                    dpMandals.empty();
                    dpMandals.append($('<option></option>').val("0").html("--Select Mandal--"));
                }
            });
        });
        function loadDistricts(stateId) {
            debugger;
            var stateId = $("#DpState").val();
            if (stateId != "") {
                $.ajax({
                    type: "POST",
                    url: "DpStateandCity.aspx/GetMandals",
                    data: JSON.stringify({ stateId: stateId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var dpMandals = $('#<%= DpMandal.ClientID %>');
                        dpMandals.empty();
                        dpMandals.append($('<option></option>').val("0").html("--Select Mandal--"));
                        $.each(response.d, function (i, district) {
                            dpMandals.append($('<option></option>').val(dpMandals.MandalId).html(dpMandals.MandalName));
                        });
                    },
                    error: function () {
                        alert('Error loading mandals.');
                    }
                });
            }
        }--%>
        $(document).ready(function () {
            $('#<%= DpState.ClientID %>').change(function () {
                var stateId = $(this).val();
                if (stateId !== "0") {
                    loadDistricts(stateId);
                } else {
                    var dpMandals = $('#<%= DpMandal.ClientID %>');
                    dpMandals.empty();
                    dpMandals.append($('<option></option>').val("0").html("--Select Mandal--"));
                }
            });
        });

        function loadDistricts(stateId) {
            debugger;
            $.ajax({
                type: "POST",
                url: "DpStateandCity.aspx/GetMandals",
                data: JSON.stringify({ stateId: stateId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var dpMandals = $('#<%= DpMandal.ClientID %>');
                dpMandals.empty();
                dpMandals.append($('<option></option>').val("0").html("--Select Mandal--"));

                // Corrected this part
                $.each(response.d, function (i, district) {
                    dpMandals.append($('<option></option>').val(district.MandalId).html(district.MandalName));
                });
            },
            error: function (xhr, status, error) {
                //console.error("Error loading mandals:", error);
                //alert('Error loading mandals.');
                var dpMandals = $('#<%= DpMandal.ClientID %>');
                dpMandals.empty();
                dpMandals.append($('<option></option>').val("0").html("--Select Mandal--"));

                // Corrected this part
                $.each(response.d, function (i, district) {
                    dpMandals.append($('<option></option>').val(district.MandalId).html(district.MandalName));
                });
            }
        });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="container">
            <div class="card mt-5">
                <div class="card card-header">
                    <h1 class="text-center">Dropdown Filling</h1>
                </div>
                <div class="card card-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-6 col-xl-6 col-xxl-6">
                            <span><span style="color: red">*</span> State</span>
                            <asp:DropDownList ID="DpState" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RfvState" runat="server" ErrorMessage="* Select State." ForeColor="Red" ControlToValidate="DpState" Display="Dynamic" InitialValue="0" ValidationGroup="SR"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-6 col-xl-6 col-xxl-6">
                            <span><span style="color: red">*</span> Mandal</span>
                            <asp:DropDownList ID="DpMandal" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RfvMandal" runat="server" ErrorMessage="* Select Mandal." ForeColor="Red" ControlToValidate="DpMandal" Display="Dynamic" InitialValue="0" ValidationGroup="SR"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-4 col-xl-4 col-xxl-4"></div>
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-4 col-xl-4 col-xxl-4 text-center">
                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="SR" />
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-4 col-xl-4 col-xxl-4"></div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
