use [Movies]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROCEDURE dbo.vp_contact_list
--exec vp_contact_list	@employee_id=0
@employee_id nvarchar(max)

AS
BEGIN


DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX),
	@add as varchar(max),
	@ph as varchar(max),
	@cols1 AS NVARCHAR(MAX),
	@cols2 as NVARCHAR(MAX),
	@typ varchar(max)
	set @add='address '
	set @ph='Phone Number '
	set @typ='Contact Type '

if @employee_id!=0
		begin
				select @cols = STUFF((SELECT distinct ',' + QUOTENAME(@add+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_address_id) as varchar(max) ) )
									from vp_contact c
									left join vp_contact_address c1 on c.contact_id=c1.contact_id where c1.contact_id=@employee_id
							FOR XML PATH(''), TYPE
							).value('.', 'NVARCHAR(MAX)') 
						,1,1,'')

				select @cols1 = STUFF((SELECT distinct ',' + QUOTENAME(@ph+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_phone_id) as varchar(max) ) )
									from vp_contact c
									left join vp_contact_phone c1 on c.contact_id=c1.contact_id where c1.contact_id=@employee_id
							FOR XML PATH(''), TYPE
							).value('.', 'NVARCHAR(MAX)') 
						,1,1,'')

				select @cols2 = STUFF((SELECT distinct ',' + QUOTENAME(@typ+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_type_id) as varchar(max) ) )
									from vp_contact c
									left join vp_contact_type c1 on c.contact_id=c1.contact_id where c1.contact_id=@employee_id
							FOR XML PATH(''), TYPE
							).value('.', 'NVARCHAR(MAX)') 
						,1,1,'')

				--select @cols2

				set @query = 'SELECT p2.contact_name, ' + @cols + ', ' + @cols1 + ', ' + @cols2 + '  from 
							 (
								select ''address ''+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_address_id) as varchar(max)) as contact_address_type, contact_name, contact_address,c.contact_id
								 from vp_contact c
									left join vp_contact_address c1 on c.contact_id=c1.contact_id where c.contact_id='+@employee_id+'
							) x
							pivot 
							(
								max(contact_address)
								for contact_address_type in (' + @cols + ')
							) p 
			
							left join 

							(SELECT contact_name, ' + @cols1 + ', contact_id from 
							 (
								select ''Phone Number ''+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_phone_id) as varchar(max)) as contact_phone_type, contact_name, contact_phone_number, c.contact_id
								 from vp_contact c
									left join vp_contact_phone c2 on c.contact_id=c2.contact_id where c.contact_id='+@employee_id+'
							) x1
							pivot 
							(
								max(contact_phone_number)
								for contact_phone_type in (' + @cols1 + ')
							) p1 ) p2 on p.contact_id=p2.contact_id

							left join
			
								(SELECT contact_name, ' + @cols2 + ',contact_id from 
							 (
								select ''Contact Type ''+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_type_id) as varchar(max)) as contact_type, contact_name, contact_type_name,c.contact_id
								 from vp_contact c
									left join vp_contact_type c3 on c.contact_id=c3.contact_id where c.contact_id='+@employee_id+'
							) x2
							pivot 
							(
								max(contact_type_name)
								for contact_type in (' + @cols2 + ')
							) p3 ) p4 on p.contact_id=p4.contact_id

							'
				--select @query
		end

else
		begin


			select @cols = STUFF((SELECT distinct ',' + QUOTENAME(@add+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_address_id) as varchar(max) ) )
								from vp_contact c
								left join vp_contact_address c1 on c.contact_id=c1.contact_id 
						FOR XML PATH(''), TYPE
						).value('.', 'NVARCHAR(MAX)') 
					,1,1,'')

			select @cols1 = STUFF((SELECT distinct ',' + QUOTENAME(@ph+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_phone_id) as varchar(max) ) )
								from vp_contact c
								left join vp_contact_phone c1 on c.contact_id=c1.contact_id 
						FOR XML PATH(''), TYPE
						).value('.', 'NVARCHAR(MAX)') 
					,1,1,'')

			select @cols2 = STUFF((SELECT distinct ',' + QUOTENAME(@typ+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_type_id) as varchar(max) ) )
								from vp_contact c
								left join vp_contact_type c1 on c.contact_id=c1.contact_id 
						FOR XML PATH(''), TYPE
						).value('.', 'NVARCHAR(MAX)') 
					,1,1,'')

			--select @cols2

			set @query = 'SELECT p2.contact_name, ' + @cols + ', ' + @cols1 + ', ' + @cols2 + '  from 
						 (
							select ''address ''+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_address_id) as varchar(max)) as contact_address_type, contact_name, contact_address,c.contact_id
							 from vp_contact c
								left join vp_contact_address c1 on c.contact_id=c1.contact_id 
						) x
						pivot 
						(
							max(contact_address)
							for contact_address_type in (' + @cols + ')
						) p 
			
						left join 

						(SELECT contact_name, ' + @cols1 + ', contact_id from 
						 (
							select ''Phone Number ''+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_phone_id) as varchar(max)) as contact_phone_type, contact_name, contact_phone_number, c.contact_id
							 from vp_contact c
								left join vp_contact_phone c2 on c.contact_id=c2.contact_id
						) x1
						pivot 
						(
							max(contact_phone_number)
							for contact_phone_type in (' + @cols1 + ')
						) p1 ) p2 on p.contact_id=p2.contact_id

						left join
			
							(SELECT contact_name, ' + @cols2 + ',contact_id from 
						 (
							select ''Contact Type ''+ cast(ROW_NUMBER () over (partition by c.contact_id order by contact_type_id) as varchar(max)) as contact_type, contact_name, contact_type_name,c.contact_id
							 from vp_contact c
								left join vp_contact_type c3 on c.contact_id=c3.contact_id 
						) x2
						pivot 
						(
							max(contact_type_name)
							for contact_type in (' + @cols2 + ')
						) p3 ) p4 on p.contact_id=p4.contact_id
						'

		end

execute(@query)
END
GO
