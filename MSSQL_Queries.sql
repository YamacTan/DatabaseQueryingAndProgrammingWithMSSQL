-- Yamac TAN - Week 11 - SQL Proje 1

--1: Customers isimli bir veritabaný oluþturunuz.

CREATE DATABASE Customers

CREATE TABLE Customers.dbo.CUSTOMERS (
	master_id varchar(100),
	order_channel varchar(100),
	last_order_channel varchar(50),
	first_order_date date,
	last_order_date date,
	last_order_date_online date,
	last_order_date_offline date,
	order_num_total_ever_online int,
	order_num_total_ever_offline int ,
	customer_value_total_ever_offline float,
	customer_value_total_ever_online float,
	interested_in_categories_12 varchar(255),
	store_type varchar(50)
);

SELECT * from CUSTOMERS


--2: Toplam yapýlan ciroyu getirecek sorguyu yazýnýz.

SELECT SUM(customer_value_total_ever_online + customer_value_total_ever_offline) TOPLAM_CÝRO
FROM CUSTOMERS


--3:  Fatura baþýna yapýlan ortalama ciroyu getirecek sorguyu yazýnýz.

SELECT (SUM(customer_value_total_ever_offline + customer_value_total_ever_online) / SUM(order_num_total_ever_offline +order_num_total_ever_online)) ORTALAMA_CÝRO
FROM CUSTOMERS


--4: Son alýþveriþ platformlarý üzerinden yapýlan alýþveriþlerin toplam ciro daðýlýmlarýný getirecek sorguyu yazýnýz.

--
-- Not: Verisetinde platformlar Online ve Offline olarak, bu platformlara ait kanallar ise Android, ios, Desktop, Mobile ve Offline olarak belirtilmiþtir.
-- Bundan kaynaklý olarak "Platform" üzerine sorgu yapýlan her soruda, offline haricindeki kanallara ait alýþveriþlerin "ONLINE" platformdan yapýldýðý varsayýlmýþtýr. 
--

SELECT SUM(customer_value_total_ever_online + customer_value_total_ever_offline) TOPLAM_CÝRO,
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END AS LAST_PLATFORM
FROM CUSTOMERS
GROUP BY 
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END


--5: Toplam yapýlan fatura adedini getirecek sorguyu yazýnýz.

SELECT COUNT(master_id) TOPLAM_FATURA
FROM CUSTOMERS


--6: Alýþveriþ yapanlarýn son alýþveriþ yaptýklarý platform daðýlýmlarýný fatura cinsinden getirecek sorguyu yazýnýz.

SELECT COUNT(master_id) TOPLAM_FATURA,
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END AS LAST_PLATFORM
FROM CUSTOMERS
GROUP BY CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END


--7: Toplam yapýlan ürün satýþ miktarýný getirecek sorguyu yazýnýz.

SELECT SUM(order_num_total_ever_offline + order_num_total_ever_online) TOPLAM_ALISVERÝS
FROM CUSTOMERS


--8: Yýl kýrýlýmýnda ürün adetlerini getirecek sorguyu yazýnýz.

SELECT DISTINCT(year(first_order_date)) YEAR, SUM(order_num_total_ever_offline + order_num_total_ever_online) URUN_ADETLERÝ
from CUSTOMERS
GROUP BY year(first_order_date)
ORDER BY year(first_order_date)


--9: Platform kýrýlýmýnda ürün adedi ortalamasýný getirecek sorguyu yazýnýz.

SELECT AVG((order_num_total_ever_offline + order_num_total_ever_online)) URUN_ADEDÝ_ORTALAMASI,
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END AS PLATFORM
FROM CUSTOMERS
GROUP BY 
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END


--10: Kaç adet farklý kiþinin alýþveriþ yaptýðýný gösterecek sorguyu yazýnýz.

SELECT COUNT(DISTINCT(master_id)) FARKLI_ALISVERIS_KISI 
FROM Customers 


--11: Son 12 ayda en çok ilgi gören kategoriyi getiren sorguyu yazýnýz.

SELECT TOP 1 interested_in_categories_12 KATEGORÝ, COUNT(interested_in_categories_12) ALISVERÝS_SAYISI 
FROM Customers
GROUP BY interested_in_categories_12
ORDER BY ALISVERÝS_SAYISI DESC


--12:Kanal kýrýlýmýnda en çok ilgi gören kategorileri getiren sorguyu yazýnýz.

SELECT order_channel KANAL, interested_in_categories_12 KATEGORÝ, COUNT(interested_in_categories_12) ALISVERÝS_SAYISI 
FROM Customers
GROUP BY order_channel, interested_in_categories_12
ORDER BY ALISVERÝS_SAYISI DESC


--13: En çok tercih edilen store type’larý getiren sorguyu yazýnýz.

SELECT store_type STORE_TYPE, COUNT(store_type) TERCIH_SAYISI
FROM Customers
GROUP BY store_type
ORDER BY TERCIH_SAYISI DESC


--14: Store type kýrýlýmýnda elde edilen toplam ciroyu getiren sorguyu yazýnýz.

SELECT store_type STORE_TYPE, SUM(customer_value_total_ever_online + customer_value_total_ever_offline) TOPLAM_CÝRO
FROM Customers
GROUP BY store_type
ORDER BY  TOPLAM_CÝRO DESC


--15: Kanal kýrýlýmýnda en çok ilgi gören store type’ý getiren sorguyu yazýnýz.

SELECT TOP 1 order_channel KANAL, store_type STORE_TYPE, COUNT(store_type) TERCIH_SAYISI
FROM Customers
GROUP BY order_channel,store_type
ORDER BY TERCIH_SAYISI DESC


--16: En çok alýþveriþ yapan kiþinin ID’sini getiren sorguyu yazýnýz.

SELECT TOP 1 master_id ID
FROM Customers
GROUP BY master_id
ORDER BY SUM(order_num_total_ever_offline + order_num_total_ever_online) DESC


--17: En çok alýþveriþ yapan kiþinin fatura baþý ortalamasýný getiren sorguyu yazýnýz.

SELECT (SUM(customer_value_total_ever_offline + customer_value_total_ever_online) / SUM(order_num_total_ever_offline + order_num_total_ever_online)) FATURA_BASI_ORTALAMA
FROM Customers
where master_id = '5d1c466a-9cfd-11e9-9897-000d3a38a36f' 


--18: En çok alýþveriþ yapan kiþinin alýþveriþ yapma gün ortalamasýný getiren sorguyu yazýnýz.

SELECT (ABS(DATEDIFF(day, last_order_date , first_order_date)) / (order_num_total_ever_offline + order_num_total_ever_online)) GUN_ORTALAMASI
FROM Customers
where master_id = '5d1c466a-9cfd-11e9-9897-000d3a38a36f' 


--19: En çok alýþveriþ yapan ilk 100 kiþinin(ciro bazýnda) alýþveriþ yapma gün ortalamasýný getiren sorguyu yazýnýz.

SELECT TOP 100 master_id, (customer_value_total_ever_offline + customer_value_total_ever_online) CIRO, (ABS(DATEDIFF(day, last_order_date , first_order_date)) / (order_num_total_ever_offline + order_num_total_ever_online)) GUN_ORTALAMASI
FROM Customers
ORDER BY CIRO DESC


--20: Platfrom kýrýlýmýnda en çok alýþveriþ yapan müþteriyi getiren sorguyu yazýnýz.

SELECT TOP 4 master_id, MAX((order_num_total_ever_offline + order_num_total_ever_online)) ALISVERIS,
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END AS PLATFORM
FROM CUSTOMERS
GROUP BY master_id, 
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END
HAVING (CASE
		WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
		ELSE 'ONLINE'
		END) = 'ONLINE'
ORDER BY MAX((order_num_total_ever_offline + order_num_total_ever_online)) DESC


--21: En son alýþveriþ yapan kiþinin ID’sini getiren sorguyu yazýnýz. (Max son tarihte birden fazla alýþveriþ yapan ID bulunmakta. Bunlarý da getiriniz.)

SELECT master_id, last_order_date TARIH
FROM Customers
WHERE last_order_date = '2021-05-30' -- 30 Mayýs 2021 Database üzerindeki MAX(last_order_date) çýktýsýdýr.


--22: E nson alýþveriþ yapan kiþinin alýþveriþ yapma gün ortalamasýný getiren sorguyu yazýnýz.

SELECT TOP 1 master_id, last_order_date TARIH, (ABS(DATEDIFF(day, last_order_date , first_order_date)) / (order_num_total_ever_offline + order_num_total_ever_online)) GUN_ORTALAMASI
FROM Customers
WHERE last_order_date = '2021-05-30'


--23: Platform kýrýlýmýnda en son alýþveriþ yapan kiþilerin fatura baþýna ortalamasýný getiren sorguyu yazýnýz.

SELECT master_id, last_order_date TARIH,(SUM(customer_value_total_ever_offline + customer_value_total_ever_online) / SUM(order_num_total_ever_offline + order_num_total_ever_online)) FATURA_BASI_ORTALAMA,
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END AS PLATFORM

FROM Customers
WHERE last_order_date = '2021-05-30' -- 30 Mayýs 2021 Database üzerindeki MAX(last_order_date) çýktýsýdýr.

GROUP BY master_id, last_order_date,
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END
ORDER BY FATURA_BASI_ORTALAMA DESC


--24: Ýlk alýþveriþini yapan kiþinin ID’sini getiren sorguyu yazýnýz.

SELECT master_id
FROM Customers
WHERE first_order_date = '2013-01-14' -- 14 Ocak 2013 Database üzerindeki ilk (first_order_date) çýktýsýdýr.


--25: Ýlk alýþveriþ yapan kiþinin alýþveriþ yapma gün ortalamasýný getiren sorguyu yazýnýz.

SELECT TOP 1 master_id, first_order_date, (ABS(DATEDIFF(day, last_order_date , first_order_date)) / (order_num_total_ever_offline + order_num_total_ever_online)) GUN_ORTALAMASI
FROM Customers
WHERE first_order_date = '2013-01-14'-- 14 Ocak 2013 Database üzerindeki ilk (first_order_date) çýktýsýdýr.

