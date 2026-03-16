# 🎨 ZSH Setup — Starship Colors

> Configuração completa do ZSH com a paleta **Catppuccin Mocha** — as mesmas cores usadas pelo [Starship](https://starship.rs/) no preset *Pastel Powerline*.

![Shell](https://img.shields.io/badge/shell-zsh-89b4fa?style=flat-square&logo=gnu-bash&logoColor=white)
![Theme](https://img.shields.io/badge/tema-Agnoster-cba6f7?style=flat-square)
![Palette](https://img.shields.io/badge/paleta-Catppuccin%20Mocha-f5c2e7?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-a6e3a1?style=flat-square)

---

## 📸 Paleta de Cores

As cores são baseadas na paleta **Catppuccin Mocha**, a mesma que o Starship usa no seu [Pastel Powerline preset](https://starship.rs/presets/pastel-powerline):

| Cor | Hex | Uso no Terminal |
|-----|-----|-----------------|
| 🟢 Green    | `#a6e3a1` | Comandos válidos, Git limpo |
| 🔵 Blue     | `#89b4fa` | Diretório atual, builtins |
| 🟣 Mauve    | `#cba6f7` | User/Host, palavras reservadas |
| 🟡 Yellow   | `#f9e2af` | Git modificado, opções `--flag` |
| 🔴 Red      | `#f38ba8` | Erros, tokens inválidos |
| 🩵 Sky      | `#89dceb` | Caminhos, links simbólicos |
| 🍑 Peach    | `#fab387` | Variáveis `$VAR` |
| 🩷 Pink     | `#f5c2e7` | Strings entre aspas |
| 💜 Lavender | `#b4befe` | Redirecionamentos `>` `>>` |
| 🩶 Overlay  | `#9399b2` | Comentários `#` |

---

## 📦 O que é instalado

- **[Oh My Zsh](https://ohmyz.sh/)** — framework para configuração do ZSH
- **[MesloLGS NF](https://github.com/romkatv/powerlevel10k#fonts)** — Nerd Font necessária para os ícones Powerline
- **[LSD (LSDeluxe)](https://github.com/lsd-rs/lsd)** — substituição do `ls` com ícones e cores
- **[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)** — highlight de sintaxe em tempo real
- **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)** — sugestões de comandos baseadas no histórico
- **Agnoster Theme** customizado com segmentos Powerline nas cores Catppuccin

---

## ⚡ Requisitos

- Ubuntu / Debian (ou derivados com `apt`)
- ZSH instalado (`sudo apt install zsh`)
- Git instalado
- `curl` e `wget` disponíveis
- Acesso `sudo`

---

## 🚀 Instalação

```bash
# Clone o repositório
git clone https://github.com/gcarvalhomartins/myZsh.git
cd myZsh

# Dê permissão de execução
chmod +x zsh_terminal.sh

# Execute o script
./zsh_terminal.sh
```

> **⚠️ Importante:** Um backup do seu `.zshrc` atual será criado automaticamente em `~/.zshrc.backup.YYYYMMDD_HHMMSS` antes de qualquer alteração.

---

## 🔤 Configurar a Fonte do Terminal

Após a instalação, é **obrigatório** configurar a fonte do seu terminal para **MesloLGS NF**, caso contrário os ícones Powerline não aparecerão corretamente.

### GNOME Terminal
`Preferências → Perfis → Texto → Fonte personalizada → MesloLGS NF Regular`

### Konsole
`Configurações → Editar Perfil Atual → Aparência → Fonte → MesloLGS NF`

### Tilix
`Preferências → Perfil → Geral → Fonte personalizada → MesloLGS NF`

### VS Code (terminal integrado)
```json
"terminal.integrated.fontFamily": "MesloLGS NF"
```

### Windows Terminal (WSL)
```json
"fontFace": "MesloLGS NF"
```

---

## 🎨 Detalhes do Syntax Highlighting

O script configura cada elemento da sintaxe do ZSH com uma cor específica da paleta:

```zsh
# Verde (#a6e3a1) — comando válido
ls -lah

# Vermelho (#f38ba8) — comando inválido
comandoerrado

# Amarelo (#f9e2af) — opções
git commit --message "feat: nova feature"

# Rosa (#f5c2e7) — strings
echo "olá mundo"

# Sky (#89dceb) — caminhos
cd /home/usuario/projetos

# Pêssego (#fab387) — variáveis
echo $HOME $PATH

# Lavanda (#b4befe) — redirecionamentos
cat arquivo.txt > saida.txt

# Cinza (#9399b2, itálico) — comentários
# isso é um comentário
```

---

## 🖥️ Prompt Agnoster Customizado

O prompt usa segmentos Powerline com as cores Catppuccin:

```
╭─ ☁ user@host  ~/projetos/meu-repo   main  ─╮
╰─ $
```

| Segmento | Fundo | Texto | Ícone |
|----------|-------|-------|-------|
| User/Host | Mauve `#cba6f7` | Base `#1e1e2e` | ☁ |
| Diretório | Blue `#89b4fa` | Base `#1e1e2e` | 󰉋 |
| Git limpo | Green `#a6e3a1` | Base `#1e1e2e` |  |
| Git modificado | Yellow `#f9e2af` | Base `#1e1e2e` |  |
| Erro de saída | — | Red `#f38ba8` | ✘ |
| Jobs em bg | — | Sky `#89dceb` | ⚙ |

---

## 📁 Aliases criados

| Alias | Comando | Descrição |
|-------|---------|-----------|
| `ls` | `lsd` | Listagem com ícones |
| `ll` | `lsd -lah` | Listagem detalhada |
| `la` | `lsd -A` | Mostrar arquivos ocultos |
| `l` | `lsd -lh` | Listagem compacta |
| `lt` | `lsd --tree` | Visualização em árvore |
| `tree` | `lsd --tree` | Alias para árvore |

---

## 🔧 Personalização

Para alterar as cores do prompt, edite as funções no `.zshrc`:

```zsh
# Cor do segmento User/Host (padrão: Mauve)
prompt_context() {
    prompt_segment_cat '#cba6f7' '#1e1e2e' "☁ %n@%m"
    #                   ^^^^^^^^ mude esta cor
}

# Cor do segmento de Diretório (padrão: Blue)
prompt_dir() {
    prompt_segment_cat '#89b4fa' '#1e1e2e' "󰉋 %~"
    #                   ^^^^^^^^ mude esta cor
}
```

Para referência completa de todas as cores Catppuccin Mocha, consulte o [repositório oficial](https://github.com/catppuccin/catppuccin).

---

## 🔄 Restaurar backup

Se quiser desfazer as alterações:

```bash
# Liste os backups disponíveis
ls ~/.zshrc.backup.*

# Restaure o mais recente
cp ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc
source ~/.zshrc
```

---

## 🤝 Contribuindo

Pull requests são bem-vindos! Se quiser adicionar suporte a outras distribuições, outros temas ou paletas de cores alternativas, sinta-se à vontade.

---

## 📄 Licença

MIT © [Gabriel Martins](https://github.com/gcarvalhomartins)

---

<p align="center">
  Feito com 💜 usando a paleta <a href="https://catppuccin.com">Catppuccin</a> — inspirado pelo <a href="https://starship.rs">Starship</a>
</p>
