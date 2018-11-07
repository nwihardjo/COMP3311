<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="FindSubmission.aspx.cs" Inherits="Author_FindSubmission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style type="text/css">
        input, select, textarea {
            max-width: 600px;
        }
    </style>
    <div class="form-horizontal">
        <h4><span style="text-decoration: underline; color: #800000" class="h4"><strong>Find Submission</strong></span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label"></asp:Label>
        <asp:Panel ID="pnlSearchInput" runat="server">
            <hr />
            <div class="form-group">
                <asp:Label ID="lblSubmissionNumber" runat="server" Text="Submission:" CssClass="control-label col-md-2" AssociatedControlID="txtSubmissionNumber"></asp:Label>
                <div class="col-md-1">
                    <asp:TextBox ID="txtSubmissionNumber" runat="server" CssClass="form-control input-sm" MaxLength="3" TextMode="Number"></asp:TextBox>
                </div>
                <div>
                    <asp:Button ID="btnSearchSubmission" runat="server" OnClick="btnSearchSubmission_Click" Text="Search" CssClass="btn-sm" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="A submission number is required." ControlToValidate="txtSubmissionNumber" CssClass="text-danger" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="The submission number must be an integer." ControlToValidate="txtSubmissionNumber" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationExpression="^[0-9]{1,3}$"></asp:RegularExpressionValidator>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlSearchResult" runat="server" Visible="False">
            <hr />
            <div class="form-group">
                <asp:Label ID="lblTitle" runat="server" Text="Title:" CssClass="control-label col-md-2" AssociatedControlID="txtTitle"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtTitle" runat="server" BorderStyle="None" CssClass="form-control-static" ReadOnly="True"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblAbstract" runat="server" Text="Abstract:" CssClass="control-label col-md-2" AssociatedControlID="txtAbstract"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtAbstract" runat="server" BorderStyle="None" CssClass="form-control-static" ReadOnly="True" TextMode="MultiLine" Height="100px" Width="600px"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblSubmissionType" runat="server" Text="Submission type:" CssClass="control-label col-md-2" AssociatedControlID="txtSubmissionType"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtSubmissionType" runat="server" BorderStyle="None" CssClass="form-control-static" ReadOnly="True"></asp:TextBox>
                </div>
            </div>
            <h5><span style="text-decoration: underline; color: #800000" class="h5"><strong>Author Information</strong></span></h5>
            <div class="form-group">
                <div class="col-md-offset-1">
                    <asp:GridView ID="gvAuthor" runat="server" CssClass="table-condensed" BorderStyle="Solid" CellPadding="0" OnRowDataBound="gvAuthor_RowDataBound"></asp:GridView>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>