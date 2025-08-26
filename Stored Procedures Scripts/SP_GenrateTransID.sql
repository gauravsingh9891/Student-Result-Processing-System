--Create Sequence For Pay_Seq
Create Sequence Pay_Seq
Start with 1
Increment By 1
Maxvalue 99999999999999

Create Or Alter Procedure SP_GenrateTransID
@NewTransID Varchar(23) OUTPUT
AS
Begin
	--Logic to get Year in 4 digit 
	Declare @Year Varchar(4)=Year(Getdate())
	SET @NewTransID='TXT-'+@Year+'-'+Right('00000000000000'+CAST((Next Value For Pay_Seq) as Varchar),14)
End

Declare @NewTranID Varchar(23)
Execute SP_GenrateTransID @NewTranID OUTPUT
Print @NewTranID