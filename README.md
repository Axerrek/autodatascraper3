# Auto Data Scraper
## Opis

Auto Data Scraper to aplikacja do scrapowania danych o samochodach z strony Autocentrum. Aplikacja pobiera informacje o markach, modelach i parametrach samochodów, zapisuje je do plików tekstowych oraz plików CSV. Następnie przetwarza plik CSV, usuwając duplikaty i sortując dane.
Struktura projektu

Projekt składa się z kilku klas, które pełnią różne funkcje:

    Main - Główna klasa, która koordynuje cały proces scrapowania, zapisywania danych i przetwarzania plików.
    Fetcher - Klasa odpowiedzialna za pobieranie i przetwarzanie danych o samochodach z różnych źródeł.
    Csv - Klasa do zapisywania danych w formacie CSV.
    HtmlParser - Klasa używająca Nokogiri do analizy dokumentów HTML i ekstrakcji danych.
    HttpClient - Klasa do wykonywania żądań HTTP i pobierania stron internetowych.
    Scraper - Klasa do pobierania danych z internetu i konwertowania ich do formatu CSV.
    Product - Klasa reprezentująca produkt z informacjami o URL, obrazie, nazwie i cenie.

Instalacja

    git clone https://github.com/TwojeRepozytorium/auto_data_scraper.git
    cd auto_data_scraper


Zainstaluj wymagane gem'y:


    bundle install

Użycie - uruchom main

    ruby main.rb

Proces scrapowania zostanie uruchomiony, a dane zostaną zapisane w plikach params.txt i params.csv.

    Plik params.csv zostanie przetworzony w celu usunięcia duplikatów i posortowania danych. Wynik zostanie zapisany w params_sorted.csv.

## Opis metod
Main#run

    Rozpoczyna proces scrapowania danych.
    Zapisuje parametry do pliku tekstowego (params.txt).
    Zapisuje dane do pliku CSV (params.csv).
    Przetwarza plik CSV, usuwając duplikaty i sortując dane (params_sorted.csv).

Fetcher#fetch_brands

    Pobiera i przetwarza dane dla podanych marek.
    Używa wielowątkowości do równoległego przetwarzania linków.

Fetcher#fetch_models

    Pobiera i przetwarza dane dla podanych modeli.

Fetcher#fetch_gens

    Pobiera i przetwarza dane dla generacji samochodów.

Fetcher#fetch_versions

    Pobiera i przetwarza dane dla wersji samochodów.

Csv#save_to_csv

    Zapisuje dane w formacie CSV do pliku params.csv.

Csv#extract_columns

    Wyciąga nagłówki kolumn z danych.

HtmlParser#extract_links

    Ekstrahuje linki z dokumentu HTML na podstawie selektora i atrybutu.

HtmlParser#extract_parameters

    Ekstrahuje parametry z dokumentu HTML w formacie "etykieta: wartość;".

HttpClient#fetch_page

    Pobiera zawartość strony HTML na podstawie podanej ścieżki.

Scraper#fetch_link

    Pobiera linki z określonej strony HTML.

Scraper#get_parameters

    Pobiera parametry z określonej strony HTML.

## Wymagania

    Ruby 2.7 lub nowszy
    Nokogiri
    HTTParty
    CSV
