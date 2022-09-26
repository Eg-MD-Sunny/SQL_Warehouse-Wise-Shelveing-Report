--Available in Shelve

SELECT max(te.ThingId) MaximumThingId,min(te.ThingId) MinimumThingId
FROM ThingEvent te
JOIN ThingTransaction tt on tt.id = te.ThingTransactionId
WHERE tt.CreatedOn >= '2022-09-16 00:00 +6:00'
AND tt.CreatedOn < '2022-09-22 00:00 +6:00'
AND toState in (256,34359738368)

--#########################################################


select  CAST(dbo.ToBdt(tt.CreatedOn) as date) Date,
        CONCAT(DATEPART(HOUR,dbo.ToBdt(tt.CreatedOn)),':',DATEPART(minute,dbo.ToBdt(tt.CreatedOn))) Time,
        pv.id PVID,
		pv.name ProductName,
        dbo.tsn(FromState)FromState,
        dbo.tsn(ToState)ToState,
        e.BadgeId,
		e.FullName,
		d.DesignationName,
		e.WarehouseId [AssignWarehouseId],
        Count (*) Qty

from    ThingTransaction tt
    join ThingEvent te on te.ThingTransactionId=tt.id
    join Thing t on t.id=te.ThingId
    join ProductVariant pv on pv.id=t.ProductVariantId
    left join Employee e on tt.CreatedByCustomerId=e.Id
    left join Warehouse w on te.WarehouseId=w.Id
    left join Designation d on e.DesignationId=d.Id

where   tt.CreatedOn >= '2022-09-16 00:00 +06:00'
    and tt.CreatedOn < '2022-09-22 00:00 +06:00'
    and toState in (256,34359738368)
	and pv.id in (21474)
    and t.id>=24163081 ------ MinimumThingId
    and t.id<=165766225 ------ MaximumThingId

Group By    CAST(dbo.ToBdt(tt.CreatedOn) as date) ,
            CONCAT(DATEPART(HOUR,dbo.ToBdt(tt.CreatedOn)),':',DATEPART(minute,dbo.ToBdt(tt.CreatedOn))) ,
            pv.id , pv.name ,
            dbo.tsn(FromState),
            dbo.tsn(ToState),
            e.BadgeId, e.FullName, d.DesignationName, e.WarehouseId
Order by 1,2
