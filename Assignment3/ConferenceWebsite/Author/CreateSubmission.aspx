<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="CreateSubmission.aspx.cs" Inherits="Author_CreateSubmission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <script type="text/javascript">
        function CheckOne(obj) {
            var grid = obj.parentNode.parentNode.parentNode;
            var inputs = grid.getElementsByTagName("input");
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].type == "checkbox") {
                    if (obj.checked && inputs[i] != obj && inputs[i].checked) {
                        inputs[i].checked = false;
                    }
                }
            }
        }
    </script>
    <style type="text/css">
        input, select, textarea {
            max-width: 600px;
        }
    </style>
    <div class="form-horizontal" role="form">
        <h4><span style="text-decoration: underline; color: #800000" class="h4"><strong>Create Submission</strong></span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label"></asp:Label>
        <asp:Panel ID="pnlSubmissionInfo" runat="server">
            <hr />
            <!-- Submission input controls -->
            <div class="form-group" role="row">
                <asp:Label runat="server" Text="Title:" CssClass="control-label col-md-2" AssociatedControlID="txtTitle"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control input-sm" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The title field is required." ControlToValidate="txtTitle" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationGroup="SubmissionValidation"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group" role="row">
                <asp:Label runat="server" Text="Abstract:" CssClass="control-label col-md-2" AssociatedControlID="txtAbstract"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtAbstract" runat="server" CssClass="form-control input-sm" MaxLength="300" TextMode="MultiLine" Height="100"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The abstract field is required." ControlToValidate="txtAbstract" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationGroup="SubmissionValidation"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group" role="row">
                <asp:Label runat="server" Text="Type:" CssClass="control-label col-md-2" AssociatedControlID="ddlSubmissionType"></asp:Label>
                <div class="col-md-10">
                    <asp:DropDownList ID="ddlSubmissionType" runat="server" CssClass="dropdown">
                        <asp:ListItem Value="research">Research</asp:ListItem>
                        <asp:ListItem Value="demo">Demo</asp:ListItem>
                        <asp:ListItem Value="industrial">Industrial</asp:ListItem>
                        <asp:ListItem Value="vision">Vision</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <!-- Author input controls -->
            <hr />
            <h5><span style="text-decoration: underline; color: #800000" class="h5"><strong>Add Author</strong></span></h5>
            <div class="form-group" role="row">
                <asp:Label runat="server" Text="Title:" CssClass="control-label col-md-2" AssociatedControlID="ddlTitle"></asp:Label>
                <div class="col-md-1">
                    <asp:DropDownList ID="ddlTitle" runat="server" CssClass="dropdown">
                        <asp:ListItem>None</asp:ListItem>
                        <asp:ListItem>Mr</asp:ListItem>
                        <asp:ListItem>Ms</asp:ListItem>
                        <asp:ListItem>Miss</asp:ListItem>
                        <asp:ListItem>Dr</asp:ListItem>
                        <asp:ListItem>Prof</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <asp:Panel ID="pnlContactAuthor" runat="server">
                    <div class="col-md-1">
                    </div>
                </asp:Panel>
                <div class="col-md-6"></div>
            </div>
            <div class="form-group" role="row">
                <asp:Label runat="server" Text="Name:" CssClass="control-label col-md-2" AssociatedControlID="txtAuthorName"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtAuthorName" runat="server" CssClass="form-control input-sm" MaxLength="50" Wrap="False"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The name field is required." ControlToValidate="txtAuthorName" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationGroup="AuthorValidation"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group" role="row">
                <asp:Label runat="server" Text="Institution:" CssClass="control-label col-md-2" AssociatedControlID="txtInstitution"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtInstitution" runat="server" CssClass="form-control input-sm" MaxLength="36" Wrap="False"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The institution field is required." ControlToValidate="txtInstitution" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationGroup="AuthorValidation"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group" role="row">
                <asp:Label runat="server" Text="Country:" CssClass="control-label col-md-2" AssociatedControlID="txtCountry"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control input-sm" MaxLength="30" Wrap="False"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The country field is required." ControlToValidate="txtCountry" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationGroup="AuthorValidation"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group" role="row">
                <asp:Label runat="server" Text="Phone number:" CssClass="control-label col-md-2" AssociatedControlID="txtPhoneNumber"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control input-sm" MaxLength="15" Wrap="False" TextMode="Number"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The phone number field is required." ControlToValidate="txtPhoneNumber" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationGroup="AuthorValidation"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="The phone number must be between 8 and 15 digits." ControlToValidate="txtPhoneNumber" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationExpression="^[0-9]{8,15}$" ValidationGroup="AuthorValidation"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="form-group" role="row">
                <asp:Label runat="server" Text="Email:" CssClass="control-label col-md-2" AssociatedControlID="txtEmail"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control input-sm" MaxLength="50" TextMode="Email" Wrap="False"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="The email field is required." ControlToValidate="txtEmail" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationGroup="AuthorValidation"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvPersonEmail" runat="server" ErrorMessage="The email already exists." ControlToValidate="txtEmail" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" OnServerValidate="cvPersonEmail_ServerValidate" ValidationGroup="AuthorValidation"></asp:CustomValidator>
                </div>
            </div>
            <div class="form-group" role="row">
                <div class="col-md-offset-2 col-md-2">
                    <asp:Button ID="btnAddAuthor" runat="server" OnClick="btnAddAuthor_Click" Text="Add Author" CssClass="btn-sm" ValidationGroup="AuthorValidation" />
                </div>
            </div>
        </asp:Panel>
        <!-- Author display -->
        <asp:Panel ID="pnlAuthors" runat="server" Visible="False">
            <hr />
            <h5><span style="text-decoration: underline; color: #800000" class="h5 col-md-offset-2 "><strong>Authors</strong></span></h5>
            <div class="form-group" role="row">
                <div class="col-md-offset-2 col-md-10">
                    <asp:GridView ID="gvAuthors" runat="server" ShowHeaderWhenEmpty="True" OnRowDataBound="gvAuthors_RowDataBound" CssClass="table-condensed" BorderStyle="Solid" CellPadding="0">
                        <Columns>
                            <asp:TemplateField HeaderText="CONTACT?">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkContactAuthor" runat="server" onclick="CheckOne(this)" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="form-group" role="row">
                <div class="col-md-offset-1 col-md-11">
                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" CssClass="btn-sm" />
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>