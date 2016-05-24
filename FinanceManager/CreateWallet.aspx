<%@ Page Title="Peňaženka" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateWallet.aspx.cs" Inherits="FinanceManager.CreateWallet" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="upCreateWallet">
        <ContentTemplate>
            <asp:UpdateProgress runat="server" ID="uprCreateWallet" AssociatedUpdatePanelID="upCreateWallet" DisplayAfter="0">

                <ProgressTemplate>
                    <div class="centeredOverlay">
                        <asp:Label runat="server" ID="lblPleaseWait" Text="Prosím čakajte" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <hgroup class="title">
                <h1><%: Title %>.</h1>
                <h2>Vyplňťe formulár a vytvorte si peňaženku.</h2>
            </hgroup>
            <fieldset>
                <legend>YOU!</legend>
                <ol>
                    <li>
                        <asp:Label ID="lbWalletName" runat="server" AssociatedControlID="tbWalletName">Meno peňaženky:</asp:Label>
                        <asp:TextBox ID="tbWalletName" runat="server" />
                        <asp:RequiredFieldValidator runat="server" ID="rfvWalletName" ControlToValidate="tbWalletName" CssClass="field-validation-error" ErrorMessage="Vyplňte meno peňaženky!" />
                    </li>
                    <li>
                        <asp:Label ID="lbCategories" runat="server" AssociatedControlID="cblTransactionCategories">Kategórie treansakcií v peňaženke:</asp:Label>
                        <asp:CheckBoxList runat="server" ID="cblTransactionCategories" AutoPostBack="true" RepeatDirection="Horizontal" class="transType">
                        </asp:CheckBoxList>
                    </li>
                    <li>
                        <asp:Label ID="lbNewCategory" runat="server" AssociatedControlID="tbNewCategory">Pridajte vlastnú kategóriu:</asp:Label>
                        <asp:TextBox ID="tbNewCategory" runat="server" />
                        <asp:Button runat="server" ID="btNewCategory" Text="Pridaj!" OnClick="btnNewCategory_Click" />
                        <asp:CustomValidator runat="server" ID="cvNewCategory" ControlToValidate="tbNewCategory" OnServerValidate="ValidateCategory" CssClass="field-validation-error" ErrorMessage="Kategória už existuje!" />
                    </li>
                    <span class="float-left-fieldset">
                        <fieldset>
                            <legend>Hotovosť</legend>
                            <li>
                                <asp:CheckBox ID="cbAccountCash" runat="server" AutoPostBack="True" OnCheckedChanged="cbAccountCash_checked" Text="Chcem vytvoriť účet pre hotovosť." Checked="true" TextAlign="Left" CssClass="check-box-special" />
                            </li>
                            <li>
                                <asp:Label ID="lbCashAccountName" runat="server" AssociatedControlID="tbCashAccountName">Názov účtu pre hotovosť:</asp:Label>
                                <asp:TextBox ID="tbCashAccountName" runat="server" Text="Hotovosť" />
                            </li>
                            <li>
                                <asp:Label ID="lbCashBalance" runat="server" AssociatedControlID="tbCashBalance">V hotovosti mám:</asp:Label>
                                <asp:TextBox ID="tbCashBalance" runat="server" Text="0" />
                            </li>
                        </fieldset>
                    </span>
                    <span class="float-right-fieldset">
                        <fieldset>
                            <legend>Bankový účet</legend>
                            <li>
                                <asp:CheckBox ID="cbAccountBank" runat="server" AutoPostBack="True" OnCheckedChanged="cbAccountBank_checked" Text="Chcem vytvoriť bankový účet." Checked="true" TextAlign="Left" CssClass="check-box-special" />
                            </li>
                            <li>
                                <asp:Label ID="lbBankAccountName" runat="server" AssociatedControlID="tbBankAccountName">Názov bankového účtu:</asp:Label>
                                <asp:TextBox ID="tbBankAccountName" runat="server" Text="Bankový účet" />
                            </li>
                            <li>
                                <asp:Label ID="lbBankBalance" runat="server" AssociatedControlID="tbBankBalance" AutoPostBack="True">Na účte mám:</asp:Label>
                                <asp:TextBox ID="tbBankBalance" runat="server" Text="0" />
                            </li>
                        </fieldset>
                    </span>
                    <li>
                        <asp:Button runat="server" ID="btCreateWallet" Text="Vytvor!" OnClick="btnCreateWallet_Click" CssClass="float-left" />
                    </li>
                </ol>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
