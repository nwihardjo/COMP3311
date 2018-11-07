<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AssignSubmissionToPCMember.aspx.cs" Inherits="PCChair_AssignSubmissionToPCMember" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style type="text/css">
        input, select, textarea {
            max-width: 600px;
        }
    </style>
    <div class="form-horizontal">
        <h4><span style="text-decoration: underline; color: #800000" class="h4"><strong>Assign Submission To PC Member</strong></span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label"></asp:Label>
        <asp:Panel ID="pnlSelectSubmission" runat="server">
            <hr />
            <div class="form-group">
                <asp:Label runat="server" Text="Submission:" CssClass="control-label col-md-2" AssociatedControlID="ddlSubmissionNumbers"></asp:Label>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlSubmissionNumbers" runat="server" OnSelectedIndexChanged="ddlSubmission_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                </div>
                <div>
                    <asp:Label ID="lblTitle" runat="server" CssClass="col-md-8" Visible="False"></asp:Label>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlCurrentlyAssigned" runat="server" Visible="False">
            <hr />
            <h5><span style="text-decoration: underline; color: #800000" class="h5"><strong>PC Members Assigned To This Submission:</strong></span></h5>
            <div class="form-group">
                <div class="col-md-offset-1 col-md-5">
                    <asp:GridView ID="gvCurrentlyAssigned" runat="server" CssClass="table-condensed" BorderStyle="Solid" CellPadding="0" OnRowDataBound="gvCurrentlyAssigned_RowDataBound"></asp:GridView>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Minimum preference:" CssClass="control-label col-md-3" AssociatedControlID="ddlMinimumPreference"></asp:Label>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlMinimumPreference" runat="server"
                        OnSelectedIndexChanged="ddlMinimumPreference_SelectedIndexChanged" AutoPostBack="True" CssClass="dropdown">
                        <asp:ListItem Value="none selected">Select</asp:ListItem>
                        <asp:ListItem Value="None">None</asp:ListItem>
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlAvailableForAssignment" runat="server" Visible="False">
            <hr />
            <h5><span style="text-decoration: underline; color: #800000" class="h5"><strong>PC Members Available To Be Assigned To This Submission:</strong></span></h5>
            <div class="form-group">
                <div class="col-md-offset-1 col-md-5">
                    <asp:GridView ID="gvAvailableForAssignment" runat="server" CssClass="table-condensed" BorderStyle="Solid" CellPadding="0" OnRowDataBound="gvAvailableForAssignment_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="SELECT">
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkSelected" runat="server" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelected" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-1">
                    <asp:Button ID="btnAssignPcMember" runat="server" Text="Assign Selected PC Members" CssClass="btn-sm" OnClick="btnAssignPcMember_Click" />
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>