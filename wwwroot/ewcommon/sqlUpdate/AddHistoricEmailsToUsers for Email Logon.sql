update tblDirectory set cDirEmail = CAST(cDirXml as XML).value('/User[1]/Email[1]', 'nvarchar(255)') where cDirSchema = 'User' and (cDirEmail is null or cDirEmail = '')