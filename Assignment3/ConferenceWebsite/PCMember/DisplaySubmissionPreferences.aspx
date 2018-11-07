<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DisplaySubmissionPreferences.aspx.cs" Inherits="PCMember_DisplaySubmissionPreferences" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style type="text/css">
        input, select, textarea {
            max-width: 600px;
        }
    </style>
    <div class="form-horizontal">
        <h4><span style="text-decoration: underline; color: #800000" class="h4"><strong>Submission Preferences</strong></span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label"></asp:Label>
        <asp:Panel ID="pnlInputPCCode" runat="server">
            <hr />
            <div class="form-group">
                <asp:Label runat="server" Text="PC code:" AssociatedControlID="txtPcCode" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-1">
                    <asp:TextBox ID="txtPCCode" runat="server" CssClass="form-control input-sm" MaxLength="4"></asp:TextBox>
                </div>
                <div class="col-md-9">
                    <asp:Button ID="btnGetSubmissions" runat="server" OnClick="btnGetSubmissions_Click" Text="Get Submissions" CssClass="btn-sm" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2">
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="A PC code is required." ControlToValidate="txtPCCode" CssClass="text-danger" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="Please enter a valid PC code (two lowercase letters followed by two digits)." ControlToValidate="txtPCCode" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationExpression="^[a-z]{2}[0-9]{2}$"></asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="cvPCCodeValidate" runat="server" ErrorMessage="There is no PC member with this PC code." ControlToValidate="txtPCCode"
                        CssClass="text-danger" Display="Dynamic" EnableClientScript="False" OnServerValidate="cvPCCodeValidate_ServerValidate"></asp:CustomValidator>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlPreferencesSpecified" runat="server" Visible="False">
            <hr />
            <h5><span style="text-decoration: underline; color: #800000" class="h5"><strong>Submissions For Which You Have Already Specified A Preference:</strong></span></h5>
            <div class="form-group">
                <div class="col-md-12">
                    <asp:GridView ID="gvPreferenceSpecified" runat="server" CssClass="table-condensed" OnRowDataBound="gvPreferenceSpecified_RowDataBound"></asp:GridView>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlPreferencesNotSpecified" runat="server" Visible="False">
            <hr />
            <h5><span style="text-decoration: underline; color: #800000" class="h5"><strong>Submissions For Which You Have Not Specified A Preference:</strong></span></h5>
            <div class="form-group">
                <div class="col-md-12">
                    <asp:GridView ID="gvNoPreferenceSpecified" runat="server" CssClass="table-condensed" OnRowDataBound="gvNoPreferenceSpecified_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="PREFERENCE">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlPreference" runat="server">
                                        <asp:ListItem>Select</asp:ListItem>
                                        <asp:ListItem>1</asp:ListItem>
                                        <asp:ListItem>2</asp:ListItem>
                                        <asp:ListItem>3</asp:ListItem>
                                        <asp:ListItem>4</asp:ListItem>
                                        <asp:ListItem>5</asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-12">
                    <asp:Button ID="btnUpdatePreferences" runat="server" Text="Update Preferences" OnClick="btnUpdatePreferences_Click" CssClass="btn-sm" />
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>