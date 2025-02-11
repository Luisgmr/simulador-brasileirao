<?php
// Dados de conexão com o banco
$host   = '100.104.103.66';
$dbname = 'brasileirao';
$user   = 'goat';
$pass   = 'Refacty_db5498!#';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Erro na conexão com o banco de dados: " . $e->getMessage());
}

// ======================================================================
// SIMULAÇÃO: Se o usuário clicar em “Simular Rodada”, atualiza os jogos da próxima rodadaa
// ======================================================================
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['simular'])) {
    // Primeiro, determinamos qual foi a última rodada simulada
    $queryMax = "SELECT MAX(rodada) AS maxRodada FROM partidas WHERE gols_casa IS NOT NULL AND gols_fora IS NOT NULL";
    $stmtMax  = $conn->query($queryMax);
    $resultMax = $stmtMax->fetch(PDO::FETCH_ASSOC);
    $maxRodada = $resultMax['maxRodada'] ? $resultMax['maxRodada'] : 0;
    $rodadaSimular = $maxRodada + 1;

    // Seleciona os jogos da rodada que ainda não foram simulados
    $queryMatches = "SELECT id FROM partidas WHERE rodada = :rodada AND (gols_casa IS NULL OR gols_fora IS NULL)";
    $stmtMatches  = $conn->prepare($queryMatches);
    $stmtMatches->execute([':rodada' => $rodadaSimular]);
    $matchesToSimulate = $stmtMatches->fetchAll(PDO::FETCH_ASSOC);

    // Para cada jogo, gera placares aleatórios (entre 0 e 5) e atualiza o registro
    foreach ($matchesToSimulate as $match) {
        $scoreCasa = rand(0, 5);
        $scoreFora = rand(0, 5);
        $updateQuery = "UPDATE partidas SET gols_casa = :scoreCasa, gols_fora = :scoreFora WHERE id = :id";
        $stmtUpdate  = $conn->prepare($updateQuery);
        $stmtUpdate->execute([
            ':scoreCasa' => $scoreCasa,
            ':scoreFora' => $scoreFora,
            ':id'        => $match['id']
        ]);
    }

    // Após simular, redireciona para evitar reenvio do formulário
    header("Location: " . $_SERVER['PHP_SELF']);
    exit;
}

// ======================================================================
// BUSCA DOS DADOS: Partidas e Times
// ======================================================================

// Consulta todas as partidas (incluindo os jogos já simulados e os pendentes)
$query = "
    SELECT p.id, p.rodada, p.data_partida, 
           p.time_casa_id, p.time_fora_id,
           tc.nome AS time_casa, p.gols_casa, 
           tf.nome AS time_fora, p.gols_fora
    FROM partidas p
    JOIN times tc ON p.time_casa_id = tc.id
    JOIN times tf ON p.time_fora_id = tf.id
    ORDER BY p.rodada, p.data_partida
";
$stmt = $conn->prepare($query);
$stmt->execute();
$partidas = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Busca os times para montar a tabela de classificação
$query_times = "SELECT id, nome FROM times";
$stmt_times  = $conn->prepare($query_times);
$stmt_times->execute();
$teamsData  = $stmt_times->fetchAll(PDO::FETCH_ASSOC);

// Inicializa o array de times com estatísticas zeradas
$teams = [];
foreach ($teamsData as $team) {
    $teams[$team['id']] = [
        'nome'        => $team['nome'],
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

// Calcula as estatísticas com base nos jogos já simulados (ou seja, que já possuem placar)
foreach ($partidas as $partida) {
    if ($partida['gols_casa'] !== null && $partida['gols_fora'] !== null) {
        $idCasa = $partida['time_casa_id'];
        $idFora = $partida['time_fora_id'];

        // Atualiza jogos e gols para o time da casa
        $teams[$idCasa]['jogos']++;
        $teams[$idCasa]['gols_pro']    += $partida['gols_casa'];
        $teams[$idCasa]['gols_contra'] += $partida['gols_fora'];

        // Atualiza jogos e gols para o time visitante
        $teams[$idFora]['jogos']++;
        $teams[$idFora]['gols_pro']    += $partida['gols_fora'];
        $teams[$idFora]['gols_contra'] += $partida['gols_casa'];

        // Define resultado
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

// Calcula o saldo (gols_pro - gols_contra) para cada time
foreach ($teams as $id => &$stats) {
    $stats['saldo'] = $stats['gols_pro'] - $stats['gols_contra'];
}
unset($stats);

// Ordena os times pela classificação (pontos, vitórias, saldo, gols pró)
$teamsList = array_values($teams);
usort($teamsList, function($a, $b) {
    if ($a['pontos'] != $b['pontos']) {
        return $b['pontos'] - $a['pontos'];
    }
    if ($a['vitorias'] != $b['vitorias']) {
        return $b['vitorias'] - $a['vitorias'];
    }
    if ($a['saldo'] != $b['saldo']) {
        return $b['saldo'] - $a['saldo'];
    }
    return $b['gols_pro'] - $a['gols_pro'];
});

// ======================================================================
// Próxima Rodada: Define qual é a próxima rodada e filtra seus jogos
// ======================================================================

// Determina a rodada máxima com placares simulados
$maxPlayedRound = 0;
foreach ($partidas as $partida) {
    if ($partida['gols_casa'] !== null && $partida['gols_fora'] !== null) {
        if ($partida['rodada'] > $maxPlayedRound) {
            $maxPlayedRound = $partida['rodada'];
        }
    }
}
$nextRound = $maxPlayedRound + 1;

// Filtra os jogos da próxima rodada
$nextRoundMatches = array_filter($partidas, function($match) use ($nextRound) {
    return $match['rodada'] == $nextRound;
});
?>
<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Simulador do Brasileirão</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen">
  <header class="bg-green-600 text-white p-4">
    <div class="container mx-auto flex items-center justify-between">
      <div class="text-xl font-bold">Globo Esporte</div>
      <nav class="hidden md:block">
        <ul class="flex space-x-4">
          <li><a href="#" class="hover:underline">Menu</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <main class="container mx-auto px-4 py-6">
    <!-- Título -->
    <h1 class="text-3xl font-bold text-green-700 mb-2">
      BRASILEIRÃO SÉRIE A
    </h1>
    <h2 class="text-2xl font-bold mb-4">Simulador do Brasileirão 2024</h2>

    <p class="mb-8">
      Simule os resultados dos jogos do Brasileirão 2024, e tente adivinhar o
      campeão, quais times vão à Libertadores e à Copa Sul-Americana e quem
      será rebaixado para a Série B.
    </p>

    <!-- Layout em duas colunas (tabela de classificação e próximos jogos) -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
      <!-- Coluna da Tabela de Classificação -->
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
                <tr class="border-b hover:bg-gray-50">
                  <td class="px-4 py-2"><?php echo $pos . "&nbsp;" . htmlspecialchars($team['nome']); ?></td>
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
      </section>

      <!-- Coluna dos Próximos Jogos -->
      <section>
        <h3 class="text-xl font-semibold mb-4">
          <?php echo $nextRound; ?>ª RODADA
        </h3>

        <?php if (!empty($nextRoundMatches)): ?>
          <?php
            // Se existir algum jogo da próxima rodada sem placar definido, mostra o botão para simulação
            $hasUnsimulated = false;
            foreach ($nextRoundMatches as $match) {
              if ($match['gols_casa'] === null || $match['gols_fora'] === null) {
                $hasUnsimulated = true;
                break;
              }
            }
          ?>
          <?php if ($hasUnsimulated): ?>
            <form method="post" class="mb-4">
              <button type="submit" name="simular" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                Simular Rodada
              </button>
            </form>
          <?php endif; ?>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <?php foreach ($nextRoundMatches as $match): ?>
              <div class="border rounded p-4 bg-white shadow">
                <?php 
                  // Formata a data da partida (ajuste conforme sua necessidade)
                  $dataFormatada = date("D d/m/Y", strtotime($match['data_partida']));
                ?>
                <p class="text-sm text-gray-500"><?php echo $dataFormatada; ?></p>
                <p class="text-lg font-semibold mt-2">
                  <?php echo htmlspecialchars($match['time_casa']); ?>
                  <span class="text-blue-500">
                    <?php echo ($match['gols_casa'] !== null) ? $match['gols_casa'] : "-"; ?>
                  </span>
                  x
                  <span class="text-red-500">
                    <?php echo ($match['gols_fora'] !== null) ? $match['gols_fora'] : "-"; ?>
                  </span>
                  <?php echo htmlspecialchars($match['time_fora']); ?>
                </p>
              </div>
            <?php endforeach; ?>
          </div>
        <?php else: ?>
          <p class="text-gray-500">Todas as rodadas foram simuladas.</p>
        <?php endif; ?>
      </section>
    </div>
  </main>

  <footer class="bg-green-600 text-white py-4 mt-8">
    <div class="container mx-auto text-center">
      <p>&copy; 2024 Globo Esporte - Simulador do Brasileirão</p>
    </div>
  </footer>
</body>
</html>
