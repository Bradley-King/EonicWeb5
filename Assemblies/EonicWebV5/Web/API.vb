﻿Option Strict Off
Option Explicit On

Imports System.Xml
Imports System.Web.HttpUtility
Imports System.Web.Configuration
Imports System.IO
Imports System.Collections
Imports System.Threading
Imports System.Data
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.Net
Imports System.Text.RegularExpressions
Imports System.Collections.Specialized
Imports VB = Microsoft.VisualBasic
Imports System

Public Class API
    Inherits Base

    Public Sub New()

        MyBase.New(System.Web.HttpContext.Current)
        InitialiseVariables()

    End Sub

    Public Sub InitialiseVariables()
        PerfMon.Log("API", "Open")
        Dim sProcessInfo As String = ""
        Dim cCloneContext As String = ""
        Dim rootPageIdFromConfig As String = ""
        Try

            'if we access base via soap the session is not available
            If Not moSession Is Nothing Then

                'below code has beem moved to membership base provider

                Dim oMembershipProv As New Providers.Membership.BaseProvider(Me, moConfig("MembershipProvider"))
                mnUserId = oMembershipProv.Activities.GetUserId(Me)

            End If

            'We need the userId placed into dbhelper.
            'moDbHelper.mnUserId = mnUserId

            

        Catch ex As Exception

            OnComponentError(Me, New Eonic.Tools.Errors.ErrorEventArgs(mcModuleName, "Open", ex, sProcessInfo))

        End Try

    End Sub

    Public Overridable Sub JSONRequest()

        PerfMon.Log("API", "Request")
        Dim sProcessInfo As String = ""
        Try

            Dim path As String = moRequest.ServerVariables("HTTP_X_ORIGINAL_URL")
            Dim pathsplit() As String = Split(path, "/")
            'URL = /API/ProviderName/methodName

            Dim ProviderName As String = pathsplit(2)
            Dim methodName As String = pathsplit(3)
            Dim classPath As String = ProviderName & ".JSONActions"
            Dim assemblytype As String = ""

            Dim s As Stream = moRequest.InputStream
            Dim sr As New StreamReader(s)
            Dim jObj As Newtonsoft.Json.Linq.JObject = Newtonsoft.Json.Linq.JObject.Parse(sr.ReadLine())

            Dim calledType As Type

            If ProviderName <> "" Then
                'case for external Providers
                Dim moPrvConfig As Eonic.ProviderSectionHandler = WebConfigurationManager.GetWebApplicationSection("eonic/messagingProviders")
                Dim assemblyInstance As [Assembly] = [Assembly].LoadFrom(goServer.MapPath(moPrvConfig.Providers(ProviderName).Parameters("path")))
                'Dim assemblyInstance As [Assembly] = [Assembly].Load(moPrvConfig.Providers(ProviderName).Type)
                calledType = assemblyInstance.GetType(classPath, True)
            Else
                'case for methods within EonicWeb Core DLL
                calledType = System.Type.GetType(classPath, True)
            End If

            Dim o As Object = Activator.CreateInstance(calledType)

            Dim args(1) As Object
            args(0) = Me
            args(1) = jObj

            Dim myResponse As String = calledType.InvokeMember(methodName, BindingFlags.InvokeMethod, Nothing, o, args)

            moResponse.Write(myResponse)

        Catch ex As Exception
            OnComponentError(Me, New Eonic.Tools.Errors.ErrorEventArgs(mcModuleName, "JSONRequest", ex, sProcessInfo))
            'returnException(mcModuleName, "getPageHtml", ex, gcEwSiteXsl, sProcessInfo, gbDebug)
            moResponse.Write(msException)
            Me.Finalize()
        Finally

        End Try
        PerfMon.Write()
    End Sub

End Class
