
import csv
from pathlib import Path

# Lokasi dataset asli
base = Path(
    r"C:\Users\ASUS\OneDrive\Documents\Mini Project Olist\Dataset"
)

source = base / "Raw" / "olist_order_reviews_dataset.csv"

# Folder hasil konversi
output_folder = base / "Processed"
output_folder.mkdir(parents=True, exist_ok=True)

output = output_folder / "olist_order_reviews_dataset.tsv"

with source.open("r", encoding="utf-8-sig", newline="") as infile:
    reader = csv.reader(infile)
    header = next(reader)

    count = 0

    with output.open("w", encoding="utf-8", newline="") as outfile:
        writer = csv.writer(
            outfile,
            delimiter="\t",
            quotechar='"',
            escapechar="\\",
            doublequote=False,
            quoting=csv.QUOTE_MINIMAL,
            lineterminator="\n"
        )

        writer.writerow(header)

        for row in reader:
            if len(row) != len(header):
                raise ValueError(
                    f"Jumlah kolom tidak sesuai pada record {count + 2}"
                )

            writer.writerow(row)
            count += 1

print("Konversi berhasil!")
print("Jumlah kolom:", len(header))
print("Jumlah data:", count)
print("File hasil:", output)
