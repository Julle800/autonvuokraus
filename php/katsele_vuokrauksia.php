<?php
require_once('db.php');
$sql = "SELECT s.id, s.aloituspvm, s.lopetuspvm, s.palautettu,
               a.etunimi, a.sukunimi,
               au.rekno, au.valmistaja, au.malli
        FROM sopimus s
        JOIN asiakas a ON s.asiakasid = a.id 
        JOIN auto au ON s.autoid = au.id
        ORDER BY s.aloituspvm DESC";
$tulos = mysqli_query($yhteys, $sql);
?>


<!DOCTYPE html>
<html lang="fi">
<head>
    <title>Autonvuokraus</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

    <h1>Vuokraukset</h1>
    <p><a href="../index.php">Etusivulle</a></p>

    <table>
    <!-- TEE: otsikkorivi -->
     <tr>
        <th>Vuokraaja</th>
        <th>Valmistaja</th>
        <th>Malli</th>
        <th>Aloituspäivä</th>
        <th>Lopetuspäivä</th>
        <th>Tila</th>
     </tr>
    <?php while ($rivi = mysqli_fetch_assoc($tulos)) { ?>
        <tr>
            <td><?= htmlspecialchars($rivi['etunimi'] . " " . $rivi['sukunimi']) ?></td>
            <!-- TEE: auto (valmistaja + malli) ja päivät muodossa d.m.Y -->
            <td><?= htmlspecialchars($rivi["valmistaja"]) ?></td>
            <td><?= htmlspecialchars($rivi["malli"]) ?></td>
            <td><?= htmlspecialchars($rivi["aloituspvm"]) ?></td>
            <td><?= htmlspecialchars($rivi["lopetuspvm"]) ?></td>
            <td>
                <?php if ($rivi['palautettu'] === null) { ?>
                    Vuokrattu
                <?php } else { ?>
                    Palautettu <?= date('d.m.Y', strtotime($rivi['palautettu'])) ?>
                <?php } ?>
            </td>
        </tr>
    <?php } ?>
    </table>
    
    
</body>
</html>
