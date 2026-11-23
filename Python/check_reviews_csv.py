
import csv
from pathlib import Path

# Locate the project directory automatically
PROJECT_ROOT = Path(__file__).resolve().parents[1]

# Dataset location
CSV_PATH = (
    PROJECT_ROOT
    / "Dataset"
    / "Raw"
    / "olist_order_reviews_dataset.csv"
)

# Check whether the dataset exists
if not CSV_PATH.exists():
    raise FileNotFoundError(
        f"Dataset not found: {CSV_PATH}"
    )

# Validate CSV structure
with CSV_PATH.open(
    "r",
    encoding="utf-8-sig",
    newline=""
) as file:

    reader = csv.reader(file)
    header = next(reader, None)

    if header is None:
        raise ValueError("CSV file is empty.")

    bad_rows = []
    total_rows = 0

    for record_no, row in enumerate(reader, start=2):
        total_rows += 1

        if len(row) != len(header):
            bad_rows.append(
                (record_no, reader.line_num, len(row), row)
            )

print("Number of header columns:", len(header))
print("Total data records:", total_rows)
print("Problematic rows:", len(bad_rows))

for record, line, columns, row in bad_rows[:10]:
    print("\nRecord:", record)
    print("Physical line:", line)
    print("Number of columns:", columns)

    for i, value in enumerate(row, start=1):
        print(f"Column {i}: {value[:200]!r}")
