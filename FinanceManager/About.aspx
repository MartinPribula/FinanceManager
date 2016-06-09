<%@ Page Title="Informácie" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="FinanceManager.About" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>O projekte finančný manažér</h2>
    </hgroup>

    <article>
        <p>        
            Táto aplikácia vznikla ako ročníkový projekt autora Martina Pribulu na Univerzite Komenského.
        </p>
        <p>        
            Úlohou aplikácie je zaznamenávať informácie o financiách používateľa a poskytovať mu lepší pohľad na jeho prímy a výdavky.
        </p>
        <p>        
            V prípade chýb aplikácie sa obráťte na autora: martin.pribula8@gmail.com
        </p>
    </article>


</asp:Content>