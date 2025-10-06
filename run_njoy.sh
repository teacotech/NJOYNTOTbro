#!/bin/bash
# Mengambil direktori utama tempat skrip 
BASE_DIR="$(dirname "$(readlink -f "$0")")"

echo "Pastikan argumen pertama ($1) adalah MAT dan argumen kedua ($2) adalah ZAID"

# Argumen pertama untuk MAT
specialNumber="$1"
# Argumen kedua untuk ZAID
ZAID="$2"

# Inisialisasi variabel file
foundFile_dat=""
foundFile_INP=""
baseFileName=""

# Deklarasi variabel libs
libsValue="ENDFB8.1"

# Pencarian File .DAT
echo "Mencari file .dat di $BASE_DIR/ENDF-BVIII-1/..."

# Iterasi sepanjang file yang berformat .dat (FOR -statement)
for f in "$BASE_DIR/ENDF-BVIII-1/"*.dat; do
    # Memastikan file ada (untuk menghindari iterasi pada string pola jika tidak ada file)
    if [ ! -f "$f" ]; then
        continue
    fi

    # Mendapatkan hanya nama file dan ekstensi
    filename=$(basename -- "$f")

    # Mencari string $specialNumber di $filenamae
    # grep -i: ignore case, -q: quiet, -F: fixed string
    if echo "$filename" | grep -i -q -F -- "$specialNumber"; then
        foundFile_dat="$f"
        # Mendapatkan nama file tanpa path dan ekstensi
        baseFileName="${filename%.*}"
        break; # Keluar dari loop
    fi
done

# Pencarian File .INP
echo "Mencari file .INP di $BASE_DIR/INP/..."

# Iterasi sepanjang file yang berformat .INP
for f in "$BASE_DIR/INP/"*.INP; do
    if [ ! -f "$f" ]; then
        continue
    fi

    filename=$(basename -- "$f")

    # Mencari string $specialNumber di $filename
    if echo "$filename" | grep -i -q -F -- "$specialNumber"; then
        foundFile_INP="$f"
        break # Keluar dari loop
    fi
done

# Validasi File
if [ -z "$foundFile_dat" ]; then
    echo "Error: File .dat tidak ditemukan untuk MAT $specialNumber."
    exit 1
else
    echo "Ditemukan file .dat: $foundFile_dat"
fi

if [ -z "$foundFile_INP" ]; then
    echo "Error: File .INP tidak ditemukan untuk MAT $specialNumber."
    exit 1
else
    echo "Ditemukan file .INP: $foundFile_INP"
fi

# Eksekusi NJOY

cp "$foundFile_dat" tape20

echo "Menjalankan NJOY ..."
./result/bin/njoy < "$foundFile_INP"

# Pengaturan Output dan Penamaan Ulang

# Membuat folder output
outputDir="$BASE_DIR/output_$baseFileName"
mkdir -p "$outputDir"
echo "Membuat direktori output: $outputDir"

# Konstruksi output filename
outputFile_out="$outputDir/${baseFileName}_${libsValue}.out"
outputFile_pendf="$outputDir/${baseFileName}_${libsValue}.pendf"
outputFile_ACE="$outputDir/${baseFileName}0_${libsValue}.ACE"
outputFile_ZAID="$outputDir/${ZAID}.03c"
outputFile_XSDIR="$outputDir/${baseFileName}_${libsValue}.XSDIR"
outputFile_ps="$outputDir/${baseFileName}_${libsValue}.ps"

echo "Mengganti Nama dan Menyalin File ..."

cp output "$outputFile_out"
cp tape36 "$outputFile_pendf"
cp tape38 "$outputFile_ACE"
cp tape38 "$outputFile_ZAID"
cp tape39 "$outputFile_XSDIR"
cp tape48 "$outputFile_ps"

echo "Selesai ..."
exit 0


















