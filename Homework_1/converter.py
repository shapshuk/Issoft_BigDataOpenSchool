import pyarrow.parquet as pq
import pandas
import sys

# convertation of parquet file to csv using pandas lib
def convert_parquet_to_csv(src_filename, dst_filename):
    df = pandas.read_parquet(src_filename)
    df.to_csv(dst_filename)

# convertation of csv file to parquet using pandas lib
def convert_csv_to_parquet(src_filename, dst_filename):
    df = pandas.read_csv(src_filename)
    df.to_parquet(dst_filename)

# printing to console column names and the schema of
# parquet file using pyarrow.parquet lib
def get_parquet_schema(filename):
    p_file = pq.read_table(filename)
    print("Column names: {}".format(p_file.column_names))
    print("Schema: {}".format(p_file.schema))

# printing to console help message
def print_help_message():
    with open('readme.md', 'r') as help_message_file:
        print(help_message_file.read())


if __name__ == "__main__":
    if sys.argv[1] == "--csv2parquet":
        convert_csv_to_parquet(sys.argv[2], sys.argv[3])
    if sys.argv[1] == "--parquet2csv":
        convert_parquet_to_csv(sys.argv[2], sys.argv[3])
    if sys.argv[1] == "--get-schema":
        get_parquet_schema(sys.argv[2])
    if sys.argv[1] == "--help":
        print_help_message()
