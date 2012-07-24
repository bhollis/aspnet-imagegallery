# ASP.NET Image Gallery Control

This rather simple ASP.NET control allows you to embed an image gallery in any ASP.NET page, complete with thumbnails and directory browsing. The gallery will show all the JPG, GIF, and PNG images in a folder, and add links to all the subfolders. It also includes automatic breadcrumb navigation. The code is based off some stuff I found on the 'net, but I can't remember exactly where. This is sort of an early release scraped from code I'm actually using. I may be able to pretty it up in the future.

The control comes in two parts: the `imagegallery` user control, and the thumbnail generator. For a simple install, just copy the "thumbnail" files to the same folder as the page you want to host the gallery, and copy the `imagegallery` control to wherever you usually put controls.

Simply add this control to your pages like this:

```aspnet
<%@ Register TagPrefix="brh" TagName="imagegallery" Src="~/imagegallery.ascx" %>
...
<brh:imagegallery BreadcrumbClass="gallerybreadcrumb" BaseImagePath="~/pictures/gallery/" MaxImageWidth="100" MaxImageHeight="100" ShowName="True" ShowSize="True" ShowFileSize="True" ShowDate="True"  runat="server" />
```

This will create an image gallery. There are a few properties to be aware of:

* `BreadCrumbClass` - This is the CSS class that will be applied to the "breadcrumb" navigation.
* `BaseImagePath` - This is the relative path to the folder you want to use as the root of your gallery.
* `MaxImageWidth` - All thumbnails will be scaled so their width is less than or equal to this value, in pixels.
* `MaxImageHeight` - All thumbnails will be scaled so their height is less than or equal to this value, in pixels.
* `ShowName` - Determines whether or not to show the filename under the thumbnail.
* `ShowSize` - Determines whether or not to show the picture's dimensions (in pixels) under the thumbnail.
* `ShowFileSize` - Determines whether or not to show the picture's file size (in KB) under the thumbnail.
* `ShowDate` - Determines whether or not to show the picture's last modified date under the thumbnail.

## Step By Step

1. [Download](https://github.com/bhollis/aspnet-imagegallery/downloads) the control.
1. Unzip the archive and copy the four files `imagegallery.ascx`, `imagegallery.ascx.cs`, and `thumbnail.ashx` into your web site's directory.
2. Register the tag, as shown in the code above.
3. Put the tag where you want the gallery, and set the appropriate options.
4. Style it up in CSS to make it pretty.