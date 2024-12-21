<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dropdowns.aspx.cs" Inherits="NICCRUD.Naveen_Task.Dropdowns" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>State and Mandal Dropdowns</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            debugger;
            // Load states on page load
            loadStates();

            // Change event for state dropdown
            $('#<%= DpState.ClientID %>').change(function () {
                var stateId = $(this).val();
                loadMandals(stateId);
            });
        });

        function loadStates() {
            debugger;
            $.ajax({
                type: "POST",
                url: "Dropdowns.aspx/GetStates",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var states = response.d;
                    var options = '<option value="">Select State</option>';
                    $.each(states, function (index, state) {
                        options += '<option value="' + state.Id + '">' + state.Name + '</option>';
                    });
                    $('#<%= DpState.ClientID %>').html(options);
                },
                error: function () {
                    alert("Error loading states.");
                }
            });
        }

        function loadMandals(stateId) {
            debugger;
            $.ajax({
                type: "POST",
                url: "Dropdowns.aspx/GetMandals",
                data: JSON.stringify({ stateId: stateId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var mandals = response.d;
                    var options = '<option value="">Select Mandal</option>';
                    $.each(mandals, function (index, mandal) {
                        options += '<option value="' + mandal.Id + '">' + mandal.Name + '</option>';
                    });
                    $('#<%= DpMandal.ClientID %>').html(options);
                },
                error: function () {
                    alert("Error loading mandals.");
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <label for="DpState">State:</label>
            <asp:DropDownList ID="DpState" runat="server"></asp:DropDownList>

            <label for="DpMandal">Mandal:</label>
            <asp:DropDownList ID="DpMandal" runat="server"></asp:DropDownList>
        </div>
    </form>
</body>
</html>
