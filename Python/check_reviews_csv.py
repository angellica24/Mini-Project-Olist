
import csv

path = r"C:\Users\ASUS\OneDrive\Documents\Mini Project Olist\Dataset\Raw\olist_order_reviews_dataset.csv"

with open(path, "r", encoding="utf-8-sig", newline="") as file:
    reader = csv.reader(file)
    header = next(reader)

    bad_rows = []
    total_rows = 0

    for row in reader:
        total_rows += 1

        if len(row) != len(header):
            bad_rows.append(
                (total_rows + 1, reader.line_num, len(row), row)
            )

print("Jumlah kolom header:", len(header))
print("Total data:", total_rows)
print("Jumlah baris bermasalah:", len(bad_rows))

for record, line, columns, row in bad_rows[:10]:
    print("\nRecord:", record)
    print("Baris fisik:", line)
    print("Jumlah kolom:", columns)

    for i, value in enumerate(row, start=1):
        print(f"Kolom {i}: {value[:200]!r}")
