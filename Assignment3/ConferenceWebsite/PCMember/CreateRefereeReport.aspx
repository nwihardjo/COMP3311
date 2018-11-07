<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="CreateRefereeReport.aspx.cs" Inherits="PCMember_CreateRefereeReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style type="text/css">
        input, select, textarea {
            max-width: 600px;
        }
    </style>
    <div class="form-horizontal">
        <h4><span style="text-decoration: underline; color: #800000" class="h4"><strong>Create Referee Report</strong></span></h4>
        <asp:Label ID="lblResultMessage" runat="server" Font-Bold="True" CssClass="label"></asp:Label>
        <asp:Panel ID="pnlInputPCCode" runat="server">
            <hr />
            <div class="form-group">
                <asp:Label runat="server" Text="PC code:" AssociatedControlID="txtPcCode" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-1">
                    <asp:TextBox ID="txtPCCode" runat="server" CssClass="form-control input-sm" MaxLength="4" AutoPostBack="True" OnTextChanged="txtPCCode_TextChanged"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnGetSubmission" runat="server" OnClick="btnGetSubmission_Click" Text="Get My Submissions for Review" CssClass="btn-sm" ValidationGroup="PCCodeValidation" />
                </div>
                <asp:Panel ID="pnlSubmissionNumbers" runat="server" Visible="False">
                    <asp:Label runat="server" Text="Submission:" AssociatedControlID="ddlSubmissionNumbers" CssClass="control-label col-md-2"></asp:Label>
                    <div class="col-md-1">
                        <asp:DropDownList ID="ddlSubmissionNumbers" runat="server" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlSubmissionNumber_SelectedIndexChanged" CssClass="dropdown">
                        </asp:DropDownList>
                    </div>
                </asp:Panel>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2">
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="A PC code is required." ControlToValidate="txtPCCode" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationGroup="PCCodeValidation"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="Please enter a valid PC code (two lowercase letters followed by two digits)." ControlToValidate="txtPCCode" CssClass="text-danger" Display="Dynamic" EnableClientScript="False" ValidationExpression="^[a-z]{2}[0-9]{2}$" ValidationGroup="PCCodeValidation"></asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="cvPCCodeValidate" runat="server" ErrorMessage="There is no PC member with this PC code." ControlToValidate="txtPCCode"
                        CssClass="text-danger" Display="Dynamic" EnableClientScript="False" OnServerValidate="cvPCCodeValidate_ServerValidate" ValidationGroup="PCCodeValidation"></asp:CustomValidator>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlSubmissionInformation" runat="server" Visible="False">
            <hr />
            <div class="form-group">
                <asp:Label runat="server" Text="Title:" AssociatedControlID="txtTitle" CssClass="control-label col-md-2"></asp:Label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control-static col-md-10" BorderStyle="None" ReadOnly="True" TextMode="MultiLine" Width="100%"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Author(s):" AssociatedControlID="txtAuthor" CssClass="control-label col-md-2"></asp:Label>
                <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control-static col-md-10" BorderStyle="None" ReadOnly="True" TextMode="MultiLine" Width="100%"></asp:TextBox>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlRefereeReport" runat="server" Visible="False">
            <div class="form-group">
                <asp:Label runat="server" Text="Use (Y)es or(N)o and if absolutely necessary (M)aybe to answer the following<br/>(you must explain (N)o and (M)aybe answers in the comments section)." CssClass="col-md-12" Font-Bold="True"></asp:Label>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="The paper is relevant to the conference:" AssociatedControlID="ddlRelevant" CssClass="control-label col-md-4"></asp:Label>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlRelevant" runat="server" CssClass="dropdown">
                        <asp:ListItem Value="Y">Yes</asp:ListItem>
                        <asp:ListItem Value="N">No</asp:ListItem>
                        <asp:ListItem Value="M">Maybe</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="The paper is technically correct:" AssociatedControlID="ddlTechnicallyCorrect" CssClass="control-label col-md-4"></asp:Label>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlTechnicallyCorrect" runat="server" CssClass="dropdown">
                        <asp:ListItem Value="Y">Yes</asp:ListItem>
                        <asp:ListItem Value="N">No</asp:ListItem>
                        <asp:ListItem Value="M">Maybe</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="The length and content of the paper are<br/>comparable to the expected final version:" AssociatedControlID="ddlLengthAndContent" CssClass="control-label col-md-4"></asp:Label>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlLengthAndContent" runat="server" CssClass="dropdown">
                        <asp:ListItem Value="Y">Yes</asp:ListItem>
                        <asp:ListItem Value="N">No</asp:ListItem>
                        <asp:ListItem Value="M">Maybe</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="For the following categories, please assign integer scores from 1 to 5." CssClass="col-md-12" Font-Bold="True"></asp:Label>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Originality" AssociatedControlID="ddlOriginality" CssClass="control-label col-md-2" Style="text-align: center"></asp:Label>
                <asp:Label runat="server" Text="Impact" AssociatedControlID="ddlImpact" CssClass="control-label col-md-2" Style="text-align: center"></asp:Label>
                <asp:Label runat="server" Text="Presentation" AssociatedControlID="ddlPresentation" CssClass="control-label col-md-2" Style="text-align: center"></asp:Label>
                <asp:Label runat="server" Text="Technical Depth" AssociatedControlID="ddlTechnicalDepth" CssClass="control-label col-md-2" Style="text-align: center"></asp:Label>
                <asp:Label runat="server" Text="OVERALL RATING" AssociatedControlID="ddlOverallRating" CssClass="control-label col-md-2" Style="text-align: center"></asp:Label>
            </div>
            <div class="form-group">
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlOriginality" runat="server" CssClass="dropdown">
                        <asp:ListItem Value="1">1 - Reject</asp:ListItem>
                        <asp:ListItem Value="2">2 - Weak Reject</asp:ListItem>
                        <asp:ListItem Value="3">3 - Neutral</asp:ListItem>
                        <asp:ListItem Value="4">4 - Weak Accept</asp:ListItem>
                        <asp:ListItem Value="5">5 - Accept</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlImpact" runat="server" CssClass="dropdown">
                        <asp:ListItem Value="1">1 - Reject</asp:ListItem>
                        <asp:ListItem Value="2">2 - Weak Reject</asp:ListItem>
                        <asp:ListItem Value="3">3 - Neutral</asp:ListItem>
                        <asp:ListItem Value="4">4 - Weak Accept</asp:ListItem>
                        <asp:ListItem Value="5">5 - Accept</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlPresentation" runat="server" CssClass="dropdown">
                        <asp:ListItem Value="1">1 - Reject</asp:ListItem>
                        <asp:ListItem Value="2">2 - Weak Reject</asp:ListItem>
                        <asp:ListItem Value="3">3 - Neutral</asp:ListItem>
                        <asp:ListItem Value="4">4 - Weak Accept</asp:ListItem>
                        <asp:ListItem Value="5">5 - Accept</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlTechnicalDepth" runat="server" CssClass="dropdown">
                        <asp:ListItem Value="1">1 - Reject</asp:ListItem>
                        <asp:ListItem Value="2">2 - Weak Reject</asp:ListItem>
                        <asp:ListItem Value="3">3 - Neutral</asp:ListItem>
                        <asp:ListItem Value="4">4 - Weak Accept</asp:ListItem>
                        <asp:ListItem Value="5">5 - Accept</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlOverallRating" runat="server" CssClass="dropdown">
                        <asp:ListItem Value="1">1 - Reject</asp:ListItem>
                        <asp:ListItem Value="2">2 - Weak Reject</asp:ListItem>
                        <asp:ListItem Value="3">3 - Neutral</asp:ListItem>
                        <asp:ListItem Value="4">4 - Weak Accept</asp:ListItem>
                        <asp:ListItem Value="5">5 - Accept</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Reviewer Confidence (0.5-1):" AssociatedControlID="ddlConfidence" CssClass="control-label col-md-3"></asp:Label>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlConfidence" runat="server" CssClass="dropdown">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>.9</asp:ListItem>
                        <asp:ListItem>.8</asp:ListItem>
                        <asp:ListItem>.7</asp:ListItem>
                        <asp:ListItem>.6</asp:ListItem>
                        <asp:ListItem>.5</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Main<br/>Contribution(s):" AssociatedControlID="txtMainContributions" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtMainContributions" runat="server" Height="50px" MaxLength="300" TextMode="MultiLine" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMainContributions" EnableClientScript="False" ErrorMessage="The main contributions field is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Three strong points of the paper:" AssociatedControlID="txtStrongPoints" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtStrongPoints" runat="server" Height="50px" MaxLength="300" TextMode="MultiLine" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStrongPoints" EnableClientScript="False" ErrorMessage="The three strong points field is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Three weak points of the paper:" AssociatedControlID="txtWeakPoints" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtWeakPoints" runat="server" Height="50px" MaxLength="300" TextMode="MultiLine" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtWeakPoints" EnableClientScript="False" ErrorMessage="The three weak points field is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Overall Summary:" AssociatedControlID="txtOverallSummary" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtOverallSummary" runat="server" Height="50px" MaxLength="300" TextMode="MultiLine" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOverallSummary" EnableClientScript="False" ErrorMessage="The overall summary field is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Detailed Comments:" AssociatedControlID="txtDetailedComments" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtDetailedComments" runat="server" Height="50px" MaxLength="1000" TextMode="MultiLine" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" Text="Confidential comments:" AssociatedControlID="txtConfidentialComments" CssClass="control-label col-md-2"></asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtConfidentialComments" runat="server" Height="50px" MaxLength="300" TextMode="MultiLine" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button ID="btnSubmitReport" runat="server" OnClick="btnSubmitReport_Click" Text="Submit Referee Report" CssClass="btn-sm"></asp:Button>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>