#!/bin/bash
set -e

echo "🚀 Iniciando setup automático do Neovim..."

# 1. Dependências do sistema (Debian/Ubuntu)
if command -v apt &> /dev/null; then
    echo "📦 Instalando dependências (build-essential, ripgrep, unzip)..."
    sudo apt update
    sudo apt install -y build-essential unzip ripgrep fd-find xclip curl git
fi

# 2. Baixar e instalar o binário oficial do Neovim
echo "📥 Baixando a versão mais recente do Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
echo "🔧 Instalando em /opt..."
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz

# 3. Baixar a configuração (se ainda não existir)
if [ ! -d "$HOME/.config/nvim" ]; then
    echo "⚙️ Clonando a configuração do nvim do GitHub..."
    mkdir -p "$HOME/.config"
    git clone https://github.com/nato-re/nvim "$HOME/.config/nvim"
else
    echo "✅ Diretório ~/.config/nvim já existe. Pulando clone."
fi

echo "🎉 Setup concluído! Digite 'nvim' para abrir o editor e deixar o LazyVim instalar os plugins."
