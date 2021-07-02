The format of using this converter utility:
python convert.py [--csv2parquet | --parquet2csv <src-filename> <dst-filename>] | [--get-schema <filename>] | [--help]

Command "--csv2parquet" converts csv file "src-filename" to parquet file "dst-filename"
Command "--parquet2csv" converts parquet file "dst-filename" to csv file "src-filename"
Command "--get-schema" prints to console collumn names and the schema of the parquet file "filename"
Command "--help" prints this short help note to console