/*======================= CONSTRAINTS - KISITLAMALAR ======================================
               
    NOT NULL - Bir Sütunun  NULL içermemesini garanti eder. 

    UNIQUE - Bir sütundaki tüm de?erlerin BENZERS?Z olmas?n? garanti eder.  

    PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
                  BENZERS?Z olmas?n? garanti eder.(NOT NULL ve UNIQUE birle?imi gibi)

    FOREIGN KEY - Ba?ka bir tablodaki Primary Key’i referans göstermek için kullan?l?r. 
                  Böylelikle, tablolar aras?nda ili?ki kurulmu? olur. 

    CHECK - Bir sutundaki tüm verilerin belirlenen özel bir ?art? sa?lamas?n? garanti eder. 

    DEFAULT - Herhangi bir de?er atanamad???nda Ba?lang?ç de?erinin atanmas?n? sa?lar.
 ========================================================================================*/
   
----------------------------------------------------------------
-- KISITLAMALAR (ORNEK1 - PRIMARY KEY)
----------------------------------------------------------------
   
    CREATE TABLE calisanlar
    (
        id CHAR(5) PRIMARY KEY,
        isim VARCHAR2(50) UNIQUE,
        maas NUMBER(5) NOT NULL,
        ise_baslama DATE
    );
    
    INSERT INTO calisanlar VALUES('10001', 'Ahmet Aslan',7000, '13-04-2018');
    INSERT INTO calisanlar VALUES( '10002', 'Mehmet Y?lmaz' ,12000, '14-04-18');
    INSERT INTO calisanlar VALUES('10003', '', 5000, '14-04-18');
    INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '14-04-18');
    INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '14-04-18'); 
    INSERT INTO calisanlar VALUES('10006', 'Canan Ya?', NULL, '12-04-19');
    
    SELECT * FROM calisanlar;
    
    DROP TABLE calisanlar;
    
    -- 10001 id'li calisani silme (?leride bu konuyu görece?iz).
    DELETE calisanlar
    WHERE id='10001';

----------------------------------------------------------------
-- KISITLAMALAR (ORNEK2 - PRIMARY KEY ALTERNAT?F YÖNTEM)
----------------------------------------------------------------
-- Bu yöntemde K?s?tlamaya istedi?imiz ismi atayabiliriz 
-- ve DISABLE komutuyla istedi?imizde pasif hale getirebiliriz. 
    
    CREATE TABLE calisanlar
    (
        id CHAR(5), 
        isim VARCHAR2(50) UNIQUE,
        maas NUMBER(5) NOT NULL,
        ise_baslama DATE,
        CONSTRAINT id_pk PRIMARY KEY(id) --DISABLE
    );
    
    INSERT INTO calisanlar VALUES('10001', 'Ahmet Aslan',7000, '13-04-2018');
    INSERT INTO calisanlar VALUES( '10002', 'Mehmet Y?lmaz' ,12000, '14-04-18');
    INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '14-04-18');

----------------------------------------------------------------
-- KISITLAMALAR (ORNEK3 - FOREIGN KEY)
----------------------------------------------------------------
      
    CREATE TABLE adresler
    (
        adres_id CHAR(5),     -- REFERENCES calisanlar(id),
        sokak VARCHAR2(50),
        cadde VARCHAR2(30),
        sehir VARCHAR2(15),
        CONSTRAINT id_fk FOREIGN KEY(adres_id) REFERENCES calisanlar(id) 
    );
    
    INSERT INTO adresler VALUES('10001','Mutlu Sok', '40.Cad.','IST');
    INSERT INTO adresler VALUES('10001','Can Sok', '50.Cad.','Ankara');
    INSERT INTO adresler VALUES('10002','A?a Sok', '30.Cad.','Antep');
    -- FK'ye null de?eri atanabilir. 
    INSERT INTO adresler VALUES('','A?a Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES('','A?a Sok', '30.Cad.','Antep');
    -- Parent tabloda olmayan bir id ile ekleme yap?lamaz.
    INSERT INTO adresler VALUES('10004','Gel Sok', '60.Cad.','Van');
    
    SELECT * FROM adresler;
    SELECT * FROM calisanlar;
    
    -- Child tablo silinmeden parent tablo silinemez.
    DROP TABLE calisanlar;
    DROP TABLE adresler;
    
    -- FK ile birle?tirilen tablolardaki tüm verileri çekmek için 
    -- JOIN ??lemi yapmak gerekir. Bu konuyu sonra görece?iz.
    SELECT * FROM calisanlar, adresler WHERE calisanlar.id = adresler.adres_id;
    
    --CHECK VE DEFAULT 
    CREATE TABLE sehirler(
        alan_kodu NUMBER(3)DEFAULT 34,
        isim VARCHAR2(20) DEFAULT '?STANBUL',
        nufus NUMBER(8) CHECK(nufus>0) --CHECK CREATE kisminin altinda olusturuluyor.
    );
    
    INSERT INTO sehirler VALUES (54, 'sakarya', 1250000);
    INSERT INTO sehirler VALUES ('', '', 18050000);
    --INSERT INTO sehirler VALUES ('', '', -18050000); ==> - eksi olmaz burada. CHECK var cunku. 
    
        --PARCALI VERI GIRISI
    --parcali veri girisi yaparsak o zaman DEFAULT degerler gecerli olacak.
    --yoksa '' seklinde giris yaparsak o zaman NULL yazar.
     INSERT INTO sehirler (nufus) VALUES (50000);
    
    SELECT * FROM sehirler;
    
    
    
    
    
    
    
    
    