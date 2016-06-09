<%@ Page Title="Vitajte v správcovi financií." Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FinanceManager._Default" %>

<%--<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1><%: Title %></h1>
            </hgroup>
            <p>
                Táto aplikácia vám umožnuje sledovať tok vašich finančných prostriedkov.<br>
                Môžete si založiť vašu osobnú peňaženku a v nej zaznamenávať vaše rálne výdavky a príjmy.<br>
                Na využietie tejto funkcionality sa prihláste alebo si založte účet <a href="Register.aspx">tu</a>. 
            </p>
        </div>
    </section>
</asp:Content>--%>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="content-wrapper">
            <hgroup class="title">
                <h1><%: Title %></h1>
            </hgroup>
            <p>
                Táto aplikácia vám umožnuje sledovať tok vašich finančných prostriedkov.<br>
                Môžete si založiť vašu osobnú peňaženku a v nej zaznamenávať vaše rálne výdavky a príjmy.<br>
                Na využietie tejto funkcionality sa prihláste alebo si založte účet <a href="Register.aspx">tu</a>. 
            </p>
        </div>
</asp:Content>
