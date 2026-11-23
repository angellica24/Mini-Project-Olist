
import csv

path = r"C:\Users\ASUS\OneDrive\Documents\Mini Project Olist\Dataset\Raw\olist_order_reviews_dataset.csv"

with open(path, "r", encoding="utf-8-sig", newline="") as file:
    reader = csv.reader(file)
    header = next(reader)

    for record_no, row in enumerate(reader, start=1):
        if 77915 <= record_no <= 77919:
            print("\nRecord:", record_no)
            print("Physical line:", reader.line_num)
            print("Jumlah kolom:", len(row))

            for i, value in enumerate(row, start=1):
                if i in (4, 5):
                    print(f"Kolom {i}: {value[:120]!r}")
                    print("Panjang karakter:", len(value))
                else:
                    print(f"Kolom {i}: {value!r}")
