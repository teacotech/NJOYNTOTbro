<a id="readme-top"></a>
![NixOS](https://img.shields.io/badge/NIXOS-5277C3.svg?style=for-the-badge&logo=NixOS&logoColor=white)

<!-- PROJECT LOGO -->
<br />
<div align="center">
    <a>
        <img src="image/HASYU.svg" alt="Logo" width="80" height="80">
    </a>
  <h3 align="center"></h3>
  <p align="center">
   Bash Script for NJOY2016
  </p>
</div>

## About The Project
 Membuat Bash Scripting File untuk menjalankan program NJOY2016, dikarenakan terlalu banyak hal yang harus dilakukan sebelum menjalankan dan atau setelah menjalankan program
 NJOY, maka dari itu, dibuat automasi lewat bash scripting agar mudah, gan. Mempercepat pekerjaan, asik.

### Built With

Data dari pustaka ENDF yang tersedia dari website IAEA NDS :atom: ([https://www-nds.iaea.org/public/download-endf/](https://www-nds.iaea.org/public/download-endf/)).

## Usage

Hal yang dibutuhkan: ```NixOS```.
Pertama clone the project: 
```console 
git clone https:blablabla
```
Pastikan menggunakan flake, [flake.nix](https://nixos.wiki/wiki/Flakes).
Jalankan: 
```console 
nix build .
```
Nanti flake akan mengambil source dari github [NJOY2016](https://github.com/njoy/NJOY2016), kemudian membuatkan file binary untuk teman2.
Lalu langkah terakhir adalah apabila ingin mendapati bahwa teman2 ingin menggunakan ```direnv```, pastikan ```direnv``` telah digunakan di sistem atau ```home-manager``` teman, [Tutor direnv](https://nix.dev/guides/recipes/direnv.html).

Penggunaan dari ```run_njoy.sh``` ini, dapat digunakan dengan menambahkan dua argumen tambahan, pertama MAT number dan ZAID, dengan merujuk pada penomoran terakhir dari data unsur yang tercantum pada .dat yang diambil dari IAEA NDS, kemudian untuk ZAID merupakan nomor dan massa atom, semisal untuk U-235, maka MAT=9228 dan ZAID=92235. Note bahwa ZAID ini yang akan dijalankan pada program ```SERPENT```, dan lebih jelasnya tidak dilampirkan di sini.
```console
./run_njoy.sh 9228 92235
```
Baca file ```run_njoy.sh``` untuk isi program yang saya tuliskan, dikarenakan hanya berisi ```bash scripting``` yang tidak terlalu penting, hanya sebagai mempermudah menjalankan operasi [NJOY2016](https://github.com/njoy/NJOY2016).

## Contact

Your Name - [@awwaloppa](https://instagram.com/awwaloppa) - ilham438.ar@mail.ugm.ac.id
