﻿if not Exists(select * from sys.columns where Name = N'nPermLevel' and Object_ID = Object_ID(N'tblCartShippingPermission')) 
BEGIN
ALTER TABLE dbo.tblCartShippingPermission ADD
	nPermLevel int NULL

UPDATE dbo.tblCartShippingPermission SET nPermLevel = 1 where nPermLevel is null

END

