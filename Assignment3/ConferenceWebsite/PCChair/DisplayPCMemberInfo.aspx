<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DisplayPCMemberInfo.aspx.cs" Inherits="PCChair_DisplayPCMemberInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style type="text/css">
        input, select, textarea {
            max-width: 600px;
        }
    </style>
    <div class="form-horizontal">
        <h4><span style="text-decoration: underline; color: #800000" class="h4"><strong>PC Member Information</strong></span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label"></asp:Label>
        <asp:Panel ID="pnlPCMemberInfo" runat="server">
            <hr />
            <div class="form-group">
                <div class="col-md-12">
                    <asp:GridView ID="gvPCMember" runat="server" CssClass="table-condensed" OnRowDataBound="gvPCMember_RowDataBound">
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="PCCODE" DataNavigateUrlFormatString="EditPCMember.aspx?pcCode={0}" NavigateUrl="~/PCChair/EditPCMember.aspx" Text="Edit" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>