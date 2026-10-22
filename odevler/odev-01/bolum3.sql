-- ==========================================
-- BÖLÜM 3: SQL Sorguları (llm_ops)
-- ==========================================

-- Soru 1: Bütün çağrıların id'si ve model adı
SELECT id, model_name
FROM llm_calls;
-- 12 satır döndü. Tablodaki bütün kayıtlar geldi.

-- Soru 2: Model adını model, toplam token sayısını total_tokens başlığıyla göster.
SELECT model_name AS model, (prompt_tokens + completion_tokens) AS total_tokens
FROM llm_calls;
-- 12 satır döndü. Hesaplanan yeni sütun başarıyla eklendi.

-- Soru 3: Gecikmesi 2 saniyeyi aşan çağrılar (2 saniye = 2000 ms)
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE latency_ms > 2000;
-- 5 satır döndü. Gecikme süresi 2000 ms'den büyük olanlar listelendi.

-- Soru 4: Ece'nin yaptığı çağrılar
SELECT id, model_name, task_type
FROM llm_calls
WHERE user_name = 'Ece';
-- 3 satır döndü. Sadece Ece'ye ait kayıtlar filtrelendi.

-- Soru 5: Sohbet (chat) dışındaki çağrılar
SELECT id, model_name, task_type
FROM llm_calls
WHERE task_type <> 'chat';
-- 9 satır döndü. Chat türündeki işler hariç tutuldu.

-- Soru 6: Adı claude ile başlayan modellere yapılan, 1 saniyeden yavaş çağrılar
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE model_name LIKE 'claude%' AND latency_ms > 1000;
-- 2 satır döndü. Her iki koşulu sağlayan Claude kayıtları yakalandı.

-- Soru 7: Kod veya çeviri işi olan, maliyeti 0.01 doları aşan çağrılar
SELECT id, task_type, cost_usd
FROM llm_calls
WHERE (task_type = 'code' OR task_type = 'translate') AND cost_usd > 0.01;
-- 3 satır döndü. Mantıksal öncelik için parantez kullanıldı.

-- Soru 8: Gecikmesi 500 ile 1500 ms arasındaki çağrılar (uçlar dahil)
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE latency_ms BETWEEN 500 AND 1500;
-- 3 satır döndü. Aralık sorgusu başarıyla çalıştı.

-- Soru 9: gpt ailesine (gpt-4o, gpt-4o-mini) yapılan çağrılar
SELECT id, model_name
FROM llm_calls
WHERE model_name IN ('gpt-4o', 'gpt-4o-mini');
-- 4 satır döndü. Listendeki modeller filtrelendi.

-- Soru 10: Model adında "mini" geçen çağrılar
SELECT id, model_name
FROM llm_calls
WHERE model_name LIKE '%mini%';
-- 3 satır döndü. İçinde mini geçen modeller listelendi.

-- Soru 11: Önce kullanıcıya, kullanıcı içinde maliyete (pahalıdan ucuza) göre sırala
SELECT id, user_name, cost_usd
FROM llm_calls
ORDER BY user_name ASC, cost_usd DESC;
-- 12 satır döndü. Çoklu sıralama düzgün çalıştı.

-- Soru 12: En pahalı 3 çağrı
SELECT id, model_name, cost_usd
FROM llm_calls
ORDER BY cost_usd DESC
LIMIT 3;
-- 3 satır döndü. Maliyeti en yüksek ilk üç kayıt alındı.

-- Soru 13: Hangi iş türleri (task_type) var?
SELECT DISTINCT task_type
FROM llm_calls;
-- 5 satır döndü. Tekrarsız iş türleri listelendi.

-- Soru 14: Kullanıcı adlarını doğru Türkçe alfabetik sırayla, tekrarsız listele
SELECT DISTINCT user_name
FROM llm_calls
WHERE user_name IS NOT NULL
ORDER BY user_name COLLATE "tr-TR-x-icu";
-- 5 satır döndü. Türkçe karakter sıralaması uygulandı.

-- Soru 15: 14 Ekim'den sonra yapılan, 1 saniyeden yavaş çağrıların id'sini, modelini ve gecikmesini listele
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE created_at > '2026-10-14' AND latency_ms > 1000
ORDER BY latency_ms DESC;
-- 5 satır döndü. Tarih ve gecikme filtresi uygulandı.
