<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="EnrolledCourses.aspx.cs" Inherits="EnrolledCourses" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-horizontal">
        <h4 class="col-md-offset-1"><span style="text-decoration: underline; color: #990000">Enrolled Courses</span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label col-md-offset-1"></asp:Label>
        <hr />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtStudentId" CssClass="col-md-3 control-label">Enter your student id:</asp:Label>
            <div class="col-md-2">
                <asp:TextBox ID="txtStudentId" runat="server" MaxLength="8" CssClass="form-control input-sm" TextMode="Number" ToolTip="Student id"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ErrorMessage="Please enter a valid student id." ControlToValidate="txtStudentId" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Please enter exactly 8 digits."
                    ControlToValidate="txtStudentId" CssClass="text-danger" Display="Dynamic" ValidationExpression="^\d{8}$"></asp:RegularExpressionValidator>
                <asp:CustomValidator ID="cvStudentId" runat="server" ControlToValidate="txtStudentId" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" OnServerValidate="cvStudentId_ServerValidate" Visible="True"></asp:CustomValidator>
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnFindEnrolledCourses" runat="server" OnClick="btnFindEnrolledCourses_Click"
                    Text="Find Enrolled Courses" CssClass="btn-sm" />
            </div>
        </div>
        <asp:Panel ID="pnlEnrolledCourses" runat="server" Visible="False">
            <hr />
            <div class="form-group">
                <div class="col-md-offset-1 col-md-10">
                    <asp:GridView ID="gvEnrolledCourses" runat="server" BorderWidth="2px" CssClass="table-condensed" BorderStyle="Solid" 
                        Caption="<b>Your Enrolled Courses</b>" CaptionAlign="Top" CellPadding="3"></asp:GridView>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>