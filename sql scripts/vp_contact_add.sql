
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROCEDURE dbo.vp_contact_add
	
@contact_name varchar(max),
@contact_address varchar(max),
@contact_phone varchar(max),
@contact_type varchar(max)

AS
BEGIN

if @contact_name is not null

begin
declare @prim_key nvarchar(max)


insert into vp_contact
select @contact_name

SELECT @prim_key=SCOPE_IDENTITY()

if @contact_phone is not null
		begin

				create table #contact_phone(phone_id int identity(1,1) not null,phone_no varchar(max))

				insert into #contact_phone
				SELECT CAST(Items AS varchar(max)) 
				FROM  Split(@contact_phone, ',') 

				insert into vp_contact_phone
				select @prim_key,phone_no from #contact_phone

		end



if @contact_address is not null
		begin
				create table #contact_address(add_id int identity(1,1) not null,address_names varchar(max))

				insert into #contact_address
				SELECT CAST(Items AS varchar(max)) 
				FROM  Split(@contact_address, ',') 


				insert into vp_contact_address
				select @prim_key,address_names from #contact_address
		end


if @contact_type is not null
		begin
				create table #contact_type(add_id int identity(1,1) not null,contact_type varchar(max))

				insert into #contact_type
				SELECT CAST(Items AS varchar(max)) 
				FROM  Split(@contact_type, ',') 


				insert into vp_contact_type
				select @prim_key,contact_type from #contact_type
		end

end


END
GO
/*
exec vp_contact_add
@contact_name ='Arun',
@contact_address ='1323123 scdscdsc 213323, 3242343 ssdsd 234324324, 2343434 scscsdc 2424342',
@contact_phone = '123242424,435345454,3253423423,24242343243,3253535353,24234324234',
@contact_type ='21312,232312'
*/
