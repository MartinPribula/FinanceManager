<%@ Page Title="Pridaj záznam" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateTransaction.aspx.cs" Inherits="FinanceManager.CreateTransaction" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1><%: Title %></h1>
    </hgroup>
    <asp:UpdatePanel runat="server" ID="upCreateTransaction">
        <ContentTemplate>
            <table>
                <tr>
                    <td>Vyberte účet:</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlAccount" AutoPostBack="true" />
                        <asp:RequiredFieldValidator runat="server" ID="rfvAccount" ControlToValidate="ddlAccount" CssClass="field-validation-error" ErrorMessage="Vyberte účet." />
                    </td>
                </tr>
                <tr>
                    <td>Vyberte kategóriu:</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlCategory" AutoPostBack="true" />
                        <asp:RequiredFieldValidator runat="server" ID="rfvCategory" ControlToValidate="ddlCategory" CssClass="field-validation-error" ErrorMessage="Vyberte kategóriu." />
                    </td>
                </tr>
                <tr>
                    <td>Vytvorené dňa:</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtCreateDate" AutoPostBack="true" Width="150px" TextMode="Date" />
                    </td>
                </tr>
                <tr>
                    <td>Suma:</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAmount" TextMode="Number" AutoPostBack="true" Width="150px" CssClass="money"/>
                        <asp:RequiredFieldValidator runat="server" ID="rfvAmount" ControlToValidate="ddlCategory" CssClass="field-validation-error" ErrorMessage="Zadajte sumu." />
                    </td>
                    <td>Typ záznamu:</td>
                    <td>
                        <div class="transType">
                            <asp:RadioButtonList runat="server" ID="rblTransactionType" AutoPostBack="true" RepeatDirection="Horizontal" RepeatLayout="Table" OnSelectedIndexChanged="rbCategory_Click">
                                <asp:ListItem Text="Prichádzajúca" Value="incoming" />
                                <asp:ListItem Text="Odchádzajúca" Value="outgoing" />
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator runat="server" ID="rfvType" ControlToValidate="ddlCategory" CssClass="field-validation-error" ErrorMessage="Vyberte typ." />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbAtmCash" runat="server" Visible="false" Text="Pripísať k hotovosti:"/>
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlAtmCash" AutoPostBack="true" Width="150px" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td>Popis:</td>
                    <td colspan="3">
                        <asp:TextBox runat="server" ID="tbDescription" AutoPostBack="false" TextMode="MultiLine" Rows="4" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button runat="server" ID="btnNewTransaction" Text="Vytvor" OnClick="btnNewTransaction_Click" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
