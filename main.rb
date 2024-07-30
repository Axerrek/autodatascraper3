# frozen_string_literal: true
require_relative 'classes/scraper'
require_relative 'classes/csv'
require_relative 'classes/fetcher'
require 'csv'

# Główna klasa odpowiedzialna za scrapowanie danych o samochodach.
#
# scraper - obiekt scraper używany do pobierania linków
# fetcher - obiekt fetcher używany do pobierania i przetwarzania danych
# params - słownik przechowujący wyniki scrapowania
# a - początkowy indeks dla przetwarzania linków
# b - końcowy indeks dla przetwarzania linków
class Main
  # Inicjalizuje nową instancję Main.
  #
  # @return [Main] nowa instancja Main
  def initialize
    @scraper = Scraper.new("https://www.autocentrum.pl")
    @fetcher = Fetcher.new(@scraper)
    @params = {
      content: "",
      counter: 0,
      max_semicolons: 0,
      max_semicolons_parameters: ""
    }
    @a = 0
    @b = 90
  end

  # Uruchamia proces scrapowania, zapisuje dane do plików i przetwarza plik CSV.
  #
  # @return [void]
  def run
    brand_links = @scraper.fetch_link('/dane-techniczne/', 'mark-container', 'href')
    @fetcher.fetch_brands(brand_links, @a, @b, @params)
    save_parameters
    save_to_csv
    process_csv
  end

  private

  # Zapisuje parametry do pliku tekstowego.
  #
  # @return [void]
  def save_parameters
    File.open('params.txt', 'a:UTF-8') do |file|
      file.puts @params[:content]
    end
  end

  # Zapisuje dane do pliku CSV.
  #
  # @return [void]
  def save_to_csv
    csv_saver = Csv.new(@params[:content], @params[:max_semicolons_parameters])
    csv_saver.save_to_csv
  end

  # Przetwarza plik CSV: usuwa duplikaty, sortuje dane i zapisuje do nowego pliku CSV.
  #
  # @return [void]
  def process_csv
    input_file = 'params.csv'  # Nazwa pliku CSV, który zawiera dane do przetworzenia
    output_file = 'params_sorted.csv'  # Nazwa nowego pliku CSV

    # Wczytaj dane z pliku CSV z kodowaniem UTF-8
    data = CSV.read(input_file, headers: true, encoding: 'UTF-8')

    # Sprawdź unikalność wartości w kolumnie 'link'
    unique_links = data.by_col['link'].uniq
    unique_data = data.select { |row| unique_links.include?(row['link']) }

    # Posortuj dane według kolumn 'marka' i 'model' (jeśli chcesz)
    sorted_data = unique_data.sort_by { |row| [row['marka'], row['model']] }

    # Zapisz posortowane dane do nowego pliku CSV
    CSV.open(output_file, 'w', write_headers: true, headers: data.headers, encoding: 'UTF-8') do |csv|
      sorted_data.each do |row|
        csv << row
      end
    end
    puts "Duplikaty usunięte, dane posortowane i zapisane do #{output_file}"
  end
end

main = Main.new
main.run
