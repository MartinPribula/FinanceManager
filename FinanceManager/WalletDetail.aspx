﻿<%@ Page Title="Peňaženka" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WalletDetail.aspx.cs" Inherits="FinanceManager.WalletDetail" %>




<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/JQPlot/jquery.jqplot.min.js" type="text/javascript"></script>
    <script src="Scripts/JQPlot/jqplot.canvasTextRenderer.js" type="text/javascript"></script>
    <script src="Scripts/JQPlot/jqplot.canvasAxisTickRenderer.js" type="text/javascript"></script>
    <script src="Scripts/JQPlot/jqplot.categoryAxisRenderer.js" type="text/javascript"></script>
    <script src="Scripts/JQPlot/jqplot.pointLabels.js" type="text/javascript"></script>
    <script src="Scripts/JQPlot/jqplot.barRenderer.js" type="text/javascript"></script>
    <script src="Scripts/JQPlot/jqplot.pieRenderer.js" type="text/javascript"></script>
    <link href="Scripts/JQPlot/jquery.jqplot.min.css" rel="stylesheet" type="text/css" />



    <asp:UpdatePanel runat="server" ID="upCreateWallet">
        <ContentTemplate>

            <hgroup class="title">
                <h1><%: Title %>.</h1>
                <h2>Tu vidíte stav vašej peňaženky a jednotlivé účty.</h2>
            </hgroup>
            <p>
                <a href="CreateTransaction.aspx?id=<%=idWallet%>">Pridať transakciu.</a>
            </p>

            <asp:Panel ID="ContentPanel" runat="server">
                <%--<script src="Scripts/MyScripts/PieChartCategories.js" type="text/javascript"></script>--%>
                <div id="chartBalanceProgress" style="margin-top: 20px; margin-left: 20px; width: 650px; height: 350px; float: left"></div>
                <div id="chartCategoryDistribution" style="margin-top: 20px; margin-left: 20px; width: 400px; height: 400px; margin-right: 10px; float: right"></div>
            </asp:Panel>

            <table>
                <tr>
                    <td>Typ transakcie:</td>
                    <td colspan="2">
                        <asp:CheckBoxList runat="server" ID="cblTransactionCategories" AutoPostBack="true" RepeatDirection="Horizontal" class="transType">
                        </asp:CheckBoxList>
                    </td>
                    <td>
                        <asp:Button runat="server" ID="btnClearCategory" Text="Všetky" Visible="false" OnClick="btnClearCategory_Click" />
                    </td>
                </tr>
                <tr>
                    <td>Účet:</td>
                    <td colspan="2">
                        <asp:CheckBoxList runat="server" ID="cblAccounts" AutoPostBack="true" RepeatDirection="Horizontal" class="transType">
                        </asp:CheckBoxList>
                    </td>
                    <td>
                        <asp:Button runat="server" ID="btnClearAccount" Text="Všetky" Visible="false" OnClick="btnClearAccounts_Click" />
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
            <asp:GridView runat="server" ID="gwTransactionsResults" AllowPaging="false" AllowSorting="false" PageSize="150" AutoGenerateColumns="false">
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
                            <%# Eval(TableColumns.AccountName) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <%# Eval(TableColumns.CreationDate) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>



</asp:Content>
