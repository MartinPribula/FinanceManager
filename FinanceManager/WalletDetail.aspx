<%@ Page Title="Peňaženka" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WalletDetail.aspx.cs" Inherits="FinanceManager.WalletDetail" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <asp:UpdatePanel runat="server" ID="upCreateWallet">
        <ContentTemplate>
            <hgroup class="title">
                <h1><%: Title %>.</h1>
                <h2>Tu vidíte stav vašej peňaženky a jednotlivé účty.</h2>
            </hgroup>
            <p>
                <a href="CreateTransaction.aspx?id=<%=idWallet%>">Pridať transakciu.</a>
            </p>
            <table>
                <tr>
                    <td>Typ transakcie:</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlCategory" AutoPostBack="true" />
                    </td>
                    <td>
                        <asp:Button runat="server" ID="btnClearCategory" Text="Všetky" OnClick="btnClearCategory_Click" />
                    </td>
                </tr>
                <tr>
                    <td>Typ transakcie:</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlAccounts" AutoPostBack="true" />
                    </td>
                </tr>
                <tr>
                    <td>Vytvorené od - do:</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFrom" AutoPostBack="true" Width="150px" TextMode="Date" />
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtTo" AutoPostBack="true" Width="150px" TextMode="Date" />
                    </td>
                </tr>
                <%--<tr>
                    <td>
                        <asp:Button runat="server" ID="btnFilter" Text="Filtruj" OnClick="btnFilter_Click" />
                    </td>
                </tr>--%>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:GridView runat="server" ID="gwTransactionsResults" AllowPaging="false" AllowSorting="false" PageSize="40" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <%# Eval(TableColumns.IdTransaction) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <%# Eval(TableColumns.TransactionCategory) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <%# Eval(TableColumns.Ammount)%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <%# Eval(TableColumns.CreationDate) %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>


</asp:Content>
