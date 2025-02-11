document.addEventListener("DOMContentLoaded", function() {
    let tabela = {};

    document.querySelectorAll(".gols").forEach(input => {
        input.addEventListener("input", () => {
            atualizarClassificacao();
        });
    });

    function atualizarClassificacao() {
        tabela = {};
        document.querySelectorAll(".gols").forEach(input => {
            const row = input.closest("tr");
            const timeCasa = row.cells[2].textContent;
            const timeFora = row.cells[4].textContent;
            const golsCasa = parseInt(row.cells[3].querySelectorAll("input")[0].value) || 0;
            const golsFora = parseInt(row.cells[3].querySelectorAll("input")[1].value) || 0;

            [timeCasa, timeFora].forEach(time => {
                if (!tabela[time]) tabela[time] = { pontos: 0, vitorias: 0, saldo: 0 };
            });

            if (golsCasa > golsFora) tabela[timeCasa].pontos += 3, tabela[timeCasa].vitorias++;
            else if (golsCasa < golsFora) tabela[timeFora].pontos += 3, tabela[timeFora].vitorias++;
            else tabela[timeCasa].pontos++, tabela[timeFora].pontos++;

            tabela[timeCasa].saldo += (golsCasa - golsFora);
            tabela[timeFora].saldo += (golsFora - golsCasa);
        });

        console.log(tabela);
    }
});
