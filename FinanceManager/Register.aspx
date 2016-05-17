<%@ Page Title="Registrácia" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FinanceManager.Register" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>Vytvorte si účet pomocou formulára.</h2>
    </hgroup>
    <asp:UpdatePanel runat="server" ID="upRegister">
        <ContentTemplate>
            <asp:UpdateProgress runat="server" ID="uprRegister" AssociatedUpdatePanelID="upRegister" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="centeredOverlay">
                        <asp:Label runat="server" ID="lblPleaseWait" Text="Prosím čakajte" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>

            <fieldset>
                <legend>Registračný formulár.</legend>
                <ol>
                    <li>
                        <asp:Label ID="lbUserName" runat="server" AssociatedControlID="tbUserName">Prihlasovacie meno:</asp:Label>
                        <asp:TextBox ID="tbUserName" runat="server" AutoPostBack="True" OnTextChanged="ValidateUserName_Leave"/>
                        <asp:RequiredFieldValidator runat="server" ID="rfvUserName" ControlToValidate="tbUserName" CssClass="field-validation-error" ErrorMessage="Vyplňte prihlasovacie meno!" />
                        <asp:CustomValidator runat="server" ID="cvUserName" ControlToValidate="tbUserName" OnServerValidate="ValidateUserName" CssClass="field-validation-error" ErrorMessage="Meno sa už používa, vyberte si iné." />
                    </li>
                    <li>
                        <asp:Label ID="lbFirstName" runat="server" AssociatedControlID="tbFirstName">Krstné meno:</asp:Label>
                        <asp:TextBox ID="tbFirstName" runat="server" />
                        <asp:RequiredFieldValidator runat="server" ID="rfvFirstName" ControlToValidate="tbFirstName" CssClass="field-validation-error" ErrorMessage="Vyplňte krstné meno!" />
                    </li>
                    <li>
                        <asp:Label ID="lbLastName" runat="server" AssociatedControlID="tbLastName">Priezvisko:</asp:Label>
                        <asp:TextBox ID="tbLastName" runat="server" />
                        <asp:RequiredFieldValidator runat="server" ID="rfvLastName" ControlToValidate="tbLastName" CssClass="field-validation-error" ErrorMessage="Vyplňte priezvisko!" />
                    </li>
                    <li>
                        <asp:Label ID="lbEmail" runat="server" AssociatedControlID="tbEmail">Email:</asp:Label>
                        <asp:TextBox ID="tbEmail" runat="server" TextMode="Email" />
                        <asp:RequiredFieldValidator runat="server" ID="rfvEmail" ControlToValidate="tbEmail" CssClass="field-validation-error" ErrorMessage="Vyplňte email!" />
                    </li>
                    <li>
                        <asp:Label ID="lbPassword" runat="server" AssociatedControlID="tbPassword">Heslo:</asp:Label>
                        <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ID="rfvPassword" ControlToValidate="tbPassword" CssClass="field-validation-error" ErrorMessage="Zadajte heslo!" />
                    </li>
                    <li>
                        <asp:Label ID="lbConfirmPassword" runat="server" AssociatedControlID="tbConfirmPassword">Potvrďte heslo:</asp:Label>
                        <asp:TextBox ID="tbConfirmPassword" runat="server" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ID="rfvConfirmPassword" ControlToValidate="tbConfirmPassword" CssClass="field-validation-error" ErrorMessage="Potvrďte heslo!" />
                        <asp:CompareValidator runat="server" ID="cvConfirmPassword" ControlToValidate="tbConfirmPassword" ControlToCompare="tbPassword" CssClass="field-validation-error" ErrorMessage="Heslá sa musia zhodovať!" />
                    </li>
                    <li>
                        <asp:Button runat="server" ID="btRegister" Text="Registruj ma!" OnClick="btnRegister_Click" />
                    </li>
                </ol>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
