<%@ Page Title="Prihlásenie" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FinanceManager.Login" %>
<asp:Content  ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>Prihláste sa.</h2>
    </hgroup>
    <fieldset>
        <legend>Prihlásenie</legend>
        <ol>
            <li>
                <asp:Label ID="lbUserName" runat="server" AssociatedControlID="tbUserName">Prihlasovacie meno:</asp:Label>
                <asp:TextBox ID="tbUserName" runat="server" />
                <asp:RequiredFieldValidator runat="server" ID="rfvUserName" ControlToValidate="tbUserName" CssClass="field-validation-error" ErrorMessage="Vyplňte prihlasovacie meno!" />
            </li>
            <li>
                <asp:Label ID="lbPassword" runat="server" AssociatedControlID="tbPassword">Heslo:</asp:Label>
                <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" />
                <asp:RequiredFieldValidator runat="server" ID="rfvPassword" ControlToValidate="tbPassword" CssClass="field-validation-error" ErrorMessage="Zadajte heslo!" />
                <asp:CustomValidator runat="server" ID="cvPassword" ControlToValidate="tbPassword" OnServerValidate="ValidatePassword"  CssClass="field-validation-error" ErrorMessage="Nesprávne heslo!" />
            </li>
            <li>
                <asp:Button runat="server" ID="btLogin" Text="Prihlás ma!" OnClick="btnLogin_Click"/>
            </li>
        </ol>
    </fieldset>
</asp:Content>

