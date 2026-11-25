<?php
require_once('php/db.php');
?>

<!-- index.php -->
<!DOCTYPE html>
<html lang="fi">
<head>
    <title>Autonvuokraus</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Autonvuokraus</h1>
    <ul>
        <h2>Autot</h2>
        <li><a href="php/katsele_autoja.php">Katsele autoja</a></li>
        <h2>Asiakkaat</h2>
        <li><a href="php/katsele_asiakkaita.php">Katsele asiakkaita</a></li>
        <li><a href="php/lisaa_asiakas.php">Lisää asiakas </a></li>
        <h2>Vuokraukset</h2>
        <li><a href="php/katsele_vuokrauksia.php">Katsele vuokrauksia </a></li>
        <li><a href="php/lisaa_vuokraus.php">Lisää vuokraus </a></li>
        <!-- TEE: linkit muille sivuille, kun ne on tehty -->
    </ul>
</body>
</html>
