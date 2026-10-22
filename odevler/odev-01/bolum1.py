# ==========================================
# BÖLÜM 1: Algoritma ve İzleme
# ==========================================


# ------------------------------------------
# SORU 1.1: İz Sürme (Tablo ve Kontrol)
# ------------------------------------------
# Kâğıt Üstü İz Sürme Tablosu:
# Adım | i | numbers[i] | Çift/Tek? | total | result
# İLK  | - |     -      |     -     |   0   | []
# 1    | 0 |     4      |   Çift    |   4   | []
# 2    | 1 |     7      |    Tek    |   4   | [7]
# 3    | 2 |     2      |   Çift    |   6   | [7]
# 4    | 3 |     9      |    Tek    |   6   | [7, 9]
# 5    | 4 |     5      |    Tek    |   6   | [7, 9, 5]
# 6    | 5 |     1      |    Tek    |   6   | [7, 9, 5, 1]
# 7    | 6 |     8      |   Çift    |  14   | [7, 9, 5, 1]
#
# Tahminim kodun çıktısıyla birebir tuttu yanıldığım adım olmadı.

numbers = [4, 7, 2, 9, 5, 1, 8]
total = 0
result = []

for i in range(len(numbers)):
    if numbers[i] % 2 == 0:
        total = total + numbers[i]
    else:
        result.append(numbers[i])

print(total)
print(result)


# ------------------------------------------
# SORU 1.2: En Uzun Seri
# ------------------------------------------
# 1. Önce Sözde Kod (Pseudocode):
# BASLA
#   oku readings, threshold
#   max_seri = 0, anlik_seri = 0
#   HER bir eleman (r) ICIN readings icinde:
#       EGER r > threshold ISE:
#           anlik_seri = anlik_seri + 1
#           EGER anlik_seri > max_seri ISE:
#               max_seri = anlik_seri
#       DEGILSE:
#           anlik_seri = 0
#   YAZDIR max_seri
# BITIR

# 2. Python Karşılığı:
readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]
threshold = 22

max_streak = 0
current_streak = 0

for r in readings:
    if r > threshold:
        current_streak += 1
        if current_streak > max_streak:
            max_streak = current_streak
    else:
        current_streak = 0

print("Soru 1.2 Çıktısı -> En Uzun Seri:", max_streak)


# ------------------------------------------
# SORU 1.3: Elle Gruplama
# ------------------------------------------
records = [
    {"student": "Ece", "course": "VTYS"},
    {"student": "Ali", "course": "Yapay Zeka"},
    {"student": "Ece", "course": "Yapay Zeka"},
    {"student": "Can", "course": "VTYS"},
    {"student": "Ali", "course": "VTYS"},
    {"student": "Ece", "course": "Robotik"},
]

counts = {}
for rec in records:
    course = rec["course"]
    if course in counts:
        counts[course] += 1
    else:
        counts[course] = 1

print(counts)

# Açıklama Notu:
# Python'da sözlük(dictionary)ve döngü kullanarak yaptığımız elle gruplama mantığı, 
# ilişkisel veritabanlarındaki GROUP BY ifadesinin çalışma mekanizmasıyla örtüşmektedir. 
# her iki yöntem veriyi kategorik anahtarlara göre gruplayarak eleman sayılarını hesaplar.
