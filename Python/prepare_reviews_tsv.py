
import csv
from pathlib import Path

# Locate the project directory automatically
PROJECT_ROOT = Path(__file__).resolve().parents[1]

# Dataset directories
DATASET_DIR = PROJECT_ROOT / "Dataset"

source = (
    DATASET_DIR
    / "Raw"
    / "olist_order_reviews_dataset.csv"
)

output_folder = DATASET_DIR / "Processed"

# Create output directory if it does not exist
output_folder.mkdir(parents=True, exist_ok=True)

output = (
    output_folder
    / "olist_order_reviews_dataset.tsv"
)

if not source.exists():
    raise FileNotFoundError(
        f"Source dataset not found: {source}"
    )

# Convert CSV into TSV
with source.open(
    "r",
    encoding="utf-8-sig",
    newline=""
) as infile:

    reader = csv.reader(infile)
    header = next(reader, None)

    if header is None:
        raise ValueError("CSV file is empty.")

    count = 0

    with output.open(
        "w",
        encoding="utf-8",
        newline=""
    ) as outfile:

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
                    f"Column mismatch at record {count + 2}"
                )

            writer.writerow(row)
            count += 1

print("Conversion completed successfully!")
print("Number of columns:", len(header))
print("Number of records:", count)
print("Output file:", output)
