<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="EnrollInCourses.aspx.cs" Inherits="EnrollInCourse" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-horizontal">
        <h4 class="col-md-offset-1"><span style="text-decoration: underline; color: #990000">Enroll in Courses</span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label col-md-offset-1"></asp:Label>
        <hr />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtStudentId" CssClass="col-md-3 control-label">Enter your student id:</asp:Label>
            <div class="col-md-2">
                <asp:TextBox ID="txtStudentId" runat="server" MaxLength="8" CssClass="form-control input-sm" TextMode="Number" ToolTip="Student id"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ErrorMessage="Please enter a valid student id." ControlToValidate="txtStudentId" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationGroup="ValidateStudentId"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Please enter exactly 8 digits."
                    ControlToValidate="txtStudentId" CssClass="text-danger" Display="Dynamic" ValidationExpression="^\d{8}$" EnableClientScript="False" ValidationGroup="ValidateStudentId"></asp:RegularExpressionValidator>
                <asp:CustomValidator ID="cv_studentId" runat="server" ControlToValidate="txtStudentId" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" OnServerValidate="cv_studentId_ServerValidate" ValidationGroup="ValidateStudentId"></asp:CustomValidator>
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnFindAvailableCourses" runat="server" OnClick="btnFindAvailableCourses_Click"
                    Text="Find Available Courses" CssClass="btn-sm" ValidationGroup="ValidateStudentId" />
            </div>
        </div>
        <asp:Panel ID="pnlAvailableCourses" runat="server" Visible="False">
            <hr />
            <div class="form-group">
                <div class="col-md-offset-1 col-md-10">
                    <asp:GridView ID="gvAvailableCourses" runat="server" BorderWidth="2px" CssClass="table-condensed" BorderStyle="Solid" 
                        Caption="<b>Courses You Can Enroll In</b>" CaptionAlign="Top" CellPadding="3" HorizontalAlign="Justify">
                        <Columns>
                            <asp:TemplateField HeaderText="Select">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkRow" runat="server" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click"
                        Text="Submit" CssClass="btn-sm" />
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>