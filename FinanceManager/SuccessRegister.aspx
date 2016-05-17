<%@ Page Title="Registrácia" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SuccessRegister.aspx.cs" Inherits="FinanceManager.SuccessRegister"%>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
     <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>Vitajte <asp:Label ID="lbUserName" runat="server"></asp:Label></h2>
        
    </hgroup>
    <article>
        <p>
           Vaša registrácia prebehla úspešne. 
        </p>
        <p>
            Avšak stále nemáte vytvorenú vašu peňaženku, kde si budete zaznamenávať vaše transakcie.
            Peňaženku si môžete vytvoriť 
            <asp:HyperLink runat="server" ID="HlCreateWallet" ViewStateMode="Disabled">tu.</asp:HyperLink>
        </p>  
    </article>
</asp:Content>
