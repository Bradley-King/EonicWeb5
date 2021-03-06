CREATE VIEW [dbo].[vw_CartOverViewPages]
AS
SELECT     dbo.vw_CartOverView.nCartOrderKey, dbo.vw_CartOverView.cCartSchemaName, dbo.vw_CartOverView.nCartStatus, dbo.vw_CartOverView.cCurrency, 
                      dbo.vw_CartOverView.nCartItemKey, dbo.vw_CartOverView.nQuantity, dbo.vw_CartOverView.nLinePrice, dbo.vw_CartOverView.nContentKey, 
                      dbo.vw_CartOverView.cContentSchemaName, dbo.vw_CartOverView.cContentName, dbo.vw_CartOverView.dCartDate, YEAR(dbo.vw_CartOverView.dCartDate) AS Year, 
                      MONTH(dbo.vw_CartOverView.dCartDate) AS Month, { fn WEEK(dbo.vw_CartOverView.dCartDate) } AS Week, DAY(dbo.vw_CartOverView.dCartDate) AS Day, 
                      dbo.tblContentLocation.nStructId, dbo.tblContentLocation.bPrimary, dbo.tblContentLocation.bCascade
FROM         dbo.vw_CartOverView LEFT OUTER JOIN
                      dbo.tblContentLocation ON dbo.vw_CartOverView.nContentKey = dbo.tblContentLocation.nContentId




