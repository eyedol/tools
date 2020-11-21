#!/usr/bin/python -u
# -*- coding: utf-8 -*-

import csv
import sqlite3
import sys
import argparse

__version__ = '1.0.0'

class AnkiCardBuilder:
  def __init__(self, sqlite_input_file, csv_output_file):
    self.sqlite_input = sqlite_input_file
    self.csv_output = csv_output_file

  def dump_csv(self,):
    conn = sqlite3.connect(self.sqlite_input)
    conn.text_factory = str ## my current (failed) attempt to resolve this
    cursor = conn.cursor()
    data = cursor.execute("SELECT front, back FROM cards")
    self.__write_csv(data);

  def __write_csv(self, items):
    with open(self.csv_output, 'w',encoding='utf-8') as file:

      c = csv.writer(file, delimiter='\t', lineterminator='\n')
      # Add '#' to first field, so Anki treats the line as a comment line.
      c.writerow(['# FRONT', 'BACK'])
      for item in items:
        c.writerow([
          item[0],
          item[1],
          ])

if __name__ == '__main__':
  """
    Sample usage: ./anki_data_builder.py ~/cards-jwasham-extreme.db ./anki-card.csv
  """
  parser = argparse.ArgumentParser(description='Exports Flash cards sqlite3 data to CSV for Anki import.')
  parser.add_argument('sqlite_file', help="Full path to the flash cards sqlite3 db file. Include file name.")
  parser.add_argument('csv_file', help="Full path to the CSV file to save the file to. Include file name.")
  args = parser.parse_args()

  sqlite_file = args.sqlite_file
  csv_file = args.csv_file
  anki = AnkiCardBuilder(sqlite_file,csv_file)
  anki.dump_csv()
    

   
