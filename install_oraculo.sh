#!/bin/bash

echo "📢 Iniciando instalação do Oráculo..."

# 🔄 Atualiza e instala pacotes essenciais
pkg update -y && pkg upgrade -y
pkg install python git wget curl nano -y

# 📥 Clonando repositório do Oráculo
cd ~
if [ -d "Oraculo" ]; then
    echo "🔄 Atualizando repositório existente..."
    cd Oraculo && git pull
else
    echo "🌍 Clonando repositório do Oráculo..."
    git clone https://github.com/pauloricardodeleao/Oraculo.git
    cd Oraculo
fi

# 🔎 Renomeia arquivos .txt para .py, se necessário
for file in *.txt; do
    if [ -f "$file" ]; then
        mv "$file" "${file%.txt}.py"
        echo "✅ Arquivo $file renomeado para ${file%.txt}.py"
    fi
done

# 📦 Instala bibliotecas Python necessárias
if [ -f "requirements.txt" ]; then
    echo "📦 Instalando bibliotecas do Python..."
    pip install -r requirements.txt
else
    echo "⚠️ Nenhum arquivo requirements.txt encontrado!"
fi

# 🚀 Executa o código principal (altere se necessário)
if ls *.py 1> /dev/null 2>&1; then
    MAIN_SCRIPT=$(ls *.py | head -n 1)
    echo "🚀 Executando $MAIN_SCRIPT..."
    python "$MAIN_SCRIPT"
else
    echo "❌ Nenhum script Python encontrado para executar!"
fi

echo "✅ INSTALAÇÃO E EXECUÇÃO FINALIZADAS!"
