<?php
require_once('db.php');
$sql = "SELECT * FROM auto";          // TEE: mitä haetaan, esim. *
$tulos = mysqli_query($yhteys, $sql);
?>
<!-- HTML-osa: <html>, <head> ja linkki tyyleihin kuten etusivulla -->
<!DOCTYPE html>
<html lang="fi">
<head>
    <title>Autonvuokraus</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <h1>Autot</h1>
    <p><a href="../index.php">Etusivulle</a></p>

    <table border="1">
        <tr>
            <th>Kuva</th>
            <th>Rekisterinumero</th>
            <th>Valmistaja</th>
            <th>Malli</th>
            <th>Vaihteisto</th>
            <th>Moottori</th>
            <th>Paikat</th>
            <th>Hinta/vrk</th>
            <th>Vapaana</th>
        </tr>
    <?php while ($rivi = mysqli_fetch_assoc($tulos)) { ?>
        <tr>
            <td><img src="../images/<?= htmlspecialchars($rivi['malli']) ?>.png" width="100"></td>
            <td><?= htmlspecialchars($rivi['rekno']) ?></td>
            <td><?= htmlspecialchars($rivi['valmistaja']) ?></td>
            <td><?= htmlspecialchars($rivi['malli']) ?></td>
            <td><?= $rivi['onkoautomaatti'] ? 'Automaatti' : 'Manuaali' ?></td>
            <td><?= htmlspecialchars($rivi['moottori']) ?></td>
            <td><?= $rivi['istumapaikat'] ?></td>
            <td><?= number_format($rivi['hinta'], 2, ',', '') ?> €</td>
            <td><?= $rivi['onkovapaa'] ? 'Kyllä' : 'Ei' ?></td>
        </tr>
        <?php } ?>
    </table>
</body>
</html>
