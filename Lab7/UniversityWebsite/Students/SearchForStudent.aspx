<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SearchForStudent.aspx.cs" Inherits="SearchForStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="form-horizontal">
        <h4 class="col-md-offset-1"><span style="text-decoration: underline; color: #990000">Search For Student Record</span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label col-md-offset-1"></asp:Label>
        <hr />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtStudentId" CssClass="col-md-3 control-label">Enter a student id:</asp:Label>
            <div class="col-md-2">
                <asp:TextBox ID="txtStudentId" runat="server" MaxLength="8" CssClass="form-control input-sm" TextMode="Number" ToolTip="Student id"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ErrorMessage="Please enter a valid student id." ControlToValidate="txtStudentId" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Please enter exactly 8 digits."
                    ControlToValidate="txtStudentId" CssClass="text-danger" Display="Dynamic" ValidationExpression="^\d{8}$"></asp:RegularExpressionValidator>
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnFindStudent" runat="server" OnClick="btnFindStudent_Click" Text="Find Student Record" CssClass="btn-sm" />
            </div>
        </div>
        <asp:Panel ID="pnlStudentRecord" runat="server" Visible="False">
            <hr />
            <div class="form-group">
                <div class="col-md-offset-1 col-md-10">
                    <asp:GridView ID="gvStudentRecord" runat="server" BorderWidth="2px" CssClass="table-condensed" BorderStyle="Solid" Caption="<b>Search Result</b>" CaptionAlign="Top" CellPadding="3" HorizontalAlign="Justify"></asp:GridView>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>