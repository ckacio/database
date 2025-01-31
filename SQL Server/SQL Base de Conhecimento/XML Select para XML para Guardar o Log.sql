


DECLARE @VrOriginal XML

SET @VrOriginal = (
	SELECT 	*
	FROM   sys.objects
	WHERE object_id = 3 for xml auto
)

SELECT @VrOriginal





