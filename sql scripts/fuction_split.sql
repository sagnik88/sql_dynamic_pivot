
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 8/1/2016 3:30:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[Split](@String nvarchar(4000), @Delimiter char(1))
RETURNS @Results TABLE (Items nvarchar(4000))
AS
   BEGIN
   DECLARE @INDEX INT
   DECLARE @SLICE nvarchar(4000)
   -- HAVE TO SET TO 1 SO IT DOESNT EQUAL Z
   --     ERO FIRST TIME IN LOOP
   SELECT @INDEX = 1
   -- following line added 10/06/04 as null
   --      values cause issues
   IF @String IS NULL RETURN
   WHILE @INDEX !=0

       BEGIN 
        -- GET THE INDEX OF THE FIRST OCCURENCE OF THE SPLIT
--CHARACTER
        SELECT @INDEX = CHARINDEX(@Delimiter,@STRING)
        -- NOW PUSH EVERYTHING TO THE LEFT OF IT INTO THE SLICE
--VARIABLE
        IF @INDEX !=0
        SELECT @SLICE = LEFT(@STRING,@INDEX - 1)
        ELSE
        SELECT @SLICE = @STRING
        set @slice = rtrim(ltrim(@slice))
        if @slice = null or len(@slice) = 0 set @slice = null
        -- PUT THE ITEM INTO THE RESULTS SET
        INSERT INTO @Results(Items) VALUES(@SLICE)
        -- CHOP THE ITEM REMOVED OFF THE MAIN STRING
        SELECT @STRING = RIGHT(@STRING,LEN(@STRING) - @INDEX)
        -- BREAK OUT IF WE ARE DONE
        IF LEN(@STRING) = 0 BREAK
   END
   RETURN
END
