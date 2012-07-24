<% @ WebHandler language="C#" class="Brh.Web.ImageThumbnail" %>

/*
ImageThumbnail - An ASP.NET page that generates thumbnails of images.
ImageGallery Control - An ASP.NET control to browse a folder of images.


Copyright (c) 2005 Benjamin Hollis

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

using System.Drawing.Imaging;
using System.Drawing;
using System.Web;
using System;

namespace Brh.Web
{
	public class ImageThumbnail : IHttpHandler
	{
    public bool IsReusable
    { get { return true; } }

    public void ProcessRequest(HttpContext ctx)
    {
      if(ctx.Request.QueryString["img"] == null) {
				throw new ArgumentException("img must be set to the path of an image");
			}
			if(ctx.Request.QueryString["h"] == null && ctx.Request.QueryString["w"] == null) {
				throw new ArgumentException("h or w must be set");
			}

			//Read in the image filename to create a thumbnail of
			string imageUrl = ctx.Server.MapPath(ctx.Request.QueryString["img"]);
			string height = ctx.Request.QueryString["h"];
			string width = ctx.Request.QueryString["w"];

			string cacheKey = String.Format("thumbnail_{0}-{1}x{2}", imageUrl, height, width);

			Image outputImage;

			if(ctx.Cache[cacheKey] != null) {
			    outputImage = (Image)ctx.Cache[cacheKey];
			}
			else {
			    Image fullSizeImg;
			    fullSizeImg = Image.FromFile(imageUrl);

			    int imageWidth;
			    int imageHeight;

			    //Read in the width and height
			    if(height == null) {
				    imageWidth = Int32.Parse(width);
				    imageHeight = (int)Math.Round(((double)imageWidth / (double)fullSizeImg.Width) * (double)fullSizeImg.Height);
			    }
			    else if(width == null) {
				    imageHeight = Int32.Parse(height);
				    imageWidth = (int)Math.Round(((double)imageHeight / (double)fullSizeImg.Height) * (double)fullSizeImg.Width);
			    }
			    else {
				    imageHeight = Int32.Parse(height);
				    imageWidth = Int32.Parse(width);
			    }

			    //Do we need to create a thumbnail?
			    if(imageHeight > 0 && imageWidth > 0)
			    {
				    Image.GetThumbnailImageAbort dummyCallback = new Image.GetThumbnailImageAbort(ThumbnailCallback);

				    outputImage = fullSizeImg.GetThumbnailImage(imageWidth, imageHeight, dummyCallback, IntPtr.Zero);
			    }
			    else {
				    outputImage = fullSizeImg;
			    }

			    ctx.Cache.Insert(cacheKey, outputImage);
			}

			ctx.Response.ContentType = "image/jpeg";
			outputImage.Save(ctx.Response.OutputStream, ImageFormat.Jpeg);
        }

		bool ThumbnailCallback()
		{
			return false;
		}
	}
}