
import csv
from pathlib import Path

# Locate the project directory automatically
PROJECT_ROOT = Path(__file__).resolve().parents[1]

CSV_PATH = (
    PROJECT_ROOT
    / "Dataset"
    / "Raw"
    / "olist_order_reviews_dataset.csv"
)

if not CSV_PATH.exists():
    raise FileNotFoundError(
        f"Dataset not found: {CSV_PATH}"
    )

# Inspect selected records
with CSV_PATH.open(
    "r",
    encoding="utf-8-sig",
    newline=""
) as file:

    reader = csv.reader(file)
    header = next(reader, None)

    if header is None:
        raise ValueError("CSV file is empty.")

    for record_no, row in enumerate(reader, start=1):

        if 77915 <= record_no <= 77919:

            print("\nRecord:", record_no)
            print("Physical line:", reader.line_num)
            print("Number of columns:", len(row))

            for i, value in enumerate(row, start=1):

                if i in (4, 5):
                    print(f"Column {i}: {value[:120]!r}")
                    print("Character length:", len(value))
                else:
                    print(f"Column {i}: {value!r}")
