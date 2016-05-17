<%@ Page Title="Vitajte!" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AfterLogin.aspx.cs" Inherits="FinanceManager.AfterLogin" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="upCreateWallet">
        <ContentTemplate>
        <hgroup class="title">
        <h1><%: Title %></h1>
        <h2>Tu vidíte vaše peňaženky</h2>
        </hgroup>
        <asp:Repeater runat="server" ID="repeaterResult">
            <ItemTemplate>
                <table>
                    <tr><th colspan="2"><a href='<%# String.Format("/WalletDetail.aspx?id={0}", Eval(TableColumns.IdWallet)) %>'>
                                Peňaženka: <%# Eval(TableColumns.WalletName) %>
                            </a></th></tr>
                    <tr><td>Stav</td><td><%# Eval(TableColumns.Balance) %> &euro;</td></tr>
                    <tr><td>Posledná úprava</td><td><%# Eval(TableColumns.LastUpdate) %></td></tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
