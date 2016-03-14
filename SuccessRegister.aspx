<%@ Page Title="Registration" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SuccessRegister.aspx.cs" Inherits="FinanceManager.SuccessRegister"%>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
     <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>Welcome <asp:Label ID="lbUserName" runat="server"></asp:Label></h2>
        
    </hgroup>
    <article>
        <p>
           Your registration was successfull. 
        </p>
        <p>
            But you still dont have a wallet with account to save money into. Create one <a href="/CreateWallet.aspx">here.</a>
        </p>  
    </article>
</asp:Content>
