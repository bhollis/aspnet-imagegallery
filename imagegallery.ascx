<%@ Control Language="C#" src="imagegallery.ascx.cs" inherits="Brh.Web.ImageGallery" AutoEventWireup="false" %>
<div class="imagegallery">
  <asp:literal id="top" runat="server" />
  <asp:repeater runat="server" id="dlPictures">
	  <HeaderTemplate>
	    <ul>
		</HeaderTemplate>
    <ItemTemplate>
      <li><%# Container.DataItem %></li>
    </ItemTemplate>
		<FooterTemplate>
	  </ul>
		</FooterTemplate>
  </asp:repeater>
	<div class="cleared"> </div>
</div>
