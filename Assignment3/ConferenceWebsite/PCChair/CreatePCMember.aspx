<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="CreatePCMember.aspx.cs" Inherits="PCChair_CreatePCMember" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style type="text/css">
        input, select, textarea {
            max-width: 600px;
        }
    </style>
    <div class="form-horizontal">
        <h4><span style="text-decoration: underline; color: #800000" class="h4"><strong>Create PC Member</strong></span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label"></asp:Label>
        <asp:Panel ID="pnlInputInfo" runat="server">
            <hr />
            <div class="form-group">
                <asp:Label runat="server" Text="PC code:" AssociatedControlID="txtPCCode" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-1">
                    <asp:TextBox ID="txtPCCode" runat="server" CssClass="form-control input-sm" MaxLength="4"></asp:TextBox>
                </div>
                <asp:Label runat="server" Text="Title:" AssociatedControlID="txtName" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlTitle" runat="server" CssClass="dropdown">
                        <asp:ListItem>None</asp:ListItem>
                        <asp:ListItem>Prof</asp:ListItem>
                        <asp:ListItem>Dr</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-5"></div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2">
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="A PC code is required." ControlToValidate="txtPCCode" CssClass="text-danger" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="Please enter a valid PC code (two lowercase letters followed by two digits)." ControlToValidate="txtPCCode" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationExpression="^[a-z]{2}[0-9]{2}$"></asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="cvPCCode" runat="server" ErrorMessage="The PC code already exists." ControlToValidate="txtPCCode" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" OnServerValidate="cvPCCode_ServerValidate"></asp:CustomValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Name:" AssociatedControlID="txtName" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control input-sm" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The name field is required." ControlToValidate="txtName" CssClass="text-danger" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Institution:" AssociatedControlID="txtInstitution" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox ID="txtInstitution" runat="server" CssClass="form-control input-sm" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The institution field is required." ControlToValidate="txtInstitution" CssClass="text-danger" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Country:" AssociatedControlID="txtCountry" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control input-sm" MaxLength="30"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The country field is required." ControlToValidate="txtCountry" CssClass="text-danger" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Phone number:" AssociatedControlID="txtPhoneNo" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox ID="txtPhoneNo" runat="server" CssClass="form-control input-sm" MaxLength="15" TextMode="Number"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The phone number field is required." ControlToValidate="txtPhoneNo" CssClass="text-danger" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="The phone number must be between 8 and 15 digits." ControlToValidate="txtPhoneNo" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationExpression="^[0-9]{8,15}$"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Email:" AssociatedControlID="txtEmail" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-4">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control input-sm" MaxLength="50" TextMode="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The email field is required." ControlToValidate="txtEmail" CssClass="text-danger" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvEmail" runat="server" ControlToValidate="txtEmail" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ErrorMessage="The email already exists." OnServerValidate="cvEmail_ServerValidate"></asp:CustomValidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" CssClass="btn-sm" />
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>