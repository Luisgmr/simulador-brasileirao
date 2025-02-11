<?php
require_once 'config.php';
$conn = Config::getConn();
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nome  = $_POST['nome']  ?? '';
    $email = $_POST['email'] ?? '';
    $senha = $_POST['senha'] ?? '';
    if ($nome && $email && $senha) {
        $sql = "INSERT INTO usuarios (nome, email, senha) VALUES (:n, :e, :s)";
        $stmt = $conn->prepare($sql);
        $stmt->execute([
            ':n' => $nome,
            ':e' => $email,
            ':s' => password_hash($senha, PASSWORD_DEFAULT)
        ]);
        header("Location: login.php");
        exit;
    }
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Cadastro</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
  <div class="w-full max-w-sm bg-white p-6 rounded shadow">
    <h1 class="text-2xl font-bold mb-4">Cadastro de Usuário</h1>
    <?php if (isset($_GET['ok'])): ?>
      <p class="text-green-600 mb-4">Usuário cadastrado com sucesso!</p>
    <?php endif; ?>
    <form method="post">
      <label class="block mb-2">
        <span class="text-gray-700">Nome</span>
        <input type="text" name="nome" class="mt-1 block w-full border border-gray-300 rounded px-3 py-2" required>
      </label>
      <label class="block mb-2">
        <span class="text-gray-700">E-mail</span>
        <input type="email" name="email" class="mt-1 block w-full border border-gray-300 rounded px-3 py-2" required>
      </label>
      <label class="block mb-4">
        <span class="text-gray-700">Senha</span>
        <input type="password" name="senha" class="mt-1 block w-full border border-gray-300 rounded px-3 py-2" required>
      </label>
      <button type="submit" class="w-full bg-green-600 text-white py-2 rounded hover:bg-green-700">
        Cadastrar
      </button>
    </form>
    <div class="mt-4 text-center">
      <a href="login.php" class="text-black hover:underline">Já tem conta? Faça login</a>
    </div>
  </div>
</body>
</html>
