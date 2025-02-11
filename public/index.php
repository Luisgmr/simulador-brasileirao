<?php
$host   = '100.104.103.66';
$dbname = 'brasileirao';
$user   = 'goat';
$pass   = 'Refacty_db5498!#';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erro na conexão com o banco de dados: " . $e->getMessage());
}

function gerarConfrontosBrasileirao(PDO $conn) {
    $sqlTimes = "SELECT id FROM times ORDER BY nome";
    $stmtTimes = $conn->query($sqlTimes);
    $allTeams = $stmtTimes->fetchAll(PDO::FETCH_COLUMN);

    $n = count($allTeams);
    if ($n < 2) {
        return;
    }

    $pivo   = array_shift($allTeams);
    $others = $allTeams;
    $m = $n - 1;

    $roundsIda = [];

    for ($roundIndex = 0; $roundIndex < $m; $roundIndex++) {
        $roundMatches = [];
        $pivoCasa = (($roundIndex % 2) == 0);
        $timeForaIndex = count($others) - 1 - $roundIndex;
        if ($timeForaIndex < 0) {
            $timeForaIndex += count($others);
        }
        $timeForaId = $others[$timeForaIndex];

        if ($pivoCasa) {
            $roundMatches[] = ['casa' => $pivo, 'fora' => $timeForaId];
        } else {
            $roundMatches[] = ['casa' => $timeForaId, 'fora' => $pivo];
        }

        $temp = $others;
        array_splice($temp, $timeForaIndex, 1);

        $half = count($temp) / 2;
        $left  = array_slice($temp, 0, $half);
        $right = array_slice($temp, $half);
        $right = array_reverse($right);

        for ($i = 0; $i < $half; $i++) {
            $teamA = $left[$i];
            $teamB = $right[$i];
            if ($roundIndex % 2 == 0) {
                $roundMatches[] = [ 'casa' => $teamA, 'fora' => $teamB ];
            } else {
                $roundMatches[] = [ 'casa' => $teamB, 'fora' => $teamA ];
            }
        }

        $roundsIda[] = $roundMatches;
        $last = array_pop($others);
        array_unshift($others, $last);
    }

    $roundsVolta = [];
    foreach ($roundsIda as $rodada) {
        $rodadaVolta = [];
        foreach ($rodada as $partida) {
            $rodadaVolta[] = [
                'casa' => $partida['fora'],
                'fora' => $partida['casa']
            ];
        }
        $roundsVolta[] = $rodadaVolta;
    }

    $dataInicial = new DateTime('2024-04-01 15:00:00');
    $intervalo   = new DateInterval('P3D');
    $stmtInsert = $conn->prepare("
       INSERT INTO partidas
       (time_casa_id, time_fora_id, rodada, data_partida, gols_casa, gols_fora, campeonato)
       VALUES
       (:casa, :fora, :rodada, :data_partida, NULL, NULL, 'Brasileirao2024')
    ");

    $rodadaNumero = 1;
    $dataPartida  = clone $dataInicial;

    foreach ($roundsIda as $roundMatches) {
        foreach ($roundMatches as $partida) {
            $stmtInsert->execute([
                ':casa'         => $partida['casa'],
                ':fora'         => $partida['fora'],
                ':rodada'       => $rodadaNumero,
                ':data_partida' => $dataPartida->format('Y-m-d H:i:s')
            ]);
        }
        $dataPartida->add($intervalo);
        $rodadaNumero++;
    }
    foreach ($roundsVolta as $roundMatches) {
        foreach ($roundMatches as $partida) {
            $stmtInsert->execute([
                ':casa'         => $partida['casa'],
                ':fora'         => $partida['fora'],
                ':rodada'       => $rodadaNumero,
                ':data_partida' => $dataPartida->format('Y-m-d H:i:s')
            ]);
        }
        $dataPartida->add($intervalo);
        $rodadaNumero++;
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['reset'])) {
    $conn->exec("TRUNCATE TABLE partidas");
    gerarConfrontosBrasileirao($conn);
    header("Location: " . $_SERVER['PHP_SELF']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['simularRodada'])) {
    $sqlSim = "SELECT id FROM partidas WHERE rodada = :rodada AND (gols_casa IS NULL OR gols_fora IS NULL)";
    $stmtSim = $conn->prepare($sqlSim);
    $stmtSim->execute([':rodada' => $_POST['rodadaAtual'] ?? 1]);
    $matchesSim = $stmtSim->fetchAll(PDO::FETCH_ASSOC);

    foreach ($matchesSim as $m) {
        $gc = rand(0,5);
        $gf = rand(0,5);
        $u = $conn->prepare("UPDATE partidas SET gols_casa = :gc, gols_fora = :gf WHERE id = :id");
        $u->execute([':gc'=>$gc, ':gf'=>$gf, ':id'=>$m['id']]);
    }
    $r = $_POST['rodadaAtual'] ?? 1;
    header("Location: " . $_SERVER['PHP_SELF']."?rodada=".$r);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'updatePlacar') {
    $matchId  = $_POST['match_id']  ?? null;
    $golsCasa = $_POST['gols_casa'] ?? null;
    $golsFora = $_POST['gols_fora'] ?? null;

    if ($matchId !== null && $golsCasa !== null && $golsFora !== null) {
        $gc = (int)$golsCasa;
        $gf = (int)$golsFora;
        if ($gc < 0) { $gc = 0; }
        if ($gf < 0) { $gf = 0; }

        $sql = "UPDATE partidas 
                   SET gols_casa = :c, gols_fora = :f 
                 WHERE id = :id";
        $stmt = $conn->prepare($sql);
        $stmt->execute([
            ':c'  => $gc,
            ':f'  => $gf,
            ':id' => (int)$matchId
        ]);

        echo json_encode(['status' => 'ok']);
        exit;
    }
    echo json_encode(['status' => 'error', 'message' => 'Parâmetros inválidos']);
    exit;
}

$stmtMinMax = $conn->query("SELECT MIN(rodada) AS minRod, MAX(rodada) AS maxRod FROM partidas");
$resMinMax  = $stmtMinMax->fetch(PDO::FETCH_ASSOC);
$minRodada  = $resMinMax['minRod'] ? (int)$resMinMax['minRod'] : 1;
$maxRodada  = $resMinMax['maxRod'] ? (int)$resMinMax['maxRod'] : 1;

$selectedRound = isset($_GET['rodada']) ? (int)$_GET['rodada'] : $minRodada;
$selectedRound = max($minRodada, min($selectedRound, $maxRodada));

$queryPartidas = "
    SELECT p.id, p.rodada, p.data_partida,
           p.time_casa_id, p.time_fora_id,
           tc.sigla AS time_casa_sigla, tc.escudo AS escudo_casa,
           tf.sigla AS time_fora_sigla, tf.escudo AS escudo_fora,
           p.gols_casa, p.gols_fora
      FROM partidas p
      JOIN times tc ON p.time_casa_id = tc.id
      JOIN times tf ON p.time_fora_id = tf.id
     ORDER BY p.rodada, p.data_partida
";
$stmtAllMatches = $conn->prepare($queryPartidas);
$stmtAllMatches->execute();
$allMatches = $stmtAllMatches->fetchAll(PDO::FETCH_ASSOC);

$selectedRoundMatches = array_filter($allMatches, function($m) use ($selectedRound) {
    return $m['rodada'] == $selectedRound;
});

$sqlTimes = "SELECT id, nome, sigla, escudo FROM times";
$stmtTimes = $conn->query($sqlTimes);
$timesData = $stmtTimes->fetchAll(PDO::FETCH_ASSOC);

$teams = [];
foreach ($timesData as $t) {
    $teams[$t['id']] = [
        'nome'        => $t['nome'],
        'sigla'       => $t['sigla'],
        'escudo'      => $t['escudo'],
        'pontos'      => 0,
        'jogos'       => 0,
        'vitorias'    => 0,
        'empates'     => 0,
        'derrotas'    => 0,
        'gols_pro'    => 0,
        'gols_contra' => 0,
        'saldo'       => 0
    ];
}

foreach ($allMatches as $partida) {
    if ($partida['gols_casa'] !== null && $partida['gols_fora'] !== null) {
        $idCasa = $partida['time_casa_id'];
        $idFora = $partida['time_fora_id'];

        $teams[$idCasa]['jogos']++;
        $teams[$idFora]['jogos']++;

        $teams[$idCasa]['gols_pro']    += $partida['gols_casa'];
        $teams[$idCasa]['gols_contra'] += $partida['gols_fora'];
        $teams[$idFora]['gols_pro']    += $partida['gols_fora'];
        $teams[$idFora]['gols_contra'] += $partida['gols_casa'];

        if ($partida['gols_casa'] > $partida['gols_fora']) {
            $teams[$idCasa]['vitorias']++;
            $teams[$idCasa]['pontos'] += 3;
            $teams[$idFora]['derrotas']++;
        } elseif ($partida['gols_casa'] < $partida['gols_fora']) {
            $teams[$idFora]['vitorias']++;
            $teams[$idFora]['pontos'] += 3;
            $teams[$idCasa]['derrotas']++;
        } else {
            $teams[$idCasa]['empates']++;
            $teams[$idCasa]['pontos'] += 1;
            $teams[$idFora]['empates']++;
            $teams[$idFora]['pontos'] += 1;
        }
    }
}

foreach ($teams as $id => &$stats) {
    $stats['saldo'] = $stats['gols_pro'] - $stats['gols_contra'];
}
unset($stats);

$teamsList = array_values($teams);
usort($teamsList, function($a, $b) {
    if ($a['pontos'] !== $b['pontos']) {
        return $b['pontos'] - $a['pontos'];
    }
    if ($a['vitorias'] !== $b['vitorias']) {
        return $b['vitorias'] - $a['vitorias'];
    }
    if ($a['saldo'] !== $b['saldo']) {
        return $b['saldo'] - $a['saldo'];
    }
    return $b['gols_pro'] - $a['gols_pro'];
});
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Simulador do Brasileirão</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen">

<header class="bg-green-600 text-white p-4 mb-6">
    <div class="container mx-auto flex items-center justify-between">
        <div class="text-xl font-bold">REFACTY Simulador</div>
        <nav>
            <ul class="flex space-x-4">
                <li><a target="_blank" href="https://gooat.com.br" class="hover:underline">Outros projetos</a></li>
            </ul>
        </nav>
    </div>
</header>

<main class="container mx-auto px-4">
    <h1 class="text-3xl font-bold text-green-700 mb-2">BRASILEIRÃO SÉRIE A</h1>
    <h2 class="text-2xl font-bold mb-4">Simulador do Brasileirão 2024</h2>
    <p class="mb-8">
        Simule os resultados dos jogos do Brasileirão 2024, definindo manualmente
        os gols de cada partida. Descubra quem será campeão, quem vai às competições
        continentais e quem cai para a Série B!
    </p>

    <div class="flex items-center space-x-4 mb-4">
        <form method="post"
              onsubmit="return confirm('Tem certeza que deseja resetar o campeonato (apagar todos os jogos)?')">
            <button type="submit" name="reset"
                    class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                Resetar Campeonato
            </button>
        </form>

        <form method="post">
            <input type="hidden" name="rodadaAtual" value="<?php echo $selectedRound; ?>">
            <button type="submit" name="simularRodada"
                    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                Simular Rodada
            </button>
        </form>

        <?php if ($minRodada < $maxRodada): ?>
            <div class="flex items-center space-x-2">
                <?php if ($selectedRound > $minRodada): ?>
                    <a href="?rodada=<?php echo ($selectedRound - 1); ?>"
                       class="bg-gray-300 hover:bg-gray-400 text-black font-bold py-2 px-3 rounded">
                        &larr; Rodada Anterior
                    </a>
                <?php endif; ?>

                <span class="font-semibold">Rodada <?php echo $selectedRound; ?></span>

                <?php if ($selectedRound < $maxRodada): ?>
                    <a href="?rodada=<?php echo ($selectedRound + 1); ?>"
                       class="bg-gray-300 hover:bg-gray-400 text-black font-bold py-2 px-3 rounded">
                        Próxima Rodada &rarr;
                    </a>
                <?php endif; ?>
            </div>
        <?php endif; ?>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <section>
            <h3 class="text-xl font-semibold mb-4">Tabela</h3>
            <div class="overflow-x-auto border rounded shadow bg-white">
                <table class="min-w-full table-auto">
                    <thead class="bg-gray-100">
                    <tr>
                        <th class="px-4 py-2 text-left">Classificação</th>
                        <th class="px-4 py-2 text-left">P</th>
                        <th class="px-4 py-2 text-left">J</th>
                        <th class="px-4 py-2 text-left">V</th>
                        <th class="px-4 py-2 text-left">SG</th>
                        <th class="px-4 py-2 text-left">GP</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php $pos = 1; ?>
                    <?php foreach ($teamsList as $team): ?>
                        <?php
                        $rowClass = '';
                        if ($pos >= 1 && $pos <= 4) {
                            $rowClass = 'bg-blue-100';
                        } elseif ($pos >= 5 && $pos <= 6) {
                            $rowClass = 'bg-cyan-100';
                        } elseif ($pos >= 7 && $pos <= 12) {
                            $rowClass = 'bg-green-100';
                        } elseif ($pos >= 17) {
                            $rowClass = 'bg-red-100';
                        }
                        ?>
                        <tr class="border-b hover:bg-gray-50 <?php echo $rowClass; ?>">
                            <td class="px-4 py-2">
                                <div class="flex items-center">
                                    <?php if (!empty($team['escudo'])): ?>
                                        <img src="<?php echo htmlspecialchars($team['escudo']); ?>"
                                             alt="escudo" class="w-5 h-5 mr-2" />
                                    <?php endif; ?>
                                    <span class="truncate"><?php echo $pos . " " . htmlspecialchars($team['nome']); ?></span>
                                </div>
                            </td>
                            <td class="px-4 py-2"><?php echo $team['pontos']; ?></td>
                            <td class="px-4 py-2"><?php echo $team['jogos']; ?></td>
                            <td class="px-4 py-2"><?php echo $team['vitorias']; ?></td>
                            <td class="px-4 py-2"><?php echo $team['saldo']; ?></td>
                            <td class="px-4 py-2"><?php echo $team['gols_pro']; ?></td>
                        </tr>
                        <?php $pos++; ?>
                    <?php endforeach; ?>
                    </tbody>
                </table>
            </div>

            <div class="mt-4 space-y-2">
                <div class="flex items-center space-x-2">
                    <span class="inline-block w-4 h-4 bg-blue-100 border border-blue-300"></span>
                    <span>Libertadores (1º a 4º)</span>
                </div>
                <div class="flex items-center space-x-2">
                    <span class="inline-block w-4 h-4 bg-cyan-100 border border-cyan-300"></span>
                    <span>Pré-Libertadores (5º e 6º)</span>
                </div>
                <div class="flex items-center space-x-2">
                    <span class="inline-block w-4 h-4 bg-green-100 border border-green-300"></span>
                    <span>Sul-Americana (7º a 12º)</span>
                </div>
                <div class="flex items-center space-x-2">
                    <span class="inline-block w-4 h-4 bg-red-100 border border-red-300"></span>
                    <span>Rebaixamento (17º em diante)</span>
                </div>
            </div>
        </section>

        <section>
            <h3 class="text-xl font-semibold mb-4"><?php echo $selectedRound; ?>ª Rodada</h3>
            <?php if (!empty($selectedRoundMatches)): ?>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <?php
                    setlocale(LC_TIME, 'pt_BR.utf8');
                    foreach ($selectedRoundMatches as $match):
                        $dt = new DateTime($match['data_partida']);
                        $dataFormatada = strftime("%a %d/%m/%Y", $dt->getTimestamp());
                        $valorCasa = ($match['gols_casa'] === null) ? '' : $match['gols_casa'];
                        $valorFora = ($match['gols_fora'] === null) ? '' : $match['gols_fora'];
                        ?>
                        <div class="border rounded p-4 bg-white shadow flex flex-col space-y-2">
                            <p class="text-sm text-gray-500"><?php echo $dataFormatada; ?></p>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center space-x-1">
                                    <?php if (!empty($match['escudo_casa'])): ?>
                                        <img src="<?php echo htmlspecialchars($match['escudo_casa']); ?>"
                                             alt="escudo casa" class="w-5 h-5" />
                                    <?php endif; ?>
                                    <span class="font-semibold text-lg">
                                        <?php echo htmlspecialchars($match['time_casa_sigla']); ?>
                                    </span>
                                </div>

                                <input type="number"
                                       min="0"
                                       class="w-12 border rounded px-2 text-center mx-1"
                                       value="<?php echo $valorCasa; ?>"
                                       oninput="handleInput(this, <?php echo $match['id']; ?>, 'casa')">

                                <span class="mx-2">x</span>

                                <input type="number"
                                       min="0"
                                       class="w-12 border rounded px-2 text-center mx-1"
                                       value="<?php echo $valorFora; ?>"
                                       oninput="handleInput(this, <?php echo $match['id']; ?>, 'fora')">

                                <div class="flex items-center space-x-1">
                                    <?php if (!empty($match['escudo_fora'])): ?>
                                        <img src="<?php echo htmlspecialchars($match['escudo_fora']); ?>"
                                             alt="escudo fora" class="w-5 h-5" />
                                    <?php endif; ?>
                                    <span class="font-semibold text-lg ml-2">
                                        <?php echo htmlspecialchars($match['time_fora_sigla']); ?>
                                    </span>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                <p class="text-gray-500">Não há jogos para esta rodada (ou todas as rodadas foram geradas?).</p>
            <?php endif; ?>
        </section>
    </div>
</main>

<footer class="bg-green-600 text-white py-4 mt-8">
    <div class="container mx-auto text-center">
        <p>&copy; Refacty 2025 - Simulador do Brasileirão</p>
    </div>
</footer>

<script>
    let debounceTimer = null;
    let matchScores = {};

    function handleInput(inputElem, matchId, tipo) {
        let val = parseInt(inputElem.value, 10);
        if (isNaN(val) || val < 0) {
            val = 0;
        }
        if (val < 0) {
            val = 0;
            inputElem.value = 0;
        }

        if (!matchScores[matchId]) {
            matchScores[matchId] = { casa: null, fora: null };
        }
        if (tipo === 'casa') {
            if (inputElem.value.trim() === '') {
                matchScores[matchId].casa = null;
            } else {
                matchScores[matchId].casa = val;
            }
        } else {
            if (inputElem.value.trim() === '') {
                matchScores[matchId].fora = null;
            } else {
                matchScores[matchId].fora = val;
            }
        }

        if (matchScores[matchId].casa !== null && matchScores[matchId].fora !== null) {
            clearTimeout(debounceTimer);
            debounceTimer = setTimeout(() => {
                updatePlacar(matchId, matchScores[matchId].casa, matchScores[matchId].fora);
            }, 900);
        }
    }

    function updatePlacar(matchId, golsCasa, golsFora) {
        const formData = new FormData();
        formData.append('action', 'updatePlacar');
        formData.append('match_id', matchId);
        formData.append('gols_casa', golsCasa);
        formData.append('gols_fora', golsFora);

        fetch('<?php echo $_SERVER["PHP_SELF"]; ?>', {
            method: 'POST',
            body: formData
        })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'ok') {
                    location.reload();
                } else {
                    console.error('Erro ao atualizar placar:', data.message || '');
                }
            })
            .catch(err => console.error(err));
    }
</script>

</body>
</html>
