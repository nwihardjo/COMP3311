<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="FindAllAuthorSubmissions.aspx.cs" Inherits="Author_FindAllAuthorSubmissions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style type="text/css">
        input, select, textarea {
            max-width: 200px;
        }
    </style>
    <div class="form-horizontal">
        <h4><span style="text-decoration: underline; color: #800000" class="h4"><strong>Find All Submissions For An Author</strong></span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label"></asp:Label>
        <asp:Panel ID="pnlSearchInput" runat="server">
            <hr />
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="Enter your email address:" CssClass="control-label col-md-3" AssociatedControlID="txtEmail"></asp:Label>
                <div class="col-md-3">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control input-sm" MaxLength="50" TextMode="Email"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnSearchPaper" runat="server" OnClick="btnSearchPaper_Click" Text="Search" CssClass="btn-sm" />
                </div>
            </div>
            <div class="from-group">
                <div class="col-md-offset-3">
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="An email address is required." ControlToValidate="txtEmail" CssClass="text-danger" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvEmail" runat="server" ErrorMessage="There is no author with this email address." ControlToValidate="txtEmail" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" OnServerValidate="cvEmail_ServerValidate"></asp:CustomValidator>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlSearchResult" runat="server" Visible="False">
            <hr />
            <div class="form-group">
                <div class="col-md-12">
                    <asp:GridView ID="gvSubmission" runat="server" CssClass="table-condensed" BorderStyle="Solid" CellPadding="0" OnRowDataBound="gvSubmission_RowDataBound"></asp:GridView>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>