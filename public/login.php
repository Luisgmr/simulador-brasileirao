<?php
session_start();
require_once 'config.php';

$conn = Config::getConn();


$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $senha = $_POST['senha'] ?? '';
    if ($email && $senha) {
        $sql = "SELECT id, nome, email, senha FROM usuarios WHERE email = :email";
        $stmt = $conn->prepare($sql);
        $stmt->execute([':email' => $email]);
        $userData = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($userData && password_verify($senha, $userData['senha'])) {
            $_SESSION['usuario_id']   = $userData['id'];
            $_SESSION['usuario_nome'] = $userData['nome'];
            header("Location: index.php");
            exit;
        } else {
            $error = 'E-mail ou senha inválidos';
        }
    } else {
        $error = 'Preencha todos os campos';
    }
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
  <div class="w-full max-w-sm bg-white p-6 rounded shadow">
    <h1 class="text-2xl font-bold mb-4">Login</h1>
    <?php if ($error): ?>
      <p class="text-red-600 mb-4"><?php echo $error; ?></p>
    <?php endif; ?>
    <form method="post">
      <label class="block mb-2">
        <span class="text-gray-700">E-mail</span>
        <input type="email" name="email" class="mt-1 block w-full border border-gray-300 rounded px-3 py-2" required>
      </label>
      <label class="block mb-4">
        <span class="text-gray-700">Senha</span>
        <input type="password" name="senha" class="mt-1 block w-full border border-gray-300 rounded px-3 py-2" required>
      </label>
      <button type="submit" class="w-full bg-green-600 text-white py-2 rounded hover:bg-green-700">
        Entrar
      </button>

      <div class="mt-4 text-center">
      <a href="cadastro.php" class="text-black hover:underline">Não tem conta? Crie sua conta</a>
    </div>
    </form>
  </div>
</body>
</html>
