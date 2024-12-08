CREATE DATABASE KutuphaneDB;

USE KutuphaneDB;
UPDATE tur
SET turadi = 'Fıkra' 
WHERE turno IN (1, 5);

CREATE TABLE islem (
  islemno INT,
  ogrno INT,
  kitapno INT,
  atarih DATE,
  vtarih DATE
);

CREATE TABLE ogrenci (
  ogrno INT,
  ograd VARCHAR(50),
  ogrsoyad VARCHAR(50),
  cinsiyet VARCHAR(10),
  dtarih DATE,
  sinif VARCHAR(20)
);

CREATE TABLE kitap (
  kitapno INT,
  isbnno VARCHAR(20),
  kitapadi VARCHAR(100),
  yazarno INT,
  turno INT,
  sayfasayisi INT,
  puan INT
);

CREATE TABLE yazar (
  yazarno INT,
  yazarad VARCHAR(50),
  yazarsoyad VARCHAR(50)
);

CREATE TABLE tur (
  turno INT,
  turadi VARCHAR(50)
)

CREATE TABLE [dbo].[kitap_siparis] (
    [siparisno]     INT IDENTITY(1,1) PRIMARY KEY, 
    [kitapno]       INT NOT NULL,                 
    [siparis_adedi] INT NOT NULL,                 
    [siparis_tarihi] DATE DEFAULT GETDATE(),     
    CONSTRAINT [FK_kitap_siparis_kitap] FOREIGN KEY ([kitapno]) REFERENCES [dbo].[kitap] ([kitapno])
)

ALTER TABLE ogrenci ADD CONSTRAINT PK_ogrenci PRIMARY KEY CLUSTERED (ogrno);


INSERT INTO [dbo].[kitap_siparis] (kitapno, siparis_adedi)
VALUES 
(1, 10),   
(2, 5),    
(3, 20);   


ALTER TABLE [dbo].[kitap_siparis]
DROP CONSTRAINT DF__kitap_sip__isPro__5812160E;


ALTER TABLE [dbo].[kitap_siparis]
DROP COLUMN isProcessed;


CREATE TRIGGER trg_UpdateSiparisAdedi
ON [dbo].[kitap_siparis]
AFTER UPDATE
AS
BEGIN
    
    DECLARE @OldAdedi INT, @NewAdedi INT, @KitapNo INT;

    SELECT @OldAdedi = siparis_adedi, @KitapNo = kitapno FROM deleted;
    SELECT @NewAdedi = siparis_adedi FROM inserted;

    
    IF @OldAdedi <> @NewAdedi
    BEGIN
        IF @NewAdedi > 1
        BEGIN
            UPDATE [dbo].[kitap_siparis]
            SET siparis_adedi = @NewAdedi - 1
            WHERE kitapno = @KitapNo;
        END
    END
END;
GO

UPDATE [dbo].[kitap_siparis]
SET siparis_adedi = 9
WHERE kitapno = 2;

SELECT * FROM kitap_siparis;

UPDATE [dbo].[kitap_siparis]
SET siparis_adedi = 30
WHERE kitapno = 2;


IF OBJECT_ID('dbo.DecreaseSiparisAdedi', 'TR') IS NOT NULL
    DROP TRIGGER dbo.DecreaseSiparisAdedi;
GO

DECLARE @TriggerName NVARCHAR(128)
DECLARE TriggerCursor CURSOR FOR
SELECT name
FROM sys.triggers
WHERE parent_id = OBJECT_ID('dbo.kitap_siparis')

OPEN TriggerCursor
FETCH NEXT FROM TriggerCursor INTO @TriggerName

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP TRIGGER dbo.' + @TriggerName)
    FETCH NEXT FROM TriggerCursor INTO @TriggerName
END

CLOSE TriggerCursor
DEALLOCATE TriggerCursor


ALTER TABLE ogrenci ADD puan INT DEFAULT 0

UPDATE ogrenci SET puan = 0;



UPDATE [dbo].[kitap_siparis]
SET siparis_adedi = siparis_adedi
WHERE kitapno IN (1, 2, 3);        


INSERT INTO islem (islemno, ogrno, kitapno, atarih, vtarih)
VALUES (1, 101, 201, '2023-06-01', '2023-06-10'),
       (2, 102, 202, '2023-06-02', '2023-06-12'),
       (3, 103, 203, '2023-06-03', '2023-06-13'),
       (4, 104, 204, '2023-06-04', '2023-06-14'),
       (5, 105, 205, '2023-06-05', '2023-06-15'),
       (6, 106, 206, '2023-06-06', '2023-06-16'),
       (7, 107, 207, '2023-06-07', '2023-06-17');

INSERT INTO ogrenci (ogrno, ograd, ogrsoyad, cinsiyet, dtarih, sinif)
VALUES (101, 'Ahmet', 'Yılmaz', 'Erkek', '2002-01-10', '12. Sınıf'),
       (102, 'Ayşe', 'Kaya', 'Kadın', '2003-03-15', '11. Sınıf'),
       (103, 'Mehmet', 'Demir', 'Erkek', '2002-05-20', '12. Sınıf'),
       (104, 'Zeynep', 'Aksoy', 'Kadın', '2003-07-25', '11. Sınıf'),
       (105, 'Emre', 'Yıldız', 'Erkek', '2002-09-30', '12. Sınıf'),
       (106, 'Selin', 'Arslan', 'Kadın', '2003-11-05', '11. Sınıf'),
       (107, 'Murat', 'Kara', 'Erkek', '2002-12-10', '12. Sınıf');

INSERT INTO kitap (kitapno, isbnno, kitapadi, yazarno, turno, sayfasayisi, puan)
VALUES (201, '9786052980001', 'Kırmızı Pazartesi', 1, 1, 300, 8),
       (202, '9789750723843', 'İstanbul Hatırası', 2, 2, 400, 9),
       (203, '9789753638013', 'Sineklerin Tanrısı', 3, 1, 350, 7),
       (204, '9789750725236', 'Kürk Mantolu Madonna', 4, 2, 250, 8),
       (205, '9789753638044', '1984', 5, 1, 320, 9),
       (206, '9786053753468', 'Cingöz Recai', 6, 2, 280, 7),
       (207, '9789750738588', 'Dönüşüm', 7, 1, 200, 8);

INSERT INTO yazar (yazarno, yazarad, yazarsoyad)
VALUES (1, 'Ahmet', 'Ümit'),
       (2, 'Orhan', 'Pamuk'),
       (3, 'William', 'Golding'),
       (4, 'Sabahattin', 'Ali'),
       (5, 'George', 'Orwell'),
       (6, 'Peyami', 'Safa'),
       (7, 'Franz', 'Kafka');

INSERT INTO tur (turno, turadi)
VALUES (1, 'Roman'),
       (2, 'Fıkra'),
       (3, 'Bilim Kurgu'),
       (4, 'Fıkra'),
       (5, 'Psikoloji'),
       (6, 'Roman'),
       (7, 'Klasik');



