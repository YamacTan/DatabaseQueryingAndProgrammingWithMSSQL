-- Yamac TAN - Week 11 - SQL Proje 1

--1: Customers isimli bir veritaban� olu�turunuz.

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


--2: Toplam yap�lan ciroyu getirecek sorguyu yaz�n�z.

SELECT SUM(customer_value_total_ever_online + customer_value_total_ever_offline) TOPLAM_C�RO
FROM CUSTOMERS


--3:  Fatura ba��na yap�lan ortalama ciroyu getirecek sorguyu yaz�n�z.

SELECT (SUM(customer_value_total_ever_offline + customer_value_total_ever_online) / SUM(order_num_total_ever_offline +order_num_total_ever_online)) ORTALAMA_C�RO
FROM CUSTOMERS


--4: Son al��veri� platformlar� �zerinden yap�lan al��veri�lerin toplam ciro da��l�mlar�n� getirecek sorguyu yaz�n�z.

--
-- Not: Verisetinde platformlar Online ve Offline olarak, bu platformlara ait kanallar ise Android, ios, Desktop, Mobile ve Offline olarak belirtilmi�tir.
-- Bundan kaynakl� olarak "Platform" �zerine sorgu yap�lan her soruda, offline haricindeki kanallara ait al��veri�lerin "ONLINE" platformdan yap�ld��� varsay�lm��t�r. 
--

SELECT SUM(customer_value_total_ever_online + customer_value_total_ever_offline) TOPLAM_C�RO,
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


--5: Toplam yap�lan fatura adedini getirecek sorguyu yaz�n�z.

SELECT COUNT(master_id) TOPLAM_FATURA
FROM CUSTOMERS


--6: Al��veri� yapanlar�n son al��veri� yapt�klar� platform da��l�mlar�n� fatura cinsinden getirecek sorguyu yaz�n�z.

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


--7: Toplam yap�lan �r�n sat�� miktar�n� getirecek sorguyu yaz�n�z.

SELECT SUM(order_num_total_ever_offline + order_num_total_ever_online) TOPLAM_ALISVER�S
FROM CUSTOMERS


--8: Y�l k�r�l�m�nda �r�n adetlerini getirecek sorguyu yaz�n�z.

SELECT DISTINCT(year(first_order_date)) YEAR, SUM(order_num_total_ever_offline + order_num_total_ever_online) URUN_ADETLER�
from CUSTOMERS
GROUP BY year(first_order_date)
ORDER BY year(first_order_date)


--9: Platform k�r�l�m�nda �r�n adedi ortalamas�n� getirecek sorguyu yaz�n�z.

SELECT AVG((order_num_total_ever_offline + order_num_total_ever_online)) URUN_ADED�_ORTALAMASI,
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


--10: Ka� adet farkl� ki�inin al��veri� yapt���n� g�sterecek sorguyu yaz�n�z.

SELECT COUNT(DISTINCT(master_id)) FARKLI_ALISVERIS_KISI 
FROM Customers 


--11: Son 12 ayda en �ok ilgi g�ren kategoriyi getiren sorguyu yaz�n�z.

SELECT TOP 1 interested_in_categories_12 KATEGOR�, COUNT(interested_in_categories_12) ALISVER�S_SAYISI 
FROM Customers
GROUP BY interested_in_categories_12
ORDER BY ALISVER�S_SAYISI DESC


--12:Kanal k�r�l�m�nda en �ok ilgi g�ren kategorileri getiren sorguyu yaz�n�z.

SELECT order_channel KANAL, interested_in_categories_12 KATEGOR�, COUNT(interested_in_categories_12) ALISVER�S_SAYISI 
FROM Customers
GROUP BY order_channel, interested_in_categories_12
ORDER BY ALISVER�S_SAYISI DESC


--13: En �ok tercih edilen store type�lar� getiren sorguyu yaz�n�z.

SELECT store_type STORE_TYPE, COUNT(store_type) TERCIH_SAYISI
FROM Customers
GROUP BY store_type
ORDER BY TERCIH_SAYISI DESC


--14: Store type k�r�l�m�nda elde edilen toplam ciroyu getiren sorguyu yaz�n�z.

SELECT store_type STORE_TYPE, SUM(customer_value_total_ever_online + customer_value_total_ever_offline) TOPLAM_C�RO
FROM Customers
GROUP BY store_type
ORDER BY  TOPLAM_C�RO DESC


--15: Kanal k�r�l�m�nda en �ok ilgi g�ren store type�� getiren sorguyu yaz�n�z.

SELECT TOP 1 order_channel KANAL, store_type STORE_TYPE, COUNT(store_type) TERCIH_SAYISI
FROM Customers
GROUP BY order_channel,store_type
ORDER BY TERCIH_SAYISI DESC


--16: En �ok al��veri� yapan ki�inin ID�sini getiren sorguyu yaz�n�z.

SELECT TOP 1 master_id ID
FROM Customers
GROUP BY master_id
ORDER BY SUM(order_num_total_ever_offline + order_num_total_ever_online) DESC


--17: En �ok al��veri� yapan ki�inin fatura ba�� ortalamas�n� getiren sorguyu yaz�n�z.

SELECT (SUM(customer_value_total_ever_offline + customer_value_total_ever_online) / SUM(order_num_total_ever_offline + order_num_total_ever_online)) FATURA_BASI_ORTALAMA
FROM Customers
where master_id = '5d1c466a-9cfd-11e9-9897-000d3a38a36f' 


--18: En �ok al��veri� yapan ki�inin al��veri� yapma g�n ortalamas�n� getiren sorguyu yaz�n�z.

SELECT (ABS(DATEDIFF(day, last_order_date , first_order_date)) / (order_num_total_ever_offline + order_num_total_ever_online)) GUN_ORTALAMASI
FROM Customers
where master_id = '5d1c466a-9cfd-11e9-9897-000d3a38a36f' 


--19: En �ok al��veri� yapan ilk 100 ki�inin(ciro baz�nda) al��veri� yapma g�n ortalamas�n� getiren sorguyu yaz�n�z.

SELECT TOP 100 master_id, (customer_value_total_ever_offline + customer_value_total_ever_online) CIRO, (ABS(DATEDIFF(day, last_order_date , first_order_date)) / (order_num_total_ever_offline + order_num_total_ever_online)) GUN_ORTALAMASI
FROM Customers
ORDER BY CIRO DESC


--20: Platfrom k�r�l�m�nda en �ok al��veri� yapan m��teriyi getiren sorguyu yaz�n�z.

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


--21: En son al��veri� yapan ki�inin ID�sini getiren sorguyu yaz�n�z. (Max son tarihte birden fazla al��veri� yapan ID bulunmakta. Bunlar� da getiriniz.)

SELECT master_id, last_order_date TARIH
FROM Customers
WHERE last_order_date = '2021-05-30' -- 30 May�s 2021 Database �zerindeki MAX(last_order_date) ��kt�s�d�r.


--22: E nson al��veri� yapan ki�inin al��veri� yapma g�n ortalamas�n� getiren sorguyu yaz�n�z.

SELECT TOP 1 master_id, last_order_date TARIH, (ABS(DATEDIFF(day, last_order_date , first_order_date)) / (order_num_total_ever_offline + order_num_total_ever_online)) GUN_ORTALAMASI
FROM Customers
WHERE last_order_date = '2021-05-30'


--23: Platform k�r�l�m�nda en son al��veri� yapan ki�ilerin fatura ba��na ortalamas�n� getiren sorguyu yaz�n�z.

SELECT master_id, last_order_date TARIH,(SUM(customer_value_total_ever_offline + customer_value_total_ever_online) / SUM(order_num_total_ever_offline + order_num_total_ever_online)) FATURA_BASI_ORTALAMA,
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END AS PLATFORM

FROM Customers
WHERE last_order_date = '2021-05-30' -- 30 May�s 2021 Database �zerindeki MAX(last_order_date) ��kt�s�d�r.

GROUP BY master_id, last_order_date,
CASE
	WHEN last_order_channel = 'Offline' THEN 'OFFLINE'
	ELSE 'ONLINE'
END
ORDER BY FATURA_BASI_ORTALAMA DESC


--24: �lk al��veri�ini yapan ki�inin ID�sini getiren sorguyu yaz�n�z.

SELECT master_id
FROM Customers
WHERE first_order_date = '2013-01-14' -- 14 Ocak 2013 Database �zerindeki ilk (first_order_date) ��kt�s�d�r.


--25: �lk al��veri� yapan ki�inin al��veri� yapma g�n ortalamas�n� getiren sorguyu yaz�n�z.

SELECT TOP 1 master_id, first_order_date, (ABS(DATEDIFF(day, last_order_date , first_order_date)) / (order_num_total_ever_offline + order_num_total_ever_online)) GUN_ORTALAMASI
FROM Customers
WHERE first_order_date = '2013-01-14'-- 14 Ocak 2013 Database �zerindeki ilk (first_order_date) ��kt�s�d�r.

