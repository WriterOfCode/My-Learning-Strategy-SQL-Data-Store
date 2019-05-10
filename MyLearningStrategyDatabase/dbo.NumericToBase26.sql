CREATE FUNCTION [dbo].[NumericToBase26]
(
	@Number numeric(38,0)
)

RETURNS VARCHAR(24)
AS
BEGIN
	declare @Base		 INT
	declare @Work_Number NUMERIC(38,0)
	declare @Modulus	 INT
	declare @Digits		 VARCHAR(26)
	declare @Output_String	VARCHAR(24)

	if (@Number IS NULL OR @Number>999999999999999999999999999999999)
	BEGIN
		RETURN NULL
	END

	set @Digits = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	set @Output_String = ''
	set @Work_Number = @Number
	set @Base = 26

	while @Work_Number <> 0
		begin
		Set @Modulus = @Work_Number%@Base
		set @Work_Number = round(@Work_Number/@Base,0) 
		set @Output_String = substring(@Digits,@Modulus,1) + @Output_String
		end -- end while


	RETURN @Output_String
END