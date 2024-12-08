SELECT * FROM ogrenci;

SELECT ograd, ogrsoyad, sinif FROM ogrenci;

SELECT * FROM ogrenci WHERE cinsiyet = 'Kadin';

SELECT * FROM ogrenci WHERE cinsiyet = 'Kadin' AND sinif = '11. Sinif';

SELECT ograd + ' ' + ogrsoyad as 'adSoyad' FROM ogrenci;


SELECT * FROM ogrenci WHERE ograd LIKE 'A%';


SELECT * FROM kitap WHERE sayfasayisi BETWEEN 1 AND 280;

SELECT * FROM kitap WHERE sayfasayisi >= 200 AND sayfasayisi <= 380;



SELECT * FROM ogrenci WHERE ogrno IN (101,105,106,107);



SELECT * FROM ogrenci WHERE dtarih BETWEEN '2002-01-10' AND '2002-12-10';

SELECT * FROM ogrenci WHERE dtarih >= '2002-01-10' AND dtarih <= '2002-12-10';



SELECT * FROM ogrenci WHERE ogrno BETWEEN 102 AND 107 AND cinsiyet = 'Kadin';



SELECT * FROM kitap ORDER BY sayfasayisi;


SELECT * FROM kitap ORDER BY sayfasayisi DESC;


SELECT * FROM ogrenci ORDER BY ograd, ogrsoyad DESC;



SELECT TOP 5 * FROM kitap;



SELECT TOP 1 *  FROM kitap ORDER BY sayfasayisi DESC



SELECT * FROM kitap ORDER BY newid();


SELECT TOP 1 *  FROM kitap ORDER BY newid();


SELECT sinif FROM ogrenci GROUP BY sinif;


SELECT sinif, COUNT(*) FROM ogrenci GROUP BY sinif;


SELECT kitapadi, yazarad + ' ' + yazarsoyad AS 'Yazarlar' FROM kitap JOIN yazar on yazar.yazarno = kitap.yazarno;



SELECT * FROM kitap JOIN tur ON tur.turno = kitap.turno WHERE tur.turadi IN ('Fıkra', 'Kisa Hikaye');



SELECT kitap.kitapadi, yazar.yazarad, tur.turadi from kitap JOIN yazar ON yazar.yazarno = kitap.yazarno JOIN 
tur ON tur.turno = kitap.turno;


SELECT ogrenci.ogrno, ogrenci.ograd, ogrenci.ogrsoyad, kitap.kitapadi, tur.turadi FROM islem JOIN ogrenci ON islem.ogrno = ogrenci.ogrno 
JOIN kitap ON kitap.kitapno = islem.kitapno JOIN tur ON tur.turno = kitap.turno;

SELECT * FROM ogrenci LEFT JOIN islem ON islem.ogrno = ogrenci.ogrno WHERE islem.islemno IS NULL ORDER BY islem.islemno;
