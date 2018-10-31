<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="SearchStudentRecords.aspx.cs" Inherits="SearchStudentRecords" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-horizontal">
        <h4 class="col-md-offset-1"><span style="text-decoration: underline; color: #990000">Display Student Records In A Department</span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label col-md-offset-1"></asp:Label>
        <asp:Panel ID="pnlSearch" runat="server">
            <hr />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="ddlDepartments" CssClass="col-md-3 control-label">Select a department:</asp:Label>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlDepartments" runat="server" CssClass="dropdown"></asp:DropDownList>
                    <div>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Please select a department." ControlToValidate="ddlDepartments" CssClass="text-danger" Display="Dynamic" InitialValue="none selected" ToolTip="Department"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnFindStudentRecords" runat="server" OnClick="btnFindStudentRecords_Click" Text="Find Student Records" CssClass="btn-sm" />
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlSearchResult" runat="server" Visible="False">
            <hr />
            <div class="form-group">
                <div class="col-md-offset-1 col-md-10">
                    <asp:GridView ID="gvFindStudentRecordsResult" runat="server" BorderWidth="2px" CssClass="table-condensed"
                        BorderStyle="Solid" Caption="<b>Enrolled Students</b>" CaptionAlign="Top" HeaderStyle-Wrap="True" HorizontalAlign="Justify">
                    </asp:GridView>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>