use BikeStores;

--1. Cho biết khách hàng có mã '1' đã mua bao nhiêu đơn hàng?
select count(order_id) as SoDonHangDaMua  from sales.orders
where customer_id = 1

--2. Cho biết khách hàng có mã '1' đã mua bao nhiêu đơn hàng ở cửa hàng '2'?
select count(order_id) as SoDonHangDaMua from sales.orders
where customer_id = 1 and store_id = 2

--3. Liệt kê thông tin nhân viên của cửa hàng '2'
select * from sales.staffs
where store_id = 2

--4. Cho biết thông tin của quản lý cửa hàng '2'
select * from sales.staffs
where store_id = 2 and staff_id in (
	select manager_id from sales.staffs where store_id = 2
)

--5. Số lượng mặt hàng tên là 'Trek 820 - 2016' bán được?
select sum(quantity) as SoLuongBanDuoc from sales.order_items
inner join production.products on production.products.product_id = sales.order_items.product_id
where product_name1 like '%Trek 820 - 2016%'

--6. Brand tên là 'Trek' (hoặc 'Surly') có bao nhiêu sản phẩm?
select count(product_id) as SoLuong from production.products
where brand_id in (
	select brand_id from production.brands
	where brand_name like 'Trek'
)

--7. Sản phẩm tên là ' Surly Straggler - 2016' còn lại số lượng bao nhiêu, trong kho nào?
select sales.stores.store_name, sum(quantity) as TongSoLuong from production.products
inner join production.stocks on production.products.product_id = production.stocks.product_id
inner join sales.stores on sales.stores.store_id = production.stocks.store_id
where product_name1 like '%Surly Straggler - 2016%'
group by sales.stores.store_id, sales.stores.store_name

--8. Tìm cho khách mặt hàng 'Electra' có giá nhỏ hơn 270 mà còn hàng?
--Store nào còn mặt hàng Electra
select sales.stores.store_name, production.products.list_price, sum(quantity) as TongSoLuong from production.products
inner join production.stocks on production.products.product_id = production.stocks.product_id
inner join sales.stores on sales.stores.store_id = production.stocks.store_id
where product_name1 like '%Electra%' and production.products.list_price < 270
group by sales.stores.store_id, sales.stores.store_name, production.products.list_price

--Nếu quantity = 0 tồn tại trong kho
select production.products.* from production.products, production.stocks
where production.products.product_id = production.stocks.product_id
and product_name1 like '%Electra%' and list_price < 270 and quantity > 0

--Nếu quantity = 0 thì auto  bị xóa trong kho
select production.products.* from production.products
where product_name1 like '%Electra%' and list_price < 270 and product_id in (
	select product_id from production.stocks
)

--9. Cho biết đơn hàng nào mà ngày ship trễ hơn ngày yêu cầu?
select * from sales.orders
where shipped_date > required_date

--10. Doanh số của nhân viên có mã là '2'
select sum(quantity * list_price *(1 - discount)) from sales.order_items
where order_id in (
	select order_id from sales.orders
	where staff_id = 2 and shipped_date is not null
)