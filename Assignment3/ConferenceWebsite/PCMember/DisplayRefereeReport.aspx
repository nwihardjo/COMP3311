<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DisplayRefereeReport.aspx.cs" Inherits="PCMember_DisplayRefereeReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style type="text/css">
        input, select, textarea {
            max-width: 600px;
        }
    </style>
    <div class="form-horizontal">
        <h4><span style="text-decoration: underline; color: #800000" class="h4"><strong>Display Referee Report/Discussionn — Add Discussion</strong></span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label"></asp:Label>
        <asp:Panel ID="pnlInputPCCode" runat="server">
            <hr />
            <div class="form-group">
                <asp:Label runat="server" Text="PC code:" AssociatedControlID="txtPCCode" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-1">
                    <asp:TextBox ID="txtPCCode" runat="server" CssClass="form-control input-sm" MaxLength="4" AutoPostBack="True" OnTextChanged="txtPCCode_TextChanged"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnGetRefereeReports" runat="server" OnClick="btnGetRefereeReports_Click" Text="Get My Referee Reports" CssClass="btn-sm" />
                </div>
                <asp:Panel ID="pnlSubmissionNumber" runat="server" Visible="False">
                    <asp:Label runat="server" Text="Submission:" AssociatedControlID="ddlSubmissionNumber" CssClass="control-label col-md-2"></asp:Label>
                    <div class="col-md-1">
                        <asp:DropDownList ID="ddlSubmissionNumber" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSubmissionNumber_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                </asp:Panel>
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
        <asp:Panel ID="pnlRefereeReport" runat="server" Visible="False">
            <hr />
            <div class="form-group">
                <asp:Label runat="server" Text="Title:" AssociatedControlID="txtTitle" CssClass="control-label col-md-2"></asp:Label>
                <div>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control-static col-md-10" BorderStyle="None" ReadOnly="True" Width="100%" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Author(s):" AssociatedControlID="txtAuthor" CssClass="control-label col-md-2"></asp:Label>
                <div>
                    <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control-static col-md-10" BorderStyle="None" ReadOnly="True" Width="100%" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="The paper is relevant to the conference:" AssociatedControlID="txtRelevant" CssClass="control-label col-md-5"></asp:Label>
                <div>
                    <asp:TextBox ID="txtRelevant" runat="server" CssClass="form-control-static col-md-1" BorderStyle="None" ReadOnly="True"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="The paper is technically correct:" AssociatedControlID="txtTechnicallyCorrect" CssClass="control-label col-md-5"></asp:Label>
                <div>
                    <asp:TextBox ID="txtTechnicallyCorrect" runat="server" CssClass="form-control-static col-md-1" BorderStyle="None" ReadOnly="True"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="The length and content of the paper are<br/>comparable to the expected final version:" AssociatedControlID="txtLengthAndContent" CssClass="control-label col-md-5"></asp:Label>
                <div class="col-md-2">
                    <asp:TextBox ID="txtLengthAndContent" runat="server" CssClass="form-control-static col-md-1" BorderStyle="None" ReadOnly="True" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Originality" AssociatedControlID="txtOriginality" CssClass="control-label col-md-2" Style="text-align: center"></asp:Label>
                <asp:Label runat="server" Text="Impact" AssociatedControlID="txtImpact" CssClass="control-label col-md-2" Style="text-align: center"></asp:Label>
                <asp:Label runat="server" Text="Presentation" AssociatedControlID="txtPresentation" CssClass="control-label col-md-2" Style="text-align: center"></asp:Label>
                <asp:Label runat="server" Text="Technical Depth" AssociatedControlID="txtTechnicalDepth" CssClass="control-label col-md-2" Style="text-align: center"></asp:Label>
                <asp:Label runat="server" Text="OVERALL RATING" AssociatedControlID="txtOverallRating" CssClass="control-label col-md-2" Style="text-align: center"></asp:Label>
            </div>
            <div class="form-group">
                <div>
                    <asp:TextBox ID="txtOriginality" runat="server" CssClass="form-control-static col-md-2" BorderStyle="None" ReadOnly="True" Style="text-align: center"></asp:TextBox>
                </div>
                <div>
                    <asp:TextBox ID="txtImpact" runat="server" CssClass="form-control-static col-md-2" BorderStyle="None" ReadOnly="True" Style="text-align: center"></asp:TextBox>
                </div>
                <div>
                    <asp:TextBox ID="txtPresentation" runat="server" CssClass="form-control-static col-md-2" BorderStyle="None" ReadOnly="True" Style="text-align: center"></asp:TextBox>
                </div>
                <div>
                    <asp:TextBox ID="txtTechnicalDepth" runat="server" CssClass="form-control-static col-md-2" BorderStyle="None" ReadOnly="True" Style="text-align: center"></asp:TextBox>
                </div>
                <div>
                    <asp:TextBox ID="txtOverallRating" runat="server" CssClass="form-control-static col-md-2" BorderStyle="None" ReadOnly="True" Style="text-align: center"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Reviewer Confidence:" AssociatedControlID="txtConfidence" CssClass="control-label col-md-3"></asp:Label>
                <div class="col-md-2">
                    <asp:TextBox ID="txtConfidence" runat="server" CssClass="form-control-static col-md-2" BorderStyle="None" ReadOnly="True" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Main<br/>Contribution(s):" AssociatedControlID="txtMainContributions" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtMainContributions" runat="server" Height="60px" MaxLength="300" TextMode="MultiLine" CssClass="form-control-static" BorderStyle="None" ReadOnly="True" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Three strong points of the paper:" AssociatedControlID="txtStrongPoints" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtStrongPoints" runat="server" Height="60px" MaxLength="300" TextMode="MultiLine" CssClass="form-control-static" BorderStyle="None" ReadOnly="True" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Three weak points of the paper:" AssociatedControlID="txtWeakPoints" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtWeakPoints" runat="server" Height="60px" MaxLength="300" TextMode="MultiLine" CssClass="form-contro-static" BorderStyle="None" ReadOnly="True" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Overall Summary:" AssociatedControlID="txtOverallSummary" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtOverallSummary" runat="server" Height="60px" MaxLength="300" TextMode="MultiLine" CssClass="form-contro-static" BorderStyle="None" ReadOnly="True" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Detailed Comments" AssociatedControlID="txtDetailedComments" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtDetailedComments" runat="server" Height="60px" MaxLength="1000" TextMode="MultiLine" CssClass="form-control-static" BorderStyle="None" ReadOnly="True" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Confidential comments to the PC, if any:" AssociatedControlID="txtConfidentialComments" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtConfidentialComments" runat="server" Height="60px" MaxLength="300" TextMode="MultiLine" CssClass="form-control-static" BorderStyle="None" ReadOnly="True" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button ID="btnViewDiscussion" runat="server" OnClick="btnViewDiscussion_Click" Text="View Discussion" CssClass="btn-sm"></asp:Button>
                </div>
            </div>
            <asp:Panel ID="pnlDiscussion" runat="server" Visible="False">
                <hr />
                <h5><span style="text-decoration: underline; color: #800000" class="h5 col-md-offset-1"><strong>Discussion For This Submission</strong></span></h5>
                <div class="form-group">
                    <div class="col-md-offset-1 col-md-11">
                        <asp:GridView ID="gvDiscussion" runat="server" Width="700px" CssClass="table-condensed"></asp:GridView>
                    </div>
                </div>
            </asp:Panel>
        </asp:Panel>
        <asp:Panel ID="pnlAddNewDiscussion" runat="server" Visible="False">
            <h5><span style="text-decoration: underline; color: #800000" class="h5 col-md-offset-1"><strong>Add Comments To This Discussion</strong></span></h5>
            <div class="form-group">
                <div class="col-md-offset-1 col-md-1">
                    <asp:Button ID="btnAddToDiscussion" runat="server" OnClick="btnAddToDiscussion_Click" Text="Add" CssClass="btn-sm" />
                </div>
                <div class="col-md-10">
                    <asp:TextBox ID="txtNewDiscussion" runat="server" Height="50px" MaxLength="200" TextMode="MultiLine" Width="100%"></asp:TextBox>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>