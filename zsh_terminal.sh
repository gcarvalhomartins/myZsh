#!/bin/bash

# ╔═══════════════════════════════════════════════════════════════╗
# ║      ZSH Setup — Cores Starship Pastel Powerline             ║
# ║      Paleta: Catppuccin Mocha (mesma do site starship.rs)    ║
# ╚═══════════════════════════════════════════════════════════════╝

# --- Paleta Catppuccin Mocha (usada pelo Starship no demo oficial) ---
# Rosewater  #f5e0dc  |  Flamingo  #f2cdcd  |  Pink    #f5c2e7
# Mauve      #cba6f7  |  Red       #f38ba8  |  Maroon  #eba0ac
# Peach      #fab387  |  Yellow    #f9e2af  |  Green   #a6e3a1
# Teal       #94e2d5  |  Sky       #89dceb  |  Sapphire #74c7ec
# Blue       #89b4fa  |  Lavender  #b4befe  |  Text    #cdd6f4
# Subtext1   #bac2de  |  Subtext0  #a6adc8  |  Overlay2 #9399b2
# Surface2   #585b70  |  Surface1  #45475a  |  Surface0 #313244
# Base       #1e1e2e  |  Mantle    #181825  |  Crust   #11111b

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  ZSH + Cores Starship Pastel Powerline           ║${NC}"
echo -e "${BLUE}║  Paleta: Catppuccin Mocha                        ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
echo ""

# ─── Backup do .zshrc atual ───────────────────────────────────────
if [ -f ~/.zshrc ]; then
    echo -e "${YELLOW}📦 Criando backup do .zshrc...${NC}"
    cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
    echo -e "${GREEN}✅ Backup criado!${NC}"
    echo ""
fi

# ─── 1. Oh My Zsh ─────────────────────────────────────────────────
if [ ! -d ~/.oh-my-zsh ]; then
    echo -e "${YELLOW}📥 Instalando Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo -e "${GREEN}✅ Oh My Zsh instalado!${NC}"
else
    echo -e "${GREEN}✅ Oh My Zsh já está instalado!${NC}"
fi
echo ""

# ─── 2. Nerd Font (MesloLGS NF) ───────────────────────────────────
echo -e "${YELLOW}🔤 Instalando Nerd Font (MesloLGS NF)...${NC}"
mkdir -p ~/.local/share/fonts
cd /tmp
wget -q "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
wget -q "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
wget -q "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
wget -q "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
mv "MesloLGS NF"*.ttf ~/.local/share/fonts/ 2>/dev/null || true
fc-cache -f -v > /dev/null 2>&1
echo -e "${GREEN}✅ Nerd Font instalada!${NC}"
echo ""

# ─── 3. LSD (LSDeluxe) ────────────────────────────────────────────
echo -e "${YELLOW}📦 Instalando LSD (LSDeluxe)...${NC}"
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    LSD_ARCH="x86_64-unknown-linux-gnu"
elif [ "$ARCH" = "aarch64" ]; then
    LSD_ARCH="aarch64-unknown-linux-gnu"
else
    LSD_ARCH="x86_64-unknown-linux-gnu"
fi

cd /tmp
LSD_VERSION=$(curl -s https://api.github.com/repos/lsd-rs/lsd/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
wget -q "https://github.com/lsd-rs/lsd/releases/download/v${LSD_VERSION}/lsd-v${LSD_VERSION}-${LSD_ARCH}.tar.gz"
tar -xzf "lsd-v${LSD_VERSION}-${LSD_ARCH}.tar.gz"
sudo mv "lsd-v${LSD_VERSION}-${LSD_ARCH}/lsd" /usr/local/bin/
sudo chmod +x /usr/local/bin/lsd
echo -e "${GREEN}✅ LSD instalado!${NC}"
echo ""

# ─── 4. zsh-autosuggestions (NOVO — estilo Starship) ──────────────
echo -e "${YELLOW}💡 Instalando zsh-autosuggestions...${NC}"
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" --quiet
fi
echo -e "${GREEN}✅ Autosuggestions instalado!${NC}"
echo ""

# ─── 5. zsh-syntax-highlighting ───────────────────────────────────
echo -e "${YELLOW}🎨 Instalando zsh-syntax-highlighting...${NC}"
sudo apt-get update -qq
sudo apt-get install -y zsh-syntax-highlighting -qq
echo -e "${GREEN}✅ Syntax highlighting instalado!${NC}"
echo ""

# ─── 6. Configuração do LSD com cores Catppuccin ──────────────────
echo -e "${YELLOW}⚙️  Configurando LSD (tema Catppuccin)...${NC}"
mkdir -p ~/.config/lsd

cat > ~/.config/lsd/config.yaml << 'LSD_EOF'
classic: false
blocks:
  - permission
  - user
  - group
  - size
  - date
  - name
color:
  when: auto
  theme: custom
date: relative
icons:
  when: auto
  theme: fancy
  separator: " "
layout: grid
sorting:
  column: name
  reverse: false
  dir-grouping: first
total-size: false
hyperlink: never
LSD_EOF

# Cores Catppuccin Mocha para o LSD
mkdir -p ~/.config/lsd
cat > ~/.config/lsd/colors.yaml << 'LSD_COLORS_EOF'
user: 137        # Mauve      (#cba6f7 → ANSI 256)
group: 110       # Sapphire   (#74c7ec → ANSI 256)
permission:
  read: 114      # Green      (#a6e3a1)
  write: 214     # Peach      (#fab387)
  exec: 204      # Red        (#f38ba8)
  exec-sticky: 204
  no-access: 238 # Surface2
date:
  hour-old: 153  # Sky/Teal   (#89dceb)
  day-old: 116
  older: 102
size:
  none: 239
  small: 114     # Green
  medium: 220    # Yellow
  large: 204     # Red
links:
  invalid: 204
  valid: 153
tree-edge: 239
git-status:
  default: 114
  unmodified: 114
  ignored: 239
  new-in-index: 114
  new-in-workdir: 114
  typechange: 220
  deleted: 204
  renamed: 153
  modified: 220
  staged: 114
  conflicted: 204
LSD_COLORS_EOF

echo -e "${GREEN}✅ LSD configurado!${NC}"
echo ""

# ─── 7. Criar o .zshrc completo ───────────────────────────────────
echo -e "${YELLOW}⚙️  Configurando .zshrc com paleta Starship Catppuccin Mocha...${NC}"

cat > ~/.zshrc << 'ZSHRC_EOF'
# ╔══════════════════════════════════════════════════════════╗
# ║  ZSH Config — Paleta Starship / Catppuccin Mocha        ║
# ║                                                          ║
# ║  Cores da paleta (referência):                           ║
# ║  Mauve    #cba6f7  │  Blue     #89b4fa                  ║
# ║  Green    #a6e3a1  │  Yellow   #f9e2af                  ║
# ║  Red      #f38ba8  │  Sky      #89dceb                  ║
# ║  Peach    #fab387  │  Lavender #b4befe                  ║
# ║  Rosewater #f5e0dc │  Pink     #f5c2e7                  ║
# ╚══════════════════════════════════════════════════════════╝

export ZSH="$HOME/.oh-my-zsh"

# ── Tema base ──────────────────────────────────────────────
ZSH_THEME="agnoster"

# ── Plugins ────────────────────────────────────────────────
plugins=(
    git
    docker
    docker-compose
    npm
    node
    python
    pip
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# ══════════════════════════════════════════════════════════
#  SYNTAX HIGHLIGHTING — Paleta Catppuccin Mocha
#  (exatamente as cores que o Starship usa no site oficial)
# ══════════════════════════════════════════════════════════
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # Comandos válidos → Green (#a6e3a1) — igual ao módulo de sucesso do Starship
    ZSH_HIGHLIGHT_STYLES[command]='fg=#a6e3a1,bold'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=#a6e3a1'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa,bold'    # Blue — builtins do shell
    ZSH_HIGHLIGHT_STYLES[function]='fg=#89b4fa'

    # Erros → Red (#f38ba8) — igual ao símbolo de erro do Starship
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'

    # Palavras reservadas (if, for, while...) → Mauve (#cba6f7)
    ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#cba6f7,bold'

    # Separadores (; && || |) → Yellow (#f9e2af) — igual ao módulo de tempo do Starship
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#f9e2af'
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#f9e2af'

    # Caminhos → Sky (#89dceb) com underline — igual ao módulo de directory do Starship
    ZSH_HIGHLIGHT_STYLES[path]='fg=#89dceb,underline'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#89dceb'
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#74c7ec'   # Sapphire para a "/"

    # Globbing (* ? {}) → Mauve (#cba6f7)
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=#cba6f7'

    # Opções (-f --flag) → Yellow (#f9e2af) — destaque suave
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f9e2af'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f9e2af'

    # Strings entre aspas → Pink (#f5c2e7) / Rosewater (#f5e0dc)
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#f5c2e7'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#f5c2e7'
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#f5e0dc'   # Rosewater

    # Expansão de variáveis ($VAR) → Peach (#fab387) — igual ao módulo de env do Starship
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#fab387'
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#fab387'
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#fab387'

    # Redirecionamentos (> >> <) → Lavender (#b4befe)
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=#b4befe'

    # Comentários (#) → Overlay2 (#9399b2) — tom acinzentado, discreto
    ZSH_HIGHLIGHT_STYLES[comment]='fg=#9399b2,italic'

    # Prefixo de precommand (sudo, env) → Green sublinhado
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=#a6e3a1,underline'

    # Atribuição (VAR=valor) → Teal (#94e2d5)
    ZSH_HIGHLIGHT_STYLES[assign]='fg=#94e2d5'
    ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#94e2d5'

    # Pares de parênteses/colchetes → Lavender
    ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#f38ba8,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#b4befe,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#cba6f7,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#89b4fa,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#89dceb,bold'
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=#1e1e2e,bg=#cba6f7'
fi

# ══════════════════════════════════════════════════════════
#  AUTOSUGGESTIONS — cinza suave (Surface2 #585b70)
# ══════════════════════════════════════════════════════════
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#585b70'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ══════════════════════════════════════════════════════════
#  AUTOCOMPLETE — cores Catppuccin
# ══════════════════════════════════════════════════════════
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Cabeçalho das seções de completion → Sky (#89dceb)
zstyle ':completion:*:*:*:*:descriptions' format '%F{#89dceb}── %d ──%f'

# Mensagens de correção → Yellow (#f9e2af)
zstyle ':completion:*:*:*:*:corrections' format '%F{#f9e2af}✗ %d (erros: %e)%f'

# Mensagens gerais → Mauve (#cba6f7)
zstyle ':completion:*:messages' format '%F{#cba6f7}%d%f'

# Aviso de nenhum match → Red (#f38ba8)
zstyle ':completion:*:warnings' format '%F{#f38ba8}✘ sem resultados%f'

# Seleção no menu → fundo Mauve, texto escuro
zstyle ':completion:*:*:*:*:default' list-colors '=(#b):ls=di=01;34'
zstyle ':completion:*' menu select

# ══════════════════════════════════════════════════════════
#  PROMPT AGNOSTER — customizado com cores Catppuccin
#
#  Esquema visual (igual ao Starship Pastel Powerline):
#    [user@host] → bg Mauve  / fg Base
#    [dir]       → bg Blue   / fg Base
#    [git]       → bg Green  / fg Base  (limpo)
#                → bg Yellow / fg Base  (modificado)
#                → bg Red    / fg Base  (conflito)
# ══════════════════════════════════════════════════════════

# Função helper: cria um segmento Powerline colorido
prompt_segment_cat() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
    [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
    if [[ $CURRENT_BG != 'NONE' && $1 != "$CURRENT_BG" ]]; then
        echo -n " %{$bg%F{$CURRENT_BG}%}%{$fg%} "
    else
        echo -n "%{$bg%}%{$fg%} "
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && echo -n $3
}

prompt_end_cat() {
    if [[ -n $CURRENT_BG ]]; then
        echo -n " %{%k%F{$CURRENT_BG}%}%{%f%}"
    else
        echo -n "%{%k%f%}"
    fi
    CURRENT_BG=''
    echo -n " "
}

# Sobrescreve as funções do Agnoster com as cores Catppuccin
prompt_context() {
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        # Mauve (#cba6f7 = cor 183 em 256) + texto Base escuro
        prompt_segment_cat '#cba6f7' '#1e1e2e' "%(!.⚡.☁) %n@%m"
    fi
}

prompt_dir() {
    # Blue (#89b4fa = cor 111) + texto Base escuro
    prompt_segment_cat '#89b4fa' '#1e1e2e' "󰉋 %~"
}

prompt_git() {
    local dirty ref
    if $(git rev-parse --is-inside-work-tree 2>/dev/null); then
        dirty=$(parse_git_dirty)
        ref=$(git symbolic-ref HEAD 2>/dev/null) || \
        ref="➦ $(git rev-parse --short HEAD 2>/dev/null)"
        if [[ -n $dirty ]]; then
            # Yellow (#f9e2af = cor 229) quando há mudanças pendentes
            prompt_segment_cat '#f9e2af' '#1e1e2e' " ${ref/refs\/heads\// }"
        else
            # Green (#a6e3a1 = cor 151) quando está limpo
            prompt_segment_cat '#a6e3a1' '#1e1e2e' " ${ref/refs\/heads\// }"
        fi
    fi
}

prompt_status() {
    local symbols
    symbols=()
    # Código de saída com erro → Red (#f38ba8)
    [[ $RETVAL -ne 0 ]] && symbols+="%{%F{#f38ba8}%}✘"
    # Root → Yellow (#f9e2af)
    [[ $UID -eq 0 ]] && symbols+="%{%F{#f9e2af}%}⚡"
    # Jobs em background → Sky (#89dceb)
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{#89dceb}%}⚙"
    [[ -n "$symbols" ]] && prompt_segment_cat '#313244' default "$symbols"
}

build_prompt() {
    RETVAL=$?
    CURRENT_BG='NONE'
    prompt_status
    prompt_context
    prompt_dir
    prompt_git
    prompt_end_cat
}

PROMPT='%{%f%b%k%}$(build_prompt)'

# ══════════════════════════════════════════════════════════
#  ALIASES — LSD com ícones Nerd Font
# ══════════════════════════════════════════════════════════
alias ls='lsd'
alias ll='lsd -lah'
alias la='lsd -A'
alias l='lsd -lh'
alias lt='lsd --tree'
alias tree='lsd --tree'

# Ferramentas com cor
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# ══════════════════════════════════════════════════════════
#  LS_COLORS — cores Catppuccin para o LSD / ls
#  (diretório=Blue, link=Sky, exec=Green, arquivo=Text)
# ══════════════════════════════════════════════════════════
export LS_COLORS="di=1;38;2;137;180;250:ln=38;2;137;220;235:ex=1;38;2;166;227;161:fi=38;2;205;214;244:*.tar=38;2;243;139;168:*.zip=38;2;243;139;168:*.gz=38;2;243;139;168:*.mp3=38;2;203;166;247:*.mp4=38;2;203;166;247:*.jpg=38;2;245;194;231:*.png=38;2;245;194;231:*.pdf=38;2;250;179;135:*.md=38;2;180;190;254"

ZSHRC_EOF

echo -e "${GREEN}✅ .zshrc configurado!${NC}"
echo ""

echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}  ✨ Instalação completa!                          ${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}⚠️  PRÓXIMOS PASSOS:${NC}"
echo ""
echo -e "  1. Configure a fonte do seu terminal para ${GREEN}MesloLGS NF${NC}"
echo -e "     (necessária para os ícones Powerline e Nerd Font)"
echo ""
echo -e "  2. Reinicie o terminal ou execute:"
echo -e "     ${BLUE}source ~/.zshrc${NC}"
echo ""
echo -e "  3. Paleta de cores usada (Catppuccin Mocha — mesma do Starship):"
echo -e "     Mauve    ${BLUE}#cba6f7${NC}  → User/Host (prompt)"
echo -e "     Blue     ${BLUE}#89b4fa${NC}  → Diretório atual"
echo -e "     Green    ${GREEN}#a6e3a1${NC}  → Git limpo / comandos válidos"
echo -e "     Yellow   ${YELLOW}#f9e2af${NC}  → Git modificado / opções"
echo -e "     Red      ${RED}#f38ba8${NC}  → Erros / tokens inválidos"
echo -e "     Sky      ${BLUE}#89dceb${NC}  → Caminhos / links"
echo -e "     Peach    ${YELLOW}#fab387${NC}  → Variáveis de ambiente"
echo -e "     Pink     ${YELLOW}#f5c2e7${NC}  → Strings entre aspas"
echo ""