
CREATE VIEW [dbo].[vw_CartOverViewGroups]
AS
SELECT     dbo.vw_CartOverView.nCartOrderKey, dbo.vw_CartOverView.cCartSchemaName, dbo.vw_CartOverView.nCartStatus, dbo.vw_CartOverView.cCurrency, 
                      dbo.vw_CartOverView.nCartItemKey, dbo.vw_CartOverView.nQuantity, dbo.vw_CartOverView.nLinePrice, dbo.vw_CartOverView.nContentKey, 
                      dbo.vw_CartOverView.cContentSchemaName, dbo.vw_CartOverView.cContentName, dbo.vw_CartOverView.dCartDate, YEAR(dbo.vw_CartOverView.dCartDate) AS Year, 
                      MONTH(dbo.vw_CartOverView.dCartDate) AS Month, DAY(dbo.vw_CartOverView.dCartDate) AS Day, dbo.tblCartProductCategories.nCatKey, 
                      dbo.tblCartProductCategories.cCatSchemaName, dbo.tblCartProductCategories.cCatName, dbo.tblCartProductCategories.cCatDescription
FROM         dbo.tblCartProductCategories RIGHT OUTER JOIN
                      dbo.tblCartCatProductRelations ON dbo.tblCartProductCategories.nCatKey = dbo.tblCartCatProductRelations.nCatId RIGHT OUTER JOIN
                      dbo.vw_CartOverView ON dbo.tblCartCatProductRelations.nContentId = dbo.vw_CartOverView.nContentKey



