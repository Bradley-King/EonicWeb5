<%@ WebHandler Language="VB" Class="migrate" %>

Imports System
Imports System.Web
Imports System.xml

Public Class migrate : Implements IHttpHandler, IRequiresSessionState
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        'Dim oEw As Eonic.Setup = New Eonic.Setup
        'Dim oPageXml As XmlDocument = New XmlDocument
        'Dim oPageElmt As XmlElement
        
        'oPageXml.CreateXmlDeclaration("1.0", "UTF-8", "yes")
        'oPageElmt = oPageXml.CreateElement("Page")
        'oPageXml.AppendChild(oPageElmt)
        
        'oEw.open(oPageXml)
       
        'context.Response.ContentType = "text/html"
        'oEw.setupProcess()

        'oEw = Nothing

    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class