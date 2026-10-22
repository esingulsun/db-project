-- ==========================================
-- BÖLÜM 4: Gruplama ve NULL Analizi (llm_ops)
-- ==========================================

-- Soru 1: Kaç çağrı kaydedilmiş?
SELECT count(*) AS toplam_cagri
FROM llm_calls;
-- Tabloda toplam 12 çağrı kaydı var, count(*) boş olanları da saydığı için kesin sonuçtur.

-- Soru 2: Kaç çağrı 2 saniyeden yavaş?
SELECT count(*) AS yavas_cagri
FROM llm_calls
WHERE latency_ms > 2000;
-- Gecikmesi 2000 milisaniyeden büyük olan 5 çağrı bulundu.

-- Soru 3: Toplam maliyet ve toplam token sayısı
SELECT sum(cost_usd) AS toplam_maliyet, 
       sum(prompt_tokens + completion_tokens) AS toplam_token
FROM llm_calls;
-- Toplam maliyet ve token sayısı hesaplandı. 11 numaralı çağrının maliyeti NULL olduğu için sum onu atladı.

-- Soru 4: Ortalama gecikme süresi
SELECT round(avg(latency_ms), 1) AS ort_gecikme
FROM llm_calls;
-- Ortalama gecikme yaklaşık 1848.3 ms (1.8 saniye) çıktı. Boş değer olmadığı için tüm tablodan hesaplandı.

-- Soru 5: En hızlı ve en yavaş çağrı
SELECT min(latency_ms) AS en_hizli, max(latency_ms) AS en_yavas
FROM llm_calls;
-- En hızlı çağrı 380 ms, en yavaş çağrı ise 4100 ms olarak bulundu.

-- Soru 6: Her iş türünde kaç çağrı var?
SELECT task_type, count(*) AS cagri_sayisi
FROM llm_calls
GROUP BY task_type
ORDER BY cagri_sayisi DESC;
-- 5 farklı iş türü listelendi, toplamda 12 çağrıya ulaşıldı, eksik yok.

-- Soru 7: Her model için çağrı sayısı ve toplam maliyet (pahalıdan ucuza)
SELECT model_name, count(*) AS cagri_sayisi, sum(cost_usd) AS toplam_maliyet
FROM llm_calls
GROUP BY model_name
ORDER BY toplam_maliyet DESC;
-- Modellerin kullanım sıklığı ve bütçeye maliyetleri gruplandırılarak sıralandı.

-- Soru 8: Her kullanıcının her iş türünden kaç çağrısı var?
SELECT user_name, task_type, count(*) AS cagri_sayisi
FROM llm_calls
GROUP BY user_name, task_type
ORDER BY user_name, task_type;
-- Kullanıcı ve iş türü ikilisine göre gruplama yapıldı, toplam 12 satır döndü.

-- Soru 9: İkiden fazla çağrı almış modeller
SELECT model_name, count(*) AS cagri_sayisi
FROM llm_calls
GROUP BY model_name
HAVING count(*) > 2;
-- 2'den fazla çağrı alan sadece gpt-4o modeli var (3 çağrı).

-- Soru 10: Sadece 500 ms'den yavaş çağrılar, en az 2 çağrısı olan modeller
SELECT model_name, count(*) AS cagri, round(avg(latency_ms), 1) AS ort_gecikme
FROM llm_calls
WHERE latency_ms > 500
GROUP BY model_name
HAVING count(*) >= 2
ORDER BY ort_gecikme DESC;
-- Önce 500 ms altı hızlar WHERE ile elendi, ardından HAVING ile 2'den az kalan modeller filtrelendi.

-- Soru 11: llm_calls tablosunda hangi sütunda kaç eksik veri var?
SELECT count(*) AS satir,
       count(user_name) AS user_dolu,
       count(cost_usd) AS cost_dolu
FROM llm_calls;
-- Sadece user_name ve cost_usd sütunlarında 1'er tane eksik (NULL) veri olduğu görüldü.

-- Soru 12: Faturası gelmemiş çağrılar (cost_usd IS NULL)
SELECT id, model_name, cost_usd
FROM llm_calls
WHERE cost_usd IS NULL;
-- = NULL yerine IS NULL kullanılarak maliyeti girilmemiş 1 tane kayıt (id 11) başarıyla bulundu.

-- Soru 13: Ortalamayı boşları atlayarak ve boşları sıfır sayarak yan yana göster
SELECT round(avg(cost_usd), 5) AS boslari_atla, 
       round(avg(coalesce(cost_usd, 0)), 5) AS boslari_sifir_say
FROM llm_calls;
-- Boş kayıtlar atlandığında 11'e bölündü, sıfır sayıldığında 12'ye bölündü ve ortalama değişti.

-- Soru 14: Günlük kullanım raporu (gün, çağrı sayısı, toplam maliyet)
SELECT created_at::date AS gun, count(*) AS cagri, sum(cost_usd) AS maliyet
FROM llm_calls
GROUP BY gun
ORDER BY gun;
-- 6 farklı gün için günlük işlem hacmi ve maliyet dağılımı listelendi.

-- Soru 15: Gecikmeye göre kategori oluştur ve grupla
SELECT 
    CASE 
        WHEN latency_ms < 1000 THEN 'Hızlı'
        WHEN latency_ms < 2500 THEN 'Orta'
        ELSE 'Yavaş'
    END AS hiz_kategorisi,
    count(*) AS cagri_sayisi,
    round(avg(latency_ms), 1) AS ort_gecikme
FROM llm_calls
GROUP BY hiz_kategorisi;
-- Çağrılar hızlarına göre Hızlı, Orta ve Yavaş olarak 3 gruba ayrılarak özetlendi.
