<?php
$id_buku = $_GET['id_buku'];
$qbuku = mysqli_query($koneksi, "select * from tb_buku where id_buku = '$id_buku'");
$buku = mysqli_fetch_array($qbuku);

// kode otomatis
$qkode = mysqli_query($koneksi, "select max(id_jual) from id_jual");
$kode - mysqli_fetch_array($qkode);
if ($kode) {
    $nilai = $kode[0];
    $nilai = substr($nilai, 3);
    $nilai = (int) $nilai;
    $kodebaru = $nilai + 1;
    $kode_otomatis = "PJN" . str_pad($kodebaru, 4, "0", STR_PAD_LEFT);
} else {
    $kode_otomatis = "PJN00001";
}

?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Kasir-Input Penjualan</title>
</head>

<body>
    <h4>Input Penjualan</h4>
    <p>Kode Penjualan = <?= $kode_otomatis; ?></p>
    <form action="" class="form-inline row" method="post">
        <a href="?menu=load_buku" class="btn btn-info">load buku</a>
        <input type="text" placeholder="pilih buku" class="form-control" value="<?= $buku['judul']; ?>" readonly>
        <input type="number" name="jumlah" max="<?= $buku['stok']; ?>" placeholder="jumlah beli max <?= $buku['stok'] ?>" class="form-control">
        <input type="submit" name="tambah" value="tambah ke keranjang" class="btn btn-primary">
    </form>
    <?php
    if (isset($_POST['tambah'])) {
        $jumlah = $_POST['jumlah'];
        $id_kasir = $profil['id_kasir'];
        $jumlah_harga = $buku['harga_pokok'] * $jumlah;
        $q = mysqli_query($koneksi, "insert into tb_keranjang(id_buku, id_kasir, jumlah, jumlah_harga) values('$id_buku', '$id_kasir', '$jumlah', '$jumlah_harga')");

        $updatestok = $buku['stok'] - $jumlah;
        mysqli_query($koneksi, "update tb_buku set stok='$updatestok' where id_buku='$id_buku'")
        ?>
        <div class="alert alert-success">
            Berhasil tambah keranjang!
        </div>
        <meta http-equiv="refresh" content="1; url='?menu=input_penjualan'">
    <?php
    }
    ?>
    <hr>
    <h4> <span class="glyphicon glyphicon-shopping-cart"></span> keranjang</h4>
    <table class="table table-bordered">
        <tr>
            <th>No. </th>
            <th>Buku</th>
            <th>PPN</th>
            <th>Diskon</th>
            <th>harga</th>
            <th>Jumlah</th>
            <th>Jumlah Harga</th>
            <th>Aksi</th>
        </tr>
        <?php
        $no = 1;
        $qker = mysqli_query($koneksi, "SELECT tb_buku.*, tb_kasir.*, tb_keranjang.* FROM tb_keranjang INNER JOIN tb_buku ON tb_buku.id_buku=tb_keranjang.id_buku INNER JOIN tb_kasir ON tb_kasir.id_kasir=tb_keranjang.id_kasir");
        while ($data = mysqli_fetch_array($qker)) {
            ?>
            <tr>
                <td><?= $no++; ?></td>
                <td><?= $data['judul'] ?></td>
                <td><?= $data['ppn'] ?></td>
                <td><?= $data['diskon'] ?></td>
                <td><?= $data['harga_pokok'] ?></td>
                <td><?= $data['jumlah'] ?></td>
                <td><?= $data['jumlah_harga'] ?></td>
                <td>
                    <a onclick="return confirm('Akan dihapus?')" href="?menu=hapus_ker&id_keranjang=<?= $data['id_keranjang']; ?>&id_buku=<?= $data['id_buku'] ?>&jumlah=<?= $data['jumlah'] ?>" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span></a>
                </td>
            </tr>
        <?php } ?>
        <tr>
            <th class="text-right" colspan="5">Total Harga</th>
            <td>Ini Totalnya</td>
            <td>
                Rp.
                <?php
                $qtotal = mysqli_query($koneksi, "select sum(jumlah_harga) as total from tb_keranjang");
                $total = mysqli_fetch_array($qtotal);
                echo number_format($total['total'], 2)
                ?>
            </td>
        </tr>
    </table>
    <hr>
    <?php
    $qk = mysqli_query($koneksi, "select * from tb_keranjang");
    $cek = mysqli_num_rows($qk);
    if ($cek > 0) {
        ?>
        <div class="col-md-4">
            <h1><small>Harga Total</small>
                <br>Rp. <?= number_format($total['total'], 2); ?>
            </h1>
            <form action="" class="form-inline row" method="post">
                <input type="number" name="uang" placeholder="masukkan uang pembeli" class="form-control" min="<?= $total['total']; ?>">
                <input type="submit" name="proses" value="proses" class="btn btn-success">
            </form>
        </div>
        <div class="col-md-4">
            <?php
                if (isset($_POST['proses'])) {
                    $uang = $_POST['uang'];
                    $kembali = $uang - $total['total'];

                    $tanggal = date('Y-m-d');
                    mysqli_query($koneksi, "insert into tb_penjualan(id_buku, jumlah, jumlah_harga, id_jual) select id_buku, jumlah,jumlah_harga, '$kode_otomatis' from tb_keranjang");
                    // masukkan data ke tb_jual
                    mysqli_query($koneksi, "insert into tb_jual(id_jual, total,uang,kembali,id_kasir,tanggal) values('$kode_otomatis', '$total[total]', '$uang', '$kembali', '$profil[id_kasir]', '$tanggal')");

                    ?>
                <blockquote>
                    <h3>
                        <small>Uang Pembeli</small>
                        Rp. <?= number_format($uang, 2); ?>
                    </h3>
                    <h2>
                        <small>Uang Kembali</small>
                        Rp. <?= number_format($kembali, 2); ?>
                    </h2>
                </blockquote>
        </div>
        <div class="col-md-4">
            <a href="?menu=selesai" class="btn btn-success">Selesai dan bersihkan keranjang</a>
            <a href="" class="btn btn-success"><span class="glyphicon glyphicon-print"></span></a>
        </div>
<?php
    }
}
?>
</body>

</html>