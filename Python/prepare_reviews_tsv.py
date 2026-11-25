import csv
from pathlib import Path


# =====================================================
# PREPARE OLIST REVIEWS DATA
# Convert the original CSV review dataset into TSV.
#
# The original CSV file is not modified.
# The processed TSV file is saved in Dataset/Processed.
# =====================================================


# Locate the project directory automatically.
# Expected structure:
# Mini Project Olist/
# ├── Dataset/
# │   ├── Raw/
# │   │   └── olist_order_reviews_dataset.csv
# │   └── Processed/
# └── Python/
#     └── prepare_reviews_tsv.py

PROJECT_ROOT = Path(__file__).resolve().parents[1]

SOURCE_FILE = (
    PROJECT_ROOT
    / "Dataset"
    / "Raw"
    / "olist_order_reviews_dataset.csv"
)

OUTPUT_FOLDER = (
    PROJECT_ROOT
    / "Dataset"
    / "Processed"
)

OUTPUT_FILE = (
    OUTPUT_FOLDER
    / "olist_order_reviews_dataset.tsv"
)


def main():
    # Check whether the source dataset exists.
    if not SOURCE_FILE.exists():
        raise FileNotFoundError(
            f"Source dataset not found: {SOURCE_FILE}"
        )

    # Create the Processed folder if it does not exist.
    OUTPUT_FOLDER.mkdir(
        parents=True,
        exist_ok=True
    )

    # Read the original CSV and write the TSV output.
    with SOURCE_FILE.open(
        "r",
        encoding="utf-8-sig",
        newline=""
    ) as infile:

        reader = csv.reader(infile)
        header = next(reader, None)

        if header is None:
            raise ValueError("Source CSV file is empty.")

        total_records = 0

        with OUTPUT_FILE.open(
            "w",
            encoding="utf-8",
            newline=""
        ) as outfile:

            writer = csv.writer(
                outfile,
                delimiter="\t",
                quotechar='"',
                doublequote=True,
                quoting=csv.QUOTE_MINIMAL,
                lineterminator="\n"
            )

            # Write the column names.
            writer.writerow(header)

            # Write each data record.
            for record_number, row in enumerate(
                reader,
                start=2
            ):

                # Ensure every record has the same number
                # of columns as the header.
                if len(row) != len(header):
                    raise ValueError(
                        "Column mismatch at CSV record "
                        f"{record_number}: expected "
                        f"{len(header)} columns, "
                        f"found {len(row)}."
                    )

                writer.writerow(row)
                total_records += 1

    # Validate the generated TSV file.
    verified_records = 0

    with OUTPUT_FILE.open(
        "r",
        encoding="utf-8",
        newline=""
    ) as processed_file:

        tsv_reader = csv.reader(
            processed_file,
            delimiter="\t",
            quotechar='"',
            doublequote=True
        )

        output_header = next(tsv_reader, None)

        if output_header != header:
            raise ValueError(
                "TSV validation failed: "
                "the output header does not match the source."
            )

        for record_number, row in enumerate(
            tsv_reader,
            start=2
        ):

            if len(row) != len(header):
                raise ValueError(
                    "TSV validation failed at record "
                    f"{record_number}: expected "
                    f"{len(header)} columns, "
                    f"found {len(row)}."
                )

            verified_records += 1

    if verified_records != total_records:
        raise ValueError(
            "TSV validation failed: record count mismatch. "
            f"Source records: {total_records}; "
            f"TSV records: {verified_records}."
        )

    # Display the conversion and validation results.
    print("Conversion completed successfully!")
    print("TSV validation completed successfully!")
    print("Number of columns:", len(header))
    print("Number of records:", total_records)
    print("Output file:", OUTPUT_FILE)


if __name__ == "__main__":
    main()
