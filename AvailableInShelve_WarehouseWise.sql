select e.BadgeId [CDBD],
		E.FullName [Name],
		dw.id [DeliveryWarehouseId],
		dw.name [DeliveryWarehouseName],
		ew.id [EmployeeAssignWarehouseId],
		ew.name [EmployeeAssignWarehouseName]

from ThingRequest tr 
join Shipment s on s.id = tr.shipmentId
join Warehouse dw on dw.id = s.warehouseId
join Employee e on e.Id = s.deliveredByCustomerId
left join Warehouse ew on ew.id = e.warehouseId


where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-06-01 00:00 +06:00'
and s.ReconciledOn < '2022-06-13 00:00 +06:00'
and ew.id <> dw.id

group by e.BadgeId ,
		 E.FullName ,
		dw.id ,
		dw.name ,
		ew.id ,
		ew.name 








--select top 10 *
--from Employee 

--select top 10 *
--from Shipment 