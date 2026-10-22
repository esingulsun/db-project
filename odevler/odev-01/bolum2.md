# BÖLÜM 2: Veritabanı Kavramları

## Soru 1: Excel vs Veritabanı
Şirketler verilerini Excel'de tutarsa aynı bilgiyi defalarca yazmak zorunda kalır ve her şey birbirine girer. Ayrıca aynı dosyayı iki kişi aynı anda açıp değiştiremediği için işler kilitlenir. Veritabanları ise bilgiyi tek bir yerde düzenli tutar, herkesin aynı anda güvenle çalışmasını sağlar ve hatalı veri girişine izin vermez.

## Soru 2: Birincil Anahtar (Primary Key)
Birincil anahtar, tablodaki her satırı birbirine karıştırmadan bulmamızı sağlayan kişiye özel T.C. numarası gibidir. Öğrenci numarası her öğrenciye özel olduğu ve hiç değişmediği için mükemmel bir anahtardır; fakat ad soyad aynı kişiden birden fazla olabileceği ve sonradan değişebileceği için güvenli değildir.

## Soru 3: DBMS ve Veritabanı Farkı
Veritabanı, telefonumuzdaki fotoğrafların veya bilgilerin durduğu klasörün kendisidir; DBMS (Veritabanı Yönetim Sistemi) ise o klasörün içindekileri arayıp bulmamızı, silmemizi veya yenilememizi sağlayan uygulamadır. Örneğin PostgreSQL, bu verileri yönetmemize yarayan güçlü bir DBMS yazılımıdır.

## Soru 4: Aynı Anda İki Kişinin Değişiklik Yapması
Aynı anda iki kişi aynı veriyi değiştirmeye kalkarsa sistem kafayı yer ve biri diğerinin yazdığını kazara silebilir. Veritabanları ise bu durumu önlemek için sıraya koyma ve kilitleme (locking) yöntemini kullanır; ya ilk gelenin işlemini kaydeder ya da diğerini bekletip veri kaybını engeller.
